function [errn,errpdf,errbin]=tauPDF(err,nx,bins)

nbins=length(bins);

errn=zeros(6,1);
errpdf=zeros(6,nbins);
errbin=zeros(6,nbins);
for ij=1:6
    errn(ij)= mean(mean(mean(squeeze(err(ij,:,:,:)).^2)));
    [cnt,bin]=hist(reshape(squeeze(err(ij,:,:,:)),...
                                               nx(1)*nx(2)*nx(3),1),bins);
    errpdf(ij,:)=cnt./trapz(bin,cnt);
    errbin(ij,:)=bin;
end

end