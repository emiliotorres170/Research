%% Initialize stress and flux arrays %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tau_flm=zeros(nc,6,nx(1),nx(2));
tau_ftm=zeros(nc,6,nx(1),nx(2));
tauSmag_flm=zeros(nc,6,nx(1),nx(2));
tauSmag_ftm=zeros(nc,6,nx(1),nx(2));
tauOpt_ftn1m=zeros(nc,6,nx(1),nx(2));
tauEst_fln1m=zeros(nc,6,nx(1),nx(2));
tauOpt_ftn2m=zeros(nc,6,nx(1),nx(2));
tauEst_fln2m=zeros(nc,6,nx(1),nx(2));

sgs_flm=zeros(nc,nx(1),nx(2));
sgs_ftm=zeros(nc,nx(1),nx(2));
sgsSmag_flm=zeros(nc,nx(1),nx(2));
sgsSmag_ftm=zeros(nc,nx(1),nx(2));
sgsOpt_ftn1m=zeros(nc,nx(1),nx(2));
sgsEst_fln1m=zeros(nc,nx(1),nx(2));
sgsOpt_ftn2m=zeros(nc,nx(1),nx(2));
sgsEst_fln2m=zeros(nc,nx(1),nx(2));

%% Initialize error arrays %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
errSmag_ftm=zeros(nc,6,nx(1),nx(2));
errSmag_flm=zeros(nc,6,nx(1),nx(2));
errOpt_ftn1m=zeros(nc,6,nx(1),nx(2));
errEst_fln1m=zeros(nc,6,nx(1),nx(2));
errOpt_ftn2m=zeros(nc,6,nx(1),nx(2));
errEst_fln2m=zeros(nc,6,nx(1),nx(2));
errsSmag_ftm=zeros(nc,nx(1),nx(2));
errsSmag_flm=zeros(nc,nx(1),nx(2));
errsOpt_ftn1m=zeros(nc,nx(1),nx(2));
errsEst_fln1m=zeros(nc,nx(1),nx(2));
errsOpt_ftn2m=zeros(nc,nx(1),nx(2));
errsEst_fln2m=zeros(nc,nx(1),nx(2));

errnSmag_ft=zeros(nc,6);
errnSmag_fl=zeros(nc,6);
errnOpt_ftn1=zeros(nc,6);
errnEst_fln1=zeros(nc,6);
errnOpt_ftn2=zeros(nc,6);
errnEst_fln2=zeros(nc,6);
errsnSmag_ft=zeros(nc,1);
errsnSmag_fl=zeros(nc,1);
errsnOpt_ftn1=zeros(nc,1);
errsnEst_fln1=zeros(nc,1);
errsnOpt_ftn2=zeros(nc,1);
errsnEst_fln2=zeros(nc,1);

errpdfSmag_ft=zeros(nc,6,nbins);
errpdfSmag_fl=zeros(nc,6,nbins);
errpdfOpt_ftn1=zeros(nc,6,nbins);
errpdfEst_fln1=zeros(nc,6,nbins);
errpdfOpt_ftn2=zeros(nc,6,nbins);
errpdfEst_fln2=zeros(nc,6,nbins);
errspdfSmag_ft=zeros(nc,nbins);
errspdfSmag_fl=zeros(nc,nbins);
errspdfOpt_ftn1=zeros(nc,nbins);
errspdfEst_fln1=zeros(nc,nbins);
errspdfOpt_ftn2=zeros(nc,nbins);
errspdfEst_fln2=zeros(nc,nbins);

errbinSmag_ft=zeros(nc,6,nbins);
errbinSmag_fl=zeros(nc,6,nbins);
errbinOpt_ftn1=zeros(nc,6,nbins);
errbinEst_fln1=zeros(nc,6,nbins);
errbinOpt_ftn2=zeros(nc,6,nbins);
errbinEst_fln2=zeros(nc,6,nbins);
errsbinSmag_ft=zeros(nc,nbins);
errsbinSmag_fl=zeros(nc,nbins);
errsbinOpt_ftn1=zeros(nc,nbins);
errsbinEst_fln1=zeros(nc,nbins);
errsbinOpt_ftn2=zeros(nc,nbins);
errsbinEst_fln2=zeros(nc,nbins);


S_flm=zeros(nc,1);
S_ftm=zeros(nc,1);