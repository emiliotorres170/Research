function hij = ALESoptTik(lam,ns,sp,nx,nsk,N,var,tau,S,delt,nd)

% Calculate number of terms in expansion
M=size(var,1)*ns*ns*ns;
Nc=0;
for n=0:N
    Nc=Nc+nchoosek(M+n-1,n);
end

if (nd==0)
   S=1; 
   delt=1;
end

% Create nonlinear combination array
nsh=floor(ns/2);
P=length(1+sp*nsh:nsk:nx(1)-sp*nsh)* ... 
  length(1+sp*nsh:nsk:nx(2)-sp*nsh)* ... 
  length(1+sp*nsh:nsk:nx(3)-sp*nsh);
Tij=zeros(P,6);% Number of stencil-center points (25^3)
V=zeros(P,Nc);
p=1;
tic
for ix=1+sp*nsh:nsk:nx(1)-sp*nsh
    for jx=1+sp*nsh:nsk:nx(2)-sp*nsh
        for kx=1+sp*nsh:nsk:nx(3)-sp*nsh     
            Tij(p,:)=squeeze(tau(:,ix,jx,kx));
            vart=reshape(var(:,ix-sp*nsh:sp:ix+sp*nsh,...
                               jx-sp*nsh:sp:jx+sp*nsh,...
                               kx-sp*nsh:sp:kx+sp*nsh),M,1);%(27x3)x1                   
            inc=1;            
            %0th order: quantities chosen for dimensional consistency    
            V(p,inc)=delt^2*S^2; inc=inc+1;
            %1st order
            if (N>=1)
                for m1=1:M
                    V(p,inc)=delt*S*vart(m1); inc=inc+1;
                end %m1
            end
            %2nd order -> This one to be used right now.
            % Run thorugh all points in the 3x3x3 stencil and 
            % in each stencil for all quantities (3 in this case); This is
            % represented by M. So two pointers run from 1:M and compute
            % the second order products. 
            if (N>=2)
                for m1=1:M
                    for m2=m1:M
                        V(p,inc)=vart(m1)*vart(m2); inc=inc+1;
                    end
                end
            end         
            p=p+1;          
        end %ix
    end %jx
end %kx
toc
% Check V matrix:
disp('V(1,2...5)')
V(1,2),V(1,3),V(1,4),V(1,5)
disp('V(2,6)')
V(2,6)
% CHECK T MATRIX:
disp('Tij(1,1...5)')
Tij(1,1),Tij(2,1),Tij(3,1)

% tic
% [u,s,v]=svd(V);
% 
% disp('s(1),s(2),s(3)')
% s(1:3)
% disp('v(2,2),v(3,2)')
% v(2,2),v(3,2)
% 
% si=diag(s);
% [rows,cols]=size(s);
% di=si./(si.^2+lam^2);
% d=diag(di);
% d=[d, zeros(cols, rows-cols)];
% Vinv=v*d*u';
% toc

A =(V'*V)+(lam*eye(Nc));
b = V'*Tij;
hij = A\b;

% hij=zeros(Nc,6);
% for ij=1:6
%     hij(:,ij)=Vinv*squeeze(Tij(:,ij));

%Check h_ij:
% if (ij==1)
disp('h1,h20,h350')
hij(1,1)
hij(20,1)
hij(350,1)
% end

% end

end

