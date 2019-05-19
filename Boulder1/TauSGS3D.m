function tau = TauSGS3D(var,filt)

u=squeeze(var(1,:,:,:));
uf=spectralFilter3D(u,filt);
v=squeeze(var(2,:,:,:));
vf=spectralFilter3D(v,filt);
w=squeeze(var(3,:,:,:));
wf=spectralFilter3D(w,filt);

tau(1,:,:,:)=spectralFilter3D(u.^2,filt)-uf.*uf;
tau(2,:,:,:)=spectralFilter3D(v.*u,filt)-uf.*vf;
tau(3,:,:,:)=spectralFilter3D(w.*u,filt)-uf.*wf;
tau(4,:,:,:)=spectralFilter3D(v.^2,filt)-vf.*vf;
tau(5,:,:,:)=spectralFilter3D(v.*w,filt)-vf.*wf;
tau(6,:,:,:)=spectralFilter3D(w.^2,filt)-wf.*wf;

end
