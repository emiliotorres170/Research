% read in data extracted from the Johns Hopkins Turbulence Database
% viscosity nu=0.000185
% total kinetic energy E=0.695
% dissipation rate eps=0.0928
% rms vel u' = 0.681
% Taylor microscale lamba = 0.118
% Tayle scale reynolds num Re_lambda = 433
% Kolmogorov time scale tau_eta = 0.0446
% Kolmogorov length scale eta = 0.00287
% integral scale L = 1.376
% inertial range up to about k=10^2


function [var,nx,lx,nt]=dataRead(dat)
if strcmp(dat,'jhu')
    nx  =   [1024,1024,1024];                       % grid dimensions
    var =   zeros(3,nx(1),nx(2),nx(3));             % initialize data array
    lx  =   [2*pi,2*pi,2*pi];                       % total domain size
    nt  =   1;                                      % number of time steps  
    path=   '../data/JHTB/HIT/';                    % data location 
    
    var(1:3,:,:,1:96)   =squeeze(h5read([path 'isotropic1024coarse0_95_10240.h5'],'/u10240'));
    var(1:3,:,:,97:192) =squeeze(h5read([path 'isotropic1024coarse96_191_10240.h5'],'/u10240'));
    var(1:3,:,:,193:288)=squeeze(h5read([path 'isotropic1024coarse192_287_10240.h5'],'/u10240'));
    var(1:3,:,:,289:384)=squeeze(h5read([path 'isotropic1024coarse288_383_10240.h5'],'/u10240'));
    var(1:3,:,:,385:480)=squeeze(h5read([path 'isotropic1024coarse384_479_10240.h5'],'/u10240'));
    var(1:3,:,:,481:576)=squeeze(h5read([path 'isotropic1024coarse480_575_10240.h5'],'/u10240'));
    var(1:3,:,:,577:672)=squeeze(h5read([path 'isotropic1024coarse576_671_10240.h5'],'/u10240'));
    var(1:3,:,:,673:768)=squeeze(h5read([path 'isotropic1024coarse672_767_10240.h5'],'/u10240'));
    var(1:3,:,:,769:864)=squeeze(h5read([path 'isotropic1024coarse768_863_10240.h5'],'/u10240'));
    var(1:3,:,:,865:960)=squeeze(h5read([path 'isotropic1024coarse864_959_10240.h5'],'/u10240'));
    var(1:3,:,:,961:1024)=squeeze(h5read([path 'isotropic1024coarse960_1024_10240.h5'],'/u10240'));      
    
%     var(4,:,:,1:96)=squeeze(h5read([path 'isotropic1024coarse0_95_10240.h5'],'/p10240'));
%     var(4,:,:,97:192)=squeeze(h5read([path 'isotropic1024coarse96_191_10240.h5'],'/p10240'));
%     var(4,:,:,193:288)=squeeze(h5read([path 'isotropic1024coarse192_287_10240.h5'],'/p10240'));
%     var(4,:,:,289:384)=squeeze(h5read([path 'isotropic1024coarse288_383_10240.h5'],'/p10240'));
%     var(4,:,:,385:480)=squeeze(h5read([path 'isotropic1024coarse384_479_10240.h5'],'/p10240'));
%     var(4,:,:,481:576)=squeeze(h5read([path 'isotropic1024coarse480_575_10240.h5'],'/p10240'));
%     var(4,:,:,577:672)=squeeze(h5read([path 'isotropic1024coarse576_671_10240.h5'],'/p10240'));
%     var(4,:,:,673:768)=squeeze(h5read([path 'isotropic1024coarse672_767_10240.h5'],'/p10240'));
%     var(4,:,:,769:864)=squeeze(h5read([path 'isotropic1024coarse768_863_10240.h5'],'/p10240'));
%     var(4,:,:,865:960)=squeeze(h5read([path 'isotropic1024coarse864_959_10240.h5'],'/p10240'));
%     var(4,:,:,961:1024)=squeeze(h5read([path 'isotropic1024coarse960_1024_10240.h5'],'/p10240'));      
elseif strcmp(dat,'jhu_int')
    nx  =   [256,256,256];                          % grid dimensions
    var =   zeros(4,nx(1),nx(2),nx(3));             % initialize data array
    nxm =   [1024,1024,1024];                       % total grid dimensions
    lx  =   [2*pi,2*pi,2*pi];                       % total domain size
    nt  =   1;                                      % number of time steps  
    path=   '../data/JHTB/HIT/';      % data location
    [xi,yi,zi]=meshgrid(1:nxm(1)/nx(1):nxm(1),...
                        1:nxm(2)/nx(2):nxm(2),...
                        1:nxm(3)/nx(3):nxm(3));  
    
    vart(1:3,:,:,1:96)=squeeze(h5read([path 'isotropic1024coarse0_95_10240.h5'],'/u10240'));
    vart(1:3,:,:,97:192)=squeeze(h5read([path 'isotropic1024coarse96_191_10240.h5'],'/u10240'));
    vart(1:3,:,:,193:288)=squeeze(h5read([path 'isotropic1024coarse192_287_10240.h5'],'/u10240'));
    vart(1:3,:,:,289:384)=squeeze(h5read([path 'isotropic1024coarse288_383_10240.h5'],'/u10240'));
    vart(1:3,:,:,385:480)=squeeze(h5read([path 'isotropic1024coarse384_479_10240.h5'],'/u10240'));
    vart(1:3,:,:,481:576)=squeeze(h5read([path 'isotropic1024coarse480_575_10240.h5'],'/u10240'));
    vart(1:3,:,:,577:672)=squeeze(h5read([path 'isotropic1024coarse576_671_10240.h5'],'/u10240'));
    vart(1:3,:,:,673:768)=squeeze(h5read([path 'isotropic1024coarse672_767_10240.h5'],'/u10240'));
    vart(1:3,:,:,769:864)=squeeze(h5read([path 'isotropic1024coarse768_863_10240.h5'],'/u10240'));
    vart(1:3,:,:,865:960)=squeeze(h5read([path 'isotropic1024coarse864_959_10240.h5'],'/u10240'));
    vart(1:3,:,:,961:1024)=squeeze(h5read([path 'isotropic1024coarse960_1024_10240.h5'],'/u10240'));      
    for ix=1:3
        var(ix,:,:,:)=interpn(squeeze(vart(ix,:,:,:)),xi,yi,zi);
    end
    clear vart;
    
    vart(:,:,1:96)=squeeze(h5read([path 'isotropic1024coarse0_95_10240.h5'],'/p10240'));
    vart(:,:,97:192)=squeeze(h5read([path 'isotropic1024coarse96_191_10240.h5'],'/p10240'));
    vart(:,:,193:288)=squeeze(h5read([path 'isotropic1024coarse192_287_10240.h5'],'/p10240'));
    vart(:,:,289:384)=squeeze(h5read([path 'isotropic1024coarse288_383_10240.h5'],'/p10240'));
    vart(:,:,385:480)=squeeze(h5read([path 'isotropic1024coarse384_479_10240.h5'],'/p10240'));
    vart(:,:,481:576)=squeeze(h5read([path 'isotropic1024coarse480_575_10240.h5'],'/p10240'));
    vart(:,:,577:672)=squeeze(h5read([path 'isotropic1024coarse576_671_10240.h5'],'/p10240'));
    vart(:,:,673:768)=squeeze(h5read([path 'isotropic1024coarse672_767_10240.h5'],'/p10240'));
    vart(:,:,769:864)=squeeze(h5read([path 'isotropic1024coarse768_863_10240.h5'],'/p10240'));
    vart(:,:,865:960)=squeeze(h5read([path 'isotropic1024coarse864_959_10240.h5'],'/p10240'));
    vart(:,:,961:1024)=squeeze(h5read([path 'isotropic1024coarse960_1024_10240.h5'],'/p10240'));
    var(4,:,:,:)=interpn(vart,xi,yi,zi);   
    clear vart xi yi zi;
elseif strcmp(dat,'jhu_red')
    nx  =   [256,256,256];                          % grid dimensions
    var =   zeros(4,nx(1),nx(2),nx(3));             % initialize data array
    nxm =   [1024,1024,1024];                       % total grid dimensions
    lx  =   [2*pi,2*pi,2*pi];                       % total domain size
    nt  =   1;                                      % number of time steps  
    path=   '../data/JHTB/HIT/';                    % data location 
    
    vart(1:3,:,:,1:96)=squeeze(h5read([path 'isotropic1024coarse0_95_10240.h5'],'/u10240'));
    vart(1:3,:,:,97:192)=squeeze(h5read([path 'isotropic1024coarse96_191_10240.h5'],'/u10240'));
    vart(1:3,:,:,193:288)=squeeze(h5read([path 'isotropic1024coarse192_287_10240.h5'],'/u10240'));
    vart(1:3,:,:,289:384)=squeeze(h5read([path 'isotropic1024coarse288_383_10240.h5'],'/u10240'));
    vart(1:3,:,:,385:480)=squeeze(h5read([path 'isotropic1024coarse384_479_10240.h5'],'/u10240'));
    vart(1:3,:,:,481:576)=squeeze(h5read([path 'isotropic1024coarse480_575_10240.h5'],'/u10240'));
    vart(1:3,:,:,577:672)=squeeze(h5read([path 'isotropic1024coarse576_671_10240.h5'],'/u10240'));
    vart(1:3,:,:,673:768)=squeeze(h5read([path 'isotropic1024coarse672_767_10240.h5'],'/u10240'));
    vart(1:3,:,:,769:864)=squeeze(h5read([path 'isotropic1024coarse768_863_10240.h5'],'/u10240'));
    vart(1:3,:,:,865:960)=squeeze(h5read([path 'isotropic1024coarse864_959_10240.h5'],'/u10240'));
    vart(1:3,:,:,961:1024)=squeeze(h5read([path 'isotropic1024coarse960_1024_10240.h5'],'/u10240'));      
    var(1:3,:,:,:)=vart(:,1:nxm(1)/nx(1):nxm(1),...
                          1:nxm(2)/nx(2):nxm(2),...
                          1:nxm(3)/nx(3):nxm(3));
    clear vart;
    
    vart(:,:,1:96)=squeeze(h5read([path 'isotropic1024coarse0_95_10240.h5'],'/p10240'));
    vart(:,:,97:192)=squeeze(h5read([path 'isotropic1024coarse96_191_10240.h5'],'/p10240'));
    vart(:,:,193:288)=squeeze(h5read([path 'isotropic1024coarse192_287_10240.h5'],'/p10240'));
    vart(:,:,289:384)=squeeze(h5read([path 'isotropic1024coarse288_383_10240.h5'],'/p10240'));
    vart(:,:,385:480)=squeeze(h5read([path 'isotropic1024coarse384_479_10240.h5'],'/p10240'));
    vart(:,:,481:576)=squeeze(h5read([path 'isotropic1024coarse480_575_10240.h5'],'/p10240'));
    vart(:,:,577:672)=squeeze(h5read([path 'isotropic1024coarse576_671_10240.h5'],'/p10240'));
    vart(:,:,673:768)=squeeze(h5read([path 'isotropic1024coarse672_767_10240.h5'],'/p10240'));
    vart(:,:,769:864)=squeeze(h5read([path 'isotropic1024coarse768_863_10240.h5'],'/p10240'));
    vart(:,:,865:960)=squeeze(h5read([path 'isotropic1024coarse864_959_10240.h5'],'/p10240'));
    vart(:,:,961:1024)=squeeze(h5read([path 'isotropic1024coarse960_1024_10240.h5'],'/p10240'));
    var(4,:,:,:)=vart(1:nxm(1)/nx(1):nxm(1),...
                      1:nxm(2)/nx(2):nxm(2),...
                      1:nxm(3)/nx(3):nxm(3));   
    clear vart;        
elseif strcmp(dat,'jhu_slc')
    nx  =   [256,256,256];
    var =   zeros(4,nx(1),nx(2),nx(3));             % initialize data array
    lx  =   [2*pi*nx(1)/1024,2*pi*nx(2)/1024,2*pi*nx(3)/1024];
    nt  =   1;                                      % number of time steps  
    path=   '../data/JHTB/HIT/';                    % data location
    
    vart(1:3,:,:,1:96)=squeeze(h5read([path 'isotropic1024coarse_2.h5'],'/u00000'));
    vart(1:3,:,:,97:192)=squeeze(h5read([path 'isotropic1024coarse96_191_10240.h5'],'/u10240'));
    vart(1:3,:,:,193:288)=squeeze(h5read([path 'isotropic1024coarse192_287_10240.h5'],'/u10240'));
    vart(1:3,:,:,289:384)=squeeze(h5read([path 'isotropic1024coarse288_383_10240.h5'],'/u10240'));
    vart(1:3,:,:,385:480)=squeeze(h5read([path 'isotropic1024coarse384_479_10240.h5'],'/u10240'));
    vart(1:3,:,:,481:576)=squeeze(h5read([path 'isotropic1024coarse480_575_10240.h5'],'/u10240'));
    vart(1:3,:,:,577:672)=squeeze(h5read([path 'isotropic1024coarse576_671_10240.h5'],'/u10240'));
    vart(1:3,:,:,673:768)=squeeze(h5read([path 'isotropic1024coarse672_767_10240.h5'],'/u10240'));
    vart(1:3,:,:,769:864)=squeeze(h5read([path 'isotropic1024coarse768_863_10240.h5'],'/u10240'));
    vart(1:3,:,:,865:960)=squeeze(h5read([path 'isotropic1024coarse864_959_10240.h5'],'/u10240'));
    vart(1:3,:,:,961:1024)=squeeze(h5read([path 'isotropic1024coarse960_1024_10240.h5'],'/u10240'));   
    %var(1:3,:,:,:)=vart(1:3,1:nx(1),1:nx(2),77:96);
    var(1:3,:,:,:)=vart(1:3,1:nx(1),1:nx(2),1:nx(3));
    clear vart;
    
    vart(:,:,1:96)=squeeze(h5read([path 'isotropic1024coarse_2.h5'],'/p00000'));
    vart(:,:,97:192)=squeeze(h5read([path 'isotropic1024coarse96_191_10240.h5'],'/p10240'));
    vart(:,:,193:288)=squeeze(h5read([path 'isotropic1024coarse192_287_10240.h5'],'/p10240'));
    vart(:,:,289:384)=squeeze(h5read([path 'isotropic1024coarse288_383_10240.h5'],'/p10240'));
    vart(:,:,385:480)=squeeze(h5read([path 'isotropic1024coarse384_479_10240.h5'],'/p10240'));
    vart(:,:,481:576)=squeeze(h5read([path 'isotropic1024coarse480_575_10240.h5'],'/p10240'));
    vart(:,:,577:672)=squeeze(h5read([path 'isotropic1024coarse576_671_10240.h5'],'/p10240'));
    vart(:,:,673:768)=squeeze(h5read([path 'isotropic1024coarse672_767_10240.h5'],'/p10240'));
    vart(:,:,769:864)=squeeze(h5read([path 'isotropic1024coarse768_863_10240.h5'],'/p10240'));
    vart(:,:,865:960)=squeeze(h5read([path 'isotropic1024coarse864_959_10240.h5'],'/p10240'));
    vart(:,:,961:1024)=squeeze(h5read([path 'isotropic1024coarse960_1024_10240.h5'],'/p10240'));
    %var(4,:,:,:)=vart(1:nx(1),1:nx(2),77:96);
    var(4,:,:,:)=vart(1:nx(1),1:nx(2),1:nx(3));
    clear vart;
elseif strcmp(dat,'nrl')
    path=   '../../../f90/data/nrl/';
    nx  =   [256,256,256];                  % grid dimensions
    lx  =   [0.259,0.259,0.259];            % physical domain size
    nt  =   1;                              % number of time steps  
    time=   '0460';
    var=zeros(3,nx(1),nx(2),nx(3));         % initialize var arrays
    for i=1:3
        fid=fopen([path,'Velocity' num2str(i) '_',time,'.bin']);
        var(i,:,:,:)=reshape(fread(fid,nx(1)*nx(2)*nx(3),'single','b'),nx);
        fclose(fid);
    end
    var = var*0.01;
    
elseif strcmp(dat,'jhu256')
    path=   '../../../f90/data/jhu256/bin/';
    nx  =   [256,256,256];                  % grid dimensions
    lx  =   [2*pi(),2*pi(),2*pi()];            % physical domain size
    nt  =   1;                              % number of time steps  
    time=   '256';
    var=zeros(3,nx(1),nx(2),nx(3));         % initialize var arrays
    for i=1:3
        fid=fopen([path,'Velocity' num2str(i) '_',time,'.bin']);
        var(i,:,:,:)=reshape(fread(fid,nx(1)*nx(2)*nx(3),'double'),nx);
        %var(i,:,:,:)=reshape(fread(fid,nx(1)*nx(2)*nx(3),'double','b'),nx);
        fclose(fid);
    end
end

end
