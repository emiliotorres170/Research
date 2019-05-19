function [errn,errpdf,errbin]=sgsPDF(err,nx,bins)

errn = mean(mean(mean(err.^2)));
[cnt,bin]=hist(reshape(err,nx(1)*nx(2)*nx(3),1),bins);
errpdf=cnt./trapz(bin,cnt);
errbin=bin;

end