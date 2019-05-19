%% Output parameter information %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid=fopen([fdir 'params.txt'],'w');

fprintf(fid,'%s\t','data=');
fprintf(fid,'%s',dat);
fprintf(fid,'\n');

fprintf(fid,'%s\t','nx=');
fprintf(fid,'%i ',nx);
fprintf(fid,'\n');

fprintf(fid,'%s\t','lambda=');
fprintf(fid,'%g\t',lamm);
fprintf(fid,'\n');

fprintf(fid,'%s\t','skip=');
fprintf(fid,'%i\t',nskm);
fprintf(fid,'\n');

fprintf(fid,'%s\t','stenc=');
fprintf(fid,'%i\t',nsm);
fprintf(fid,'\n');

fprintf(fid,'%s\t','les=');
fprintf(fid,'%i\t',flm);
fprintf(fid,'\n');

fprintf(fid,'%s\t','test=');
fprintf(fid,'%i\t',ftm);
fprintf(fid,'\n');

fprintf(fid,'%s\t','space=');
fprintf(fid,'%i\t',splm);
fprintf(fid,'\n');

fprintf(fid,'%s\t','redim=');
fprintf(fid,'%i\t',ndfm);
fprintf(fid,'\n');
fclose(fid);