%% Average flux information %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid=fopen([fdir 'fluxes.txt'],'w');

fprintf(fid,'%s','Average test scale SGS fluxes');
fprintf(fid,'\n');
fprintf(fid,'%s\t','DNS=');
fprintf(fid,'%g\t',avgsgs_ft);
fprintf(fid,'\n');
fprintf(fid,'%s\t','DS=');
fprintf(fid,'%g\t',avgsgsSmag_ft);
fprintf(fid,'\n');
fprintf(fid,'%s\t','N1=');
fprintf(fid,'%g\t',avgsgsOpt_ftn1);
fprintf(fid,'\n');
fprintf(fid,'%s\t','N2=');
fprintf(fid,'%g\t',avgsgsOpt_ftn2);
fprintf(fid,'\n');
fprintf(fid,'\n');

fprintf(fid,'%s','Average LES scale SGS fluxes');
fprintf(fid,'\n');
fprintf(fid,'%s\t','DNS=');
fprintf(fid,'%g\t',avgsgs_fl);
fprintf(fid,'\n');
fprintf(fid,'%s\t','DS=');
fprintf(fid,'%g\t',avgsgsSmag_fl);
fprintf(fid,'\n');
fprintf(fid,'%s\t','N1=');
fprintf(fid,'%g\t',avgsgsEst_fln1);
fprintf(fid,'\n');
fprintf(fid,'%s\t','N2=');
fprintf(fid,'%g\t',avgsgsEst_fln2);
fprintf(fid,'\n');
fprintf(fid,'\n');