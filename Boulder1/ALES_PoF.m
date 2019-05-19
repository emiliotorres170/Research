close all;
clear all;
clc;

%% Set parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dat =   'jhu256';                           % data identifier
fdir=   './run47/';                         % figure directory
lamm= [  0.1,0.05, 0.1, 0.5,   1,   5];      % regularization
nskm= [  10,   8,   8,   8,   8,   8];      % test data space  
nsm = [   3,   3,   3,   3,   3,   3];      % stencil size
flm = [  40,  40,  40,  40,  40,  40];      % LES scale
ftm = [  20,  20,  20,  20,  20,  20];      % test scale
splm= [   1,   2,   2,   2,   2,   2];      % LES scale stencil spacing
ndfm= [   0,   0,   0,   0,   0,   0];      % variable nondimensionalization (0=no, 1=yes)
%nc=length(lamm);
nc=1;    

%% Read in data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Read in data')
[var,nx,lx,nt]=dataRead(dat);                           % load data

disp('Velocities')
disp('u_2(1,2,23),u(1,2,47)')
format long;
var(2,1,2,23),var(2,1,2,47)


%% Calculate derived quantities %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nxc     =   nx./2+1;                                    % grid centerpoints
dx      =   lx./nx;                                     % grid spacing   
ks      =   ceil(nx(3)/2);                              % plot slice
nv      =   size(var,1);                                % number of vars
x       =   linspace(0,lx(1),nx(1));                    % x grid
y       =   linspace(0,lx(2),nx(2));                    % y grid
z       =   linspace(0,lx(3),nx(3));                    % z grid

%% Set universal figure and analysis parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%
nbins=250;                                              % number of bins
pfnt=9;                                                 % tick font size
lfnt=10;                                                % label font size
lwid=2;                                                 % default line wid
cmap='jet';                                             % default colormap
vizSlice1 = 64 ; vizSlice2 = 128 ; vizSlice3 = 192;
clims = [-20 20];
%% Energy spectra %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% disp('Calculate energy spectra')
% [Eu,Ev,Ew]=energySpectra(var,nx,nxc);                   % velocity spectra
% Ek=Eu+Ev+Ew;                                            % energy spectrum  
% figure1

%stop

%% Initialize arrays %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Initialize arrays')
initialArray                                            % initialize arrays

%% Loop over cases %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for ic=1:nc
    disp(' ')
    disp(['Case = ' num2str(ic)])
    
    %% Case parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    lam =lamm(ic);                                      % lambda                                           
    nsk =nskm(ic);                                      % point skip 
    ns  =nsm(ic);                                       % stencil size
    fl  =flm(ic);                                       % LES scale 
    ft  =ftm(ic);                                       % test scale
    spl =splm(ic);                                      % LES stencil space
    ndf =ndfm(ic);                                      % variable nondim

    %% Derived filter parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    deltl   =   dx(1)*2*pi/fl;                          % LES wavenumber   
    deltt   =   dx(1)*2*pi/ft;                          % test wavenumber
    spt     =   (fl/ft)*spl;                            % spacing renorm.
    
    %% Spectral filtering %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Create state variable filters')
    filtl=createFilter(nx,nxc,fl);                      % LES scale
    filtt=createFilter(nx,nxc,ft);                      % test scale

    %% Filter state variables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Calculate filtered state variables') 
    var_fl=zeros(nv,nx(1),nx(2),nx(3));                 % LES scale array
    var_ft=zeros(nv,nx(1),nx(2),nx(3));                 % test scale array
    for iv=1:nv                                         % loop over vars
        var_fl(iv,:,:,:)=spectralFilter3D(...           % LES scale
            squeeze(var(iv,:,:,:)),filtl);
        var_ft(iv,:,:,:)=spectralFilter3D(...           % test scale
            squeeze(var(iv,:,:,:)),filtt); 
    end %iv
   
    %% Testing for correct FFT ops:
    var_fl(1,15,24,10)
    var_ft(1,15,24,10)
%     
%     %% Filter strain rates %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     disp('Calculate filtered strain rates')
%     Sij_fl=Sij3DFaster(var_fl,dx);                      % LES scale strain
%     Sij_ft=Sij3DFaster(var_ft,dx);                      % test scale strain
%     %Check S_ij:
%     disp('Sij_fl(1,2,15,24,129)')
%     Sij_fl(1,2,15,24,129)
%     disp('Sij_fl(1,3,15,24,129)')
%     Sij_fl(1,3,15,24,129)
%     disp('Sij_ft(1,2,15,24,129)')
%     Sij_ft(1,2,15,24,129)
%     disp('Sij_ft(1,3,15,24,129)')
%     Sij_ft(1,3,15,24,129)
%     
%     S_fl=zeros(nx(1),nx(2),nx(3));                      % LES strain norm
%     S_ft=zeros(nx(1),nx(2),nx(3));                      % test strain norm
%     for jx=1:3
%         for ix=1:3
%             S_fl=S_fl+squeeze(Sij_fl(ix,jx,:,:,:).* ... % LES strain norm 
%                               Sij_fl(jx,ix,:,:,:));
%             S_ft=S_ft+squeeze(Sij_ft(ix,jx,:,:,:).* ... % test strain norm
%                               Sij_ft(jx,ix,:,:,:));
%         end %ix
%     end %jx
%     
%     
%     S_fl=sqrt(2*S_fl);                                  % adjust LES norm
%     S_ft=sqrt(2*S_ft);                                  % adjust test norm
%     
%     disp('Check S_f')
%     disp('S_fl(15,24,129)')
%     disp(S_fl(15,24,129))
%     disp('S_ft(15,24,129)')
%     disp(S_ft(15,24,129))
%     
%     S_flm(ic)=mean(mean(mean(S_fl)));                   % average LES norm
%     S_ftm(ic)=mean(mean(mean(S_ft)));   % average test norm

    %% Calculate true SGS stresses %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Calculate true deviatoric SGS stresses')
    tau_fl=TauSGS3D(var,filtl);                         % LES stresses
    dev=(1/3)*squeeze(tau_fl(1,:,:,:)+...               % LES trace
                      tau_fl(4,:,:,:)+tau_fl(6,:,:,:));
     tau_fl(1,:,:,:)=squeeze(tau_fl(1,:,:,:))-dev;       % LES tau11 deviat
     tau_fl(4,:,:,:)=squeeze(tau_fl(4,:,:,:))-dev;       % LES tau22 deviat
     tau_fl(6,:,:,:)=squeeze(tau_fl(6,:,:,:))-dev;       % LES tau33 deviat
    tau_flm(ic,:,:,:)=tau_fl(:,:,:,ks);                 % store LES slice
    
    tau_ft=TauSGS3D(var,filtt);                         % test stresses
    dev=(1/3)*squeeze(tau_ft(1,:,:,:)+...               % test trace
                      tau_ft(4,:,:,:)+tau_ft(6,:,:,:));
     tau_ft(1,:,:,:)=squeeze(tau_ft(1,:,:,:))-dev;       % test tau11 deviat
     tau_ft(4,:,:,:)=squeeze(tau_ft(4,:,:,:))-dev;       % test tau22 deviat
     tau_ft(6,:,:,:)=squeeze(tau_ft(6,:,:,:))-dev;       % test tau33 deviat
    tau_ftm(ic,:,:,:)=tau_ft(:,:,:,ks);                 % store test slice
    clear dev;
    format long;
     tau_ft(1,15,24,10)
     tau_fl(1,15,24,10)
     var(2,15,24,129)
     var_fl(2,15,24,129)
     var_ft(2,15,24,129)
  stop    
   
    %% Calculate dynamic Smagorinsky stresses %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Calculate dynamic Smagorinsky stresses')
    [tauSmag_fl,tauSmag_ft]=dynSmag(var_fl,var_ft,filtt,deltl,deltt,...
                                    Sij_fl,Sij_ft,S_fl,S_ft,nx);
    tauSmag_flm(ic,:,:,:)=tauSmag_fl(:,:,:,ks);         % store LES slice
    tauSmag_ftm(ic,:,:,:)=tauSmag_ft(:,:,:,ks);         % store test slice
    
    % Print results
    tauSmag_fl(2,15,24,ks);
    tauSmag_ft(2,15,24,ks);
%stop
    %% ALES opt Tikhonov Regularization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    % ALES N=1
    disp('Optimize 1st order ALES coefficients at test and LES scales')
    N=1;
%     h_ftn1=ALESoptTik(lam,ns,spt,nx,nsk,N,var_ft,tau_ft,S_ftm(ic),deltt,ndf);
%     tauOpt_ftn1=ALESmod(ns,spt,nx,N,var_ft,h_ftn1,S_ftm(ic),deltt,ndf); 
%     tauEst_fln1=ALESmod(ns,spl,nx,N,var_fl,h_ftn1,S_flm(ic),deltl,ndf);   
%     h_ftn1m(ic,:,:)=h_ftn1;
%     tauOpt_ftn1m(ic,:,:,:)=tauOpt_ftn1(:,:,:,ks);   
%     tauEst_fln1m(ic,:,:,:)=tauEst_fln1(:,:,:,ks); 
    % ALES N=2
    disp('Optimize 2nd order ALES coefficients at test and LES scales')
    N=2;
    h_ftn2=ALESoptTik(lam,ns,spt,nx,nsk,N,var_ft,tau_ft,S_ftm(ic),deltt,ndf);
    tauOpt_ftn2=ALESmod(ns,spt,nx,N,var_ft,h_ftn2,S_ftm(ic),deltt,ndf); 
    tauEst_fln2=ALESmod(ns,spl,nx,N,var_fl,h_ftn2,S_flm(ic),deltl,ndf);      
    h_ftn2m(ic,:,:)=h_ftn2;
    tauOpt_ftn2m(ic,:,:,:)=tauOpt_ftn2(:,:,:,ks);
    tauEst_fln2m(ic,:,:,:)=tauEst_fln2(:,:,:,ks); 
   
    %% Calculate fluxes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    disp('Calculate SGS fluxes at test and LES scales')
    % true SGS fluxes
    sgs_ft=sgsFlux(tau_ft,Sij_ft);
    sgs_fl=sgsFlux(tau_fl,Sij_fl);
    sgs_ftm(ic,:,:)=sgs_ft(:,:,ks);
    sgs_flm(ic,:,:)=sgs_fl(:,:,ks);
    avgsgs_ft(ic)=mean(mean(mean(sgs_ft)));
    avgsgs_fl(ic)=mean(mean(mean(sgs_fl)));
    % dynamic Smagorinsky SGS fluxes
    sgsSmag_ft=sgsFlux(tauSmag_ft,Sij_ft);
    sgsSmag_fl=sgsFlux(tauSmag_fl,Sij_fl);
    sgsSmag_ftm(ic,:,:)=sgsSmag_ft(:,:,ks);
    sgsSmag_flm(ic,:,:)=sgsSmag_fl(:,:,ks);
    avgsgsSmag_ft(ic)=mean(mean(mean(sgsSmag_ft)));
    avgsgsSmag_fl(ic)=mean(mean(mean(sgsSmag_fl)));
    % ALES N=1 SGS fluxes
    sgsOpt_ftn1=sgsFlux(tauOpt_ftn1,Sij_ft);
    sgsEst_fln1=sgsFlux(tauEst_fln1,Sij_fl);
    sgsOpt_ftn1m(ic,:,:)=sgsOpt_ftn1(:,:,ks);
    sgsEst_fln1m(ic,:,:)=sgsEst_fln1(:,:,ks);
    avgsgsOpt_ftn1(ic)=mean(mean(mean(sgsOpt_ftn1)));
    avgsgsEst_fln1(ic)=mean(mean(mean(sgsEst_fln1)));
    % ALES N=2 SGS fluxes
    sgsOpt_ftn2=sgsFlux(tauOpt_ftn2,Sij_ft);
    sgsEst_fln2=sgsFlux(tauEst_fln2,Sij_fl);
    sgsOpt_ftn2m(ic,:,:)=sgsOpt_ftn2(:,:,ks);
    sgsEst_fln2m(ic,:,:)=sgsEst_fln2(:,:,ks);
    avgsgsOpt_ftn2(ic)=mean(mean(mean(sgsOpt_ftn2)));
    avgsgsEst_fln2(ic)=mean(mean(mean(sgsEst_fln2)));
    
    %% Calculate stress statistics %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Calculate stress statistics at test and LES scales')
    clear nrm pdf bin;  
    bins=linspace(-1.2,1.2,nbins);
    % true stress, test scale
    [nrm,pdf,bin]=tauPDF(tau_ft,nx,bins);
    nrm_ft(ic,:)=nrm;
    pdf_ft(ic,:,:)=pdf;
    bin_ft(ic,:,:)=bin;
    % true stress, LES scale
    [nrm,pdf,bin]=tauPDF(tau_fl,nx,bins);
    nrm_fl(ic,:)=nrm;
    pdf_fl(ic,:,:)=pdf;
    bin_fl(ic,:,:)=bin;
    % dynamic Smagorinsky, test scale
    [nrm,pdf,bin]=tauPDF(tauSmag_ft,nx,bins);
    nrmSmag_ft(ic,:)=nrm;
    pdfSmag_ft(ic,:,:)=pdf;
    binSmag_ft(ic,:,:)=bin;
    % dynamic Smagorinsky, LES scale
    [nrm,pdf,bin]=tauPDF(tauSmag_fl,nx,bins);
    nrmSmag_fl(ic,:)=nrm;
    pdfSmag_fl(ic,:,:)=pdf;
    binSmag_fl(ic,:,:)=bin;
    % ALES N=1, test scale 
    [nrm,pdf,bin]=tauPDF(tauOpt_ftn1,nx,bins);
    nrmOpt_ftn1(ic,:)=nrm;
    pdfOpt_ftn1(ic,:,:)=pdf;
    binOpt_ftn1(ic,:,:)=bin;
    % ALES N=1, LES scale
    [nrm,pdf,bin]=tauPDF(tauEst_fln1,nx,bins);
    nrmEst_fln1(ic,:)=nrm;
    pdfEst_fln1(ic,:,:)=pdf;
    binEst_fln1(ic,:,:)=bin;
    % ALES N=2, test scale
    [nrm,pdf,bin]=tauPDF(tauOpt_ftn2,nx,bins);
    nrmOpt_ftn2(ic,:)=nrm;
    pdfOpt_ftn2(ic,:,:)=pdf;
    binOpt_ftn2(ic,:,:)=bin;   
    % ALES N=2, LES scale
    [nrm,pdf,bin]=tauPDF(tauEst_fln2,nx,bins);
    nrmEst_fln2(ic,:)=nrm;
    pdfEst_fln2(ic,:,:)=pdf;
    binEst_fln2(ic,:,:)=bin;
    
    %% Calculate errors and statistics %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Calculate stress errors at test and LES scales')
    clear err nrm pdf bin;
    bins=linspace(-1.5,1.5,nbins);
    % dynamic Smagorinsky, test scale
    err=tau_ft-tauSmag_ft;
    errSmag_ftm(ic,:,:,:)=err(:,:,:,ks);
    [nrm,pdf,bin]=tauPDF(err,nx,bins);   
    errnSmag_ft(ic,:)=nrm;
    errpdfSmag_ft(ic,:,:)=pdf;
    errbinSmag_ft(ic,:,:)=bin;
    % dynamic Smagorinsky, LES scale
    err=tau_fl-tauSmag_fl;
    errSmag_flm(ic,:,:,:)=err(:,:,:,ks);
    [nrm,pdf,bin]=tauPDF(err,nx,bins);
    errnSmag_fl(ic,:)=nrm;
    errpdfSmag_fl(ic,:,:)=pdf;
    errbinSmag_fl(ic,:,:)=bin;
    % ALES N=1, test scale
    err=tau_ft-tauOpt_ftn1;
    errOpt_ftn1m(ic,:,:,:)=err(:,:,:,ks);
    [nrm,pdf,bin]=tauPDF(err,nx,bins);
    errnOpt_ftn1(ic,:)=nrm;
    errpdfOpt_ftn1(ic,:,:)=pdf;
    errbinOpt_ftn1(ic,:,:)=bin;
    % ALES N=1, LES scale  
    err=tau_fl-tauEst_fln1;
    errEst_fln1m(ic,:,:,:)=err(:,:,:,ks);
    [nrm,pdf,bin]=tauPDF(err,nx,bins);
    errnEst_fln1(ic,:)=nrm;
    errpdfEst_fln1(ic,:,:)=pdf;
    errbinEst_fln1(ic,:,:)=bin;
    % ALES N=2, test scale
    err=tau_ft-tauOpt_ftn2;
    errOpt_ftn2m(ic,:,:,:)=err(:,:,:,ks);
    [nrm,pdf,bin]=tauPDF(err,nx,bins);
    errnOpt_ftn2(ic,:)=nrm;
    errpdfOpt_ftn2(ic,:,:)=pdf;
    errbinOpt_ftn2(ic,:,:)=bin;
    % ALES N=2, LES scale
    err=tau_fl-tauEst_fln2;
    errEst_fln2m(ic,:,:,:)=err(:,:,:,ks);
    [nrm,pdf,bin]=tauPDF(err,nx,bins);  
    errnEst_fln2(ic,:)=nrm;
    errpdfEst_fln2(ic,:,:)=pdf;
    errbinEst_fln2(ic,:,:)=bin;
    
    %% Calculate sgs flux statistics %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Calculate sgs flux statistics at test and LES scales')
    clear nrm pdf bin;  
    bins=linspace(-4.3,4.3,nbins);
    % true flux, test scale
    [nrm,pdf,bin]=sgsPDF(sgs_ft,nx,bins);
    sgsnrm_ft(ic)=nrm;
    sgspdf_ft(ic,:)=pdf;
    sgsbin_ft(ic,:)=bin;
    % true flux, LES scale
    [nrm,pdf,bin]=sgsPDF(sgs_fl,nx,bins);
    sgsnrm_fl(ic)=nrm;
    sgspdf_fl(ic,:)=pdf;
    sgsbin_fl(ic,:)=bin;
    % dynamic Smagorinsky, test scale
    [nrm,pdf,bin]=sgsPDF(sgsSmag_ft,nx,bins);
    sgsnrmSmag_ft(ic)=nrm;
    sgspdfSmag_ft(ic,:)=pdf;
    sgsbinSmag_ft(ic,:)=bin;
    % dynamic Smagorinsky, LES scale
    [nrm,pdf,bin]=sgsPDF(sgsSmag_fl,nx,bins);
    sgsnrmSmag_fl(ic)=nrm;
    sgspdfSmag_fl(ic,:)=pdf;
    sgsbinSmag_fl(ic,:)=bin;
   % max(max(sgsSmag_fl(ic,:,:))) %%%%%%%%%%%%%%
    % ALES N=1, test scale
    [nrm,pdf,bin]=sgsPDF(sgsOpt_ftn1,nx,bins);
    sgsnrmOpt_ftn1(ic)=nrm;
    sgspdfOpt_ftn1(ic,:)=pdf;
    sgsbinOpt_ftn1(ic,:)=bin;
    % ALES N=1, LES scale
    [nrm,pdf,bin]=sgsPDF(sgsEst_fln1,nx,bins);
    sgsnrmEst_fln1(ic)=nrm;
    sgspdfEst_fln1(ic,:)=pdf;
    sgsbinEst_fln1(ic,:)=bin;
    % ALES N=2, test scale
    [nrm,pdf,bin]=sgsPDF(sgsOpt_ftn2,nx,bins);
    sgsnrmOpt_ftn2(ic)=nrm;
    sgspdfOpt_ftn2(ic,:)=pdf;
    sgsbinOpt_ftn2(ic,:)=bin;
    % ALES N=2, LES scale
    [nrm,pdf,bin]=sgsPDF(sgsEst_fln2,nx,bins);
    sgsnrmEst_fln2(ic)=nrm;
    sgspdfEst_fln2(ic,:)=pdf;
    sgsbinEst_fln2(ic,:)=bin;
    
    %% Calculate sgs flux errors and statistics %%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Calculate SGS flux errors at test and LES scales')
    clear err nrm pdf bin;
    bins=linspace(-4.3,4.3,nbins);
    % dynamic Smagorinsky, test scale
    err=sgs_ft-sgsSmag_ft;
    errsSmag_ftm(ic,:,:)=err(:,:,ks);
    [nrm,pdf,bin]=sgsPDF(err,nx,bins);
    errsnSmag_ft(ic)=nrm;
    errspdfSmag_ft(ic,:)=pdf;
    errsbinSmag_ft(ic,:)=bin;
    % dynamic Smagorinsky, LES scale
    err=sgs_fl-sgsSmag_fl;
    errsSmag_flm(ic,:,:)=err(:,:,ks);
    [nrm,pdf,bin]=sgsPDF(err,nx,bins);
    errsnSmag_fl(ic)=nrm;
    errspdfSmag_fl(ic,:)=pdf;
    errsbinSmag_fl(ic,:)=bin;
    % ALES N=1, test scale
    err=sgs_ft-sgsOpt_ftn1;
    errsOpt_ftn1m(ic,:,:)=err(:,:,ks);
    [nrm,pdf,bin]=sgsPDF(err,nx,bins);
    errsnOpt_ftn1(ic)=nrm;
    errspdfOpt_ftn1(ic,:)=pdf;
    errsbinOpt_ftn1(ic,:)=bin;
    % ALES N=1, LES scale
    err=sgs_fl-sgsEst_fln1;
    errsEst_fln1m(ic,:,:)=err(:,:,ks);
    [nrm,pdf,bin]=sgsPDF(err,nx,bins);   
    errsnEst_fln1(ic)=nrm;
    errspdfEst_fln1(ic,:)=pdf;
    errsbinEst_fln1(ic,:)=bin;
    % ALES N=2, test scale
    err=sgs_ft-sgsOpt_ftn2;
    errsOpt_ftn2m(ic,:,:)=err(:,:,ks);
    [nrm,pdf,bin]=sgsPDF(err,nx,bins);   
    errsnOpt_ftn2(ic)=nrm;
    errspdfOpt_ftn2(ic,:)=pdf;
    errsbinOpt_ftn2(ic,:)=bin;
    % ALES N=2, LES scale
    err=sgs_fl-sgsEst_fln2;
    errsEst_fln2m(ic,:,:)=err(:,:,ks);
    [nrm,pdf,bin]=sgsPDF(err,nx,bins); 
    errsnEst_fln2(ic)=nrm;
    errspdfEst_fln2(ic,:)=pdf;
    errsbinEst_fln2(ic,:)=bin;
  
end %ic

%% Clear unwanted variables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear filtl filtt tau_ft tau_fl tauSmag_ft tauSmag_fl ...
      tauOpt_ftn1 tauEst_fln1 tauOpt_ftn2 tauEst_fln2 ...
      Sij_ft Sij_fl S_fl S_ft err nrm pdf bin ...
      sgs_ft sgs_fl sgsSmag_ft sgsSmag_fl ...
      sgsOpt_ftn1 sgsEst_fln1 sgOpt_ftn2 sgEst_fln2;
  
%% Calculate KL divergences %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Calculate KL divergences')
KLdivs

%% Make figures %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Make figures')
mkdir(fdir)
for ic=1:nc
    figure1
    %figure2
    %figure3
    %figure4
    %figure5
    
    figure7
    figure8
    %figure9
end
%figure6

%% Ouptut test files %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Output text files')
out_params
out_errors
out_fluxes
out_kldivs

