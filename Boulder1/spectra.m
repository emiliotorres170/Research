close all;
clear all;
clc;
    
%% Full data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dat =   'jhu';
disp('Read in data')
[var,nx,lx,nt]=dataRead(dat);                               % load data
nxc     =   nx./2+1;                                        % grid centerpoints
disp('Calculate spectra')
[Eu,Ev,Ew]=energySpectra(var,nx,nxc);                       % velocity spectra
Ek=Eu+Ev+Ew;                                                % energy spectrum 
clear var;

%% Slice data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dat =   'jhu_slc';
disp('Read in data')
[var,nx,lx,nt]=dataRead(dat);                               % load data
nxc     =   nx./2+1;                                        % grid centerpoints
disp('Calculate spectra')
[Eu,Ev,Ew]=energySpectra(var,nx,nxc);                       % velocity spectra
Eks=Eu+Ev+Ew;                                               % energy spectrum

%% Interpolated data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dat =   'jhu_int';
disp('Read in data')
[var,nx,lx,nt]=dataRead(dat);                               % load data
nxc     =   nx./2+1;                                        % grid centerpoints
disp('Calculate spectra')
[Eu,Ev,Ew]=energySpectra(var,nx,nxc);                       % velocity spectra
Eki=Eu+Ev+Ew;                                               % energy spectrum

%% Reduced data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dat =   'jhu_red';
disp('Read in data')
[var,nx,lx,nt]=dataRead(dat);                               % load data
nxc     =   nx./2+1;                                        % grid centerpoints
disp('Calculate spectra')
[Eu,Ev,Ew]=energySpectra(var,nx,nxc);                       % velocity spectra
Ekr=Eu+Ev+Ew;                                               % energy spectrum

%%
figure(1)
clf;
loglog(Ek./Ek(2),'-k')
hold on;
loglog(Eks./Eks(2),'-r')
loglog(Eki./Eki(2),'-.b')
loglog(Ekr./Ekr(2),'--g')
hold off;
%axis([1,500,1e5,1e20])