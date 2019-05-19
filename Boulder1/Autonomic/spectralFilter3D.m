function varf=spectralFilter3D(var,filt)
varf=ifftn(ifftshift(fftshift(fftn(var)).*filt));
end
