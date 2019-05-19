%% Error norm information %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid=fopen([fdir 'errors.txt'],'w');

fprintf(fid,'%s','Test scale stress errors');
fprintf(fid,'\n');
fprintf(fid,'%s\t','DS=');
fprintf(fid,'%g\t',errnSmag_ft(:,1));
fprintf(fid,'\n');
fprintf(fid,'%s\t','N1=');
fprintf(fid,'%g\t',errnOpt_ftn1(:,1));
fprintf(fid,'\n');
fprintf(fid,'%s\t','N2=');
fprintf(fid,'%g\t',errnOpt_ftn2(:,1));
fprintf(fid,'\n');
fprintf(fid,'\n');

fprintf(fid,'%s','LES scale stress errors');
fprintf(fid,'\n');
fprintf(fid,'%s\t','DS=');
fprintf(fid,'%g\t',errnSmag_fl(:,1));
fprintf(fid,'\n');
fprintf(fid,'%s\t','N1=');
fprintf(fid,'%g\t',errnEst_fln1(:,1));
fprintf(fid,'\n');
fprintf(fid,'%s\t','N2=');
fprintf(fid,'%g\t',errnEst_fln2(:,1));
fprintf(fid,'\n');
fprintf(fid,'\n');

fprintf(fid,'%s','Test scale flux errors');
fprintf(fid,'\n');
fprintf(fid,'%s\t','DS=');
fprintf(fid,'%g\t',errsnSmag_ft);
fprintf(fid,'\n');
fprintf(fid,'%s\t','N1=');
fprintf(fid,'%g\t',errsnOpt_ftn1);
fprintf(fid,'\n');
fprintf(fid,'%s\t','N2=');
fprintf(fid,'%g\t',errsnOpt_ftn2);
fprintf(fid,'\n');
fprintf(fid,'\n');

fprintf(fid,'%s','LES scale flux errors');
fprintf(fid,'\n');
fprintf(fid,'%s\t','DS=');
fprintf(fid,'%g\t',errsnSmag_fl);
fprintf(fid,'\n');
fprintf(fid,'%s\t','N1=');
fprintf(fid,'%g\t',errsnEst_fln1);
fprintf(fid,'\n');
fprintf(fid,'%s\t','N2=');
fprintf(fid,'%g\t',errsnEst_fln2);
fprintf(fid,'\n');
fprintf(fid,'\n');


fclose(fid);