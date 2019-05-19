%% KL divergences %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eps=1e-16;
st=1; en=200;

for ic=1:nc
    % Stress test scale
    F=squeeze(pdf_ft(ic,1,st:en));
    Q=squeeze(pdfSmag_ft(ic,1,st:en));
    tauklSmag_ft(ic)=sum(F.*(log(F+eps)-log(Q+eps)));
    Q=squeeze(pdfOpt_ftn1(ic,1,st:en));
    tauklOpt_ftn1(ic)=sum(F.*(log(F+eps)-log(Q+eps)));
    Q=squeeze(pdfOpt_ftn2(ic,1,st:en));
    tauklOpt_ftn2(ic)=sum(F.*(log(F+eps)-log(Q+eps)));
    % Stress LES scale
    F=squeeze(pdf_fl(ic,1,st:en));
    Q=squeeze(pdfSmag_fl(ic,1,st:en));
    tauklSmag_fl(ic)=sum(F.*(log(F+eps)-log(Q+eps)));
    Q=squeeze(pdfEst_fln1(ic,1,st:en));
    tauklEst_fln1(ic)=sum(F.*(log(F+eps)-log(Q+eps)));
    Q=squeeze(pdfEst_fln2(ic,1,st:en));
    tauklEst_fln2(ic)=sum(F.*(log(F+eps)-log(Q+eps)));
    % SGS flux test scale
    F=squeeze(sgspdf_ft(ic,st:en));
    Q=squeeze(sgspdfSmag_ft(ic,st:en));
    sgsklSmag_ft(ic)=sum(F.*(log(F+eps)-log(Q+eps)));
    Q=squeeze(sgspdfOpt_ftn1(ic,st:en));
    sgsklOpt_ftn1(ic)=sum(F.*(log(F+eps)-log(Q+eps)));
    Q=squeeze(sgspdfOpt_ftn2(ic,st:en));
    sgsklOpt_ftn2(ic)=sum(F.*(log(F+eps)-log(Q+eps)));
    % SGS flux LES scale
    F=squeeze(sgspdf_fl(ic,st:en));
    Q=squeeze(sgspdfSmag_fl(ic,st:en));
    sgsklSmag_fl(ic)=sum(F.*(log(F+eps)-log(Q+eps)));
    Q=squeeze(sgspdfEst_fln1(ic,st:en));
    sgsklEst_fln1(ic)=sum(F.*(log(F+eps)-log(Q+eps)));
    Q=squeeze(sgspdfEst_fln2(ic,st:en));
    sgsklEst_fln2(ic)=sum(F.*(log(F+eps)-log(Q+eps)));
end