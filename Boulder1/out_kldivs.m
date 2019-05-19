%% KL divergence information %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid=fopen([fdir 'kldivs.txt'],'w');
    
fprintf(fid,'%s','Stress KL divergences at test scale');
fprintf(fid,'\n');
fprintf(fid,'%s\t','DS=');
fprintf(fid,'%g\t',tauklSmag_ft);
fprintf(fid,'\n');
fprintf(fid,'%s\t','N1=');
fprintf(fid,'%g\t',tauklOpt_ftn1);
fprintf(fid,'\n');
fprintf(fid,'%s\t','N2=');
fprintf(fid,'%g\t',tauklOpt_ftn2);
fprintf(fid,'\n');
fprintf(fid,'\n');

fprintf(fid,'%s','Stress KL divergences at LES scale');
fprintf(fid,'\n');
fprintf(fid,'%s\t','DS=');
fprintf(fid,'%g\t',tauklSmag_fl);
fprintf(fid,'\n');
fprintf(fid,'%s\t','N1=');
fprintf(fid,'%g\t',tauklEst_fln1);
fprintf(fid,'\n');
fprintf(fid,'%s\t','N2=');
fprintf(fid,'%g\t',tauklEst_fln2);
fprintf(fid,'\n');
fprintf(fid,'\n');

fprintf(fid,'%s','SGS flux KL divergences at test scale');
fprintf(fid,'\n');
fprintf(fid,'%s\t','DS=');
fprintf(fid,'%g\t',sgsklSmag_ft);
fprintf(fid,'\n');
fprintf(fid,'%s\t','N1=');
fprintf(fid,'%g\t',sgsklOpt_ftn1);
fprintf(fid,'\n');
fprintf(fid,'%s\t','N2=');
fprintf(fid,'%g\t',sgsklOpt_ftn2);
fprintf(fid,'\n');
fprintf(fid,'\n');

fprintf(fid,'%s','SGS flux KL divergences at LES scale');
fprintf(fid,'\n');
fprintf(fid,'%s\t','DS=');
fprintf(fid,'%g\t',sgsklSmag_fl);
fprintf(fid,'\n');
fprintf(fid,'%s\t','N1=');
fprintf(fid,'%g\t',sgsklEst_fln1);
fprintf(fid,'\n');
fprintf(fid,'%s\t','N2=');
fprintf(fid,'%g\t',sgsklEst_fln2);
fprintf(fid,'\n');
fprintf(fid,'\n');
