function filt=createFilter(nx,nxc,fc)
%=========================================================================%
% Purpose:
%   The purpose of this function is used to create a filter.
%   Inputs:
%       1. nx   --> Number of grid points (array: Nx, Ny, Nz)
%       2. nxc  --> Array of filter center (array: Nx, Ny, Nz) (I am
%                   assuming)
%       3. fc   --> Filter cutoff (scalar)
% Author:
%   Prof. Hamlington
%=========================================================================%

%=========================================================================%
% Generating the filter                                                   %
%=========================================================================%
filt=zeros(nx);
for i=1:nx(1)
    for j=1:nx(2)
        for k=1:nx(3)
            if (sqrt((i-nxc(1))^2+(j-nxc(2))^2+(k-nxc(3))^2)<=fc)
                filt(i,j,k)=1;
            end
        end
    end
end

end
