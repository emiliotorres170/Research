function [Eu,Ev,Ew]=energySpectra(var,nx,nxc)

kmax=round(sqrt((1-nxc(1))^2+(1-nxc(2))^2+(1-nxc(3))^2))+1;
Eu=zeros(kmax,1);
Ev=zeros(kmax,1);
Ew=zeros(kmax,1);

disp('Calculating Eu')
P=abs(fftshift(fftn(squeeze(var(1,:,:,:))))).^2;
for i=1:nx(1)
    for j=1:nx(2)
        for k=1:nx(3)
            km=round(sqrt((i-nxc(1))^2+(j-nxc(2))^2+(k-nxc(3))^2))+1;
            Eu(km)=Eu(km)+P(i,j,k);
        end
    end
end

disp('Calculating Ev')
P=abs(fftshift(fftn(squeeze(var(2,:,:,:))))).^2;
for i=1:nx(1)
    for j=1:nx(2)
        for k=1:nx(3)
            km=round(sqrt((i-nxc(1))^2+(j-nxc(2))^2+(k-nxc(3))^2))+1;
            Ev(km)=Ev(km)+P(i,j,k);
        end
    end
end

disp('Calculating Ew')
P=abs(fftshift(fftn(squeeze(var(3,:,:,:))))).^2;
for i=1:nx(1)
    for j=1:nx(2)
        for k=1:nx(3)
            km=round(sqrt((i-nxc(1))^2+(j-nxc(2))^2+(k-nxc(3))^2))+1;
            Ew(km)=Ew(km)+P(i,j,k);
        end
    end
end
clear P;

end