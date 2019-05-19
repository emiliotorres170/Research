function tau = ALESmod(ns,sp,nx,N,var,hij,S,delt,nd)

nsh =   floor(ns/2);
M   =   size(var,1)*ns*ns*ns;
Nc=0;
%% This formula will have repetitions for all  N > 2. But it works for 1 and 2.
for n=0:N
    Nc=Nc+nchoosek(M+n-1,n);    
end

%% If non-dimensionalization is switched off, then set S and delt to 1.
if (nd==0)
   S=1; 
   delt=1;
end

% Create nonlinear combination array
tic
tau = zeros(nx(1),6,nx(2),nx(3));
parfor ix=1+sp*nsh:nx(1)-sp*nsh %There is no skip now. It runs for all the interior points.
    taut=zeros(6,nx(2),nx(3));
    V   =zeros(1,Nc);
    for jx=1+sp*nsh:nx(2)-sp*nsh
        for kx=1+sp*nsh:nx(3)-sp*nsh                          
            vart=reshape(var(:,ix-sp*nsh:sp:ix+sp*nsh,...
                               jx-sp*nsh:sp:jx+sp*nsh,...
                               kx-sp*nsh:sp:kx+sp*nsh),M,1);                                  
            inc=1;
            %0th order       
            V(inc)=delt^2*S^2; inc=inc+1;
            %1st order
            if (N>=1)
                for m1=1:M
                    V(inc)=delt*S*vart(m1); inc=inc+1;
                end %m1
            end
            %2nd order
            if (N>=2)
                for m1=1:M
                    for m2=m1:M
                        V(inc)=vart(m1)*vart(m2); inc=inc+1;
                    end
                end
            end        
            for ij=1:6
                taut(ij,jx,kx)=V*hij(:,ij);
            end
        end %kx    
    end %jx
    tau(ix,:,:,:)=taut;
end %ix
tau=permute(tau,[2,1,3,4]);
disp('tau(1,15,24,10)')
tau(1,15,24,10)
toc

end

