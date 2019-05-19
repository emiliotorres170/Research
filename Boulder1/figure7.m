%% Figure 7
figure(7)
fd=[18 5.5 6.69 3.3];             %Figure dimensions [x,y,w,h]
set(gcf,'Units','inches ','Position',fd,'Color','w'); %create figure
clf;

xp=0.05; yp=0.122; xoff=0.196; yoff=0.45;
wp=0.18; hp=0.37;
colormap(cmap)
pfnt=9; 
lfnt=10;

clim1=[-0.1,0.1];
clim2=[-0.2,0.2];
tick=[0,2,4,6];

%True stresses, test scale
i=0; j=1; subplot('Position',[xp+i*xoff,yp+j*yoff,wp,hp])
surface(x,y,transpose(squeeze(tau_ftm(ic,1,:,:))),'EdgeColor','none')
set(gca,'FontName','Times','FontSize',pfnt,'TickLength',[0.02,0.02],...
    'Box','on','Layer','top','XTick',tick,'YTick',tick)
if (j~=0)
    set(gca,'XTickLabel',{})
end
if (i~=0)
    set(gca,'YTickLabel',{})
end
if (i==0)
    ylabel('$y$','Interpreter','Latex','FontSize',lfnt)
end
if (j==0)
    xlabel('$x$','Interpreter','Latex','FontSize',lfnt)
end
title('(a) DNS, $\Delta_{t}$','FontSize',lfnt,'Interpreter','Latex')
axis equal tight;
caxis(clim2)
%ALES stresses N=2, test scale
i=1; j=1; subplot('Position',[xp+i*xoff,yp+j*yoff,wp,hp])
surface(x,y,transpose(squeeze(tauOpt_ftn2m(ic,1,:,:))),'EdgeColor','none')
set(gca,'FontName','Times','FontSize',pfnt,'TickLength',[0.02,0.02],...
    'Box','on','Layer','top','XTick',tick,'YTick',tick)
if (j~=0)
    set(gca,'XTickLabel',{})
end
if (i~=0)
    set(gca,'YTickLabel',{})
end
if (i==0)
    ylabel('$y$','Interpreter','Latex','FontSize',lfnt)
end
if (j==0)
    xlabel('$x$','Interpreter','Latex','FontSize',lfnt)
end
title('(b) ALES $N=2$, $\Delta_{t}$','FontSize',lfnt,'Interpreter','Latex')
axis equal tight;
caxis(clim2)
%Dyn Smag stresses, test scale
i=2; j=1; subplot('Position',[xp+i*xoff,yp+j*yoff,wp,hp])
surface(x,y,transpose(squeeze(tauSmag_ftm(ic,1,:,:))),'EdgeColor','none')
set(gca,'FontName','Times','FontSize',pfnt,'TickLength',[0.02,0.02],...
    'Box','on','Layer','top','XTick',tick,'YTick',tick)
if (j~=0)
    set(gca,'XTickLabel',{})
end
if (i~=0)
    set(gca,'YTickLabel',{})
end
if (i==0)
    ylabel('$y$','Interpreter','Latex','FontSize',lfnt)
end
if (j==0)
    xlabel('$x$','Interpreter','Latex','FontSize',lfnt)
end
title('(c) DS, $\Delta_{t}$','FontSize',lfnt,'Interpreter','Latex')
axis equal tight;
caxis(clim2)
colorbar('peer',gca,'Position',[xp+i*xoff+wp+0.01,yp+j*yoff,0.025,hp])
%pdfs, test scale
i=3; j=1; subplot('Position',[xp+i*xoff+0.12,yp+j*yoff,0.23,hp])
semilogy(squeeze(bin_ft(ic,1,:)), ...
         squeeze(pdf_ft(ic,1,:)),'-k','LineWidth',lwid)
hold on
semilogy(squeeze(binSmag_ft(ic,1,:)), ...
         squeeze(pdfSmag_ft(ic,1,:)),'-k','LineWidth',1)
semilogy(squeeze(binOpt_ftn1(ic,1,:)), ...
         squeeze(pdfOpt_ftn1(ic,1,:)),'-r','LineWidth',lwid)
semilogy(squeeze(binOpt_ftn2(ic,1,:)), ...
         squeeze(pdfOpt_ftn2(ic,1,:)),'-b','LineWidth',lwid)
hold off;
title('(d) Pdfs, $\Delta_{t}$','FontSize',lfnt,'Interpreter','Latex')
set(gca,'FontName','Times','FontSize',pfnt,'TickLength',[0.02,0.02],...
    'Box','on','Layer','top','XTick',[-1,-0.5,0,0.5,1],'XTicklabel',{},...
    'YTick',[1e-5,1e-4,1e-3,1e-2,1e-1,1e0,1e1,1e2],...
    'YTickLabel',{'10^{-5}','','10^{-3}','','10^{-1}','','10^{1}'})
ylabel('pdf','FontSize',lfnt,'Interpreter','Latex')
axis([-1.1,1.1,4e-5,50])
%axis([-0.2,0.2,0,20])

%True stresses, LES scale
i=0; j=0; subplot('Position',[xp+i*xoff,yp+j*yoff,wp,hp])
surface(x,y,transpose(squeeze(tau_flm(ic,1,:,:))),'EdgeColor','none')
set(gca,'FontName','Times','FontSize',pfnt,'TickLength',[0.02,0.02],...
    'Box','on','Layer','top','XTick',tick,'YTick',tick)
if (j~=0)
    set(gca,'XTickLabel',{})
end
if (i~=0)
    set(gca,'YTickLabel',{})
end
if (i==0)
    ylabel('$y$','Interpreter','Latex','FontSize',lfnt)
end
if (j==0)
    xlabel('$x$','Interpreter','Latex','FontSize',lfnt)
end
title('(e) DNS, $\Delta$','FontSize',lfnt,'Interpreter','Latex')
axis equal tight;
caxis(clim1)
%ALES stresses N=2, LES scale
i=1; j=0; subplot('Position',[xp+i*xoff,yp+j*yoff,wp,hp])
surface(x,y,transpose(squeeze(tauEst_fln2m(ic,1,:,:))),'EdgeColor','none')
set(gca,'FontName','Times','FontSize',pfnt,'TickLength',[0.02,0.02],...
    'Box','on','Layer','top','XTick',tick,'YTick',tick)
if (j~=0)
    set(gca,'XTickLabel',{})
end
if (i~=0)
    set(gca,'YTickLabel',{})
end
if (i==0)
    ylabel('$y$','Interpreter','Latex','FontSize',lfnt)
end
if (j==0)
    xlabel('$x$','Interpreter','Latex','FontSize',lfnt)
end
title('(f) ALES $N=2$, $\Delta$','FontSize',lfnt,'Interpreter','Latex')
axis equal tight;
caxis(clim1)
%Dyn Smag stresses, LES scale
i=2; j=0; subplot('Position',[xp+i*xoff,yp+j*yoff,wp,hp])
surface(x,y,transpose(squeeze(tauSmag_flm(ic,1,:,:))),'EdgeColor','none')
set(gca,'FontName','Times','FontSize',pfnt,'TickLength',[0.02,0.02],...
    'Box','on','Layer','top','XTick',tick,'YTick',tick)
if (j~=0)
    set(gca,'XTickLabel',{})
end
if (i~=0)
    set(gca,'YTickLabel',{})
end
if (i==0)
    ylabel('$y$','Interpreter','Latex','FontSize',lfnt)
end
if (j==0)
    xlabel('$x$','Interpreter','Latex','FontSize',lfnt)
end
title('(g) DS, $\Delta$','FontSize',lfnt,'Interpreter','Latex')
axis equal tight;
caxis(clim1)
colorbar('peer',gca,'Position',[xp+i*xoff+wp+0.01,yp+j*yoff,0.025,hp])
%pdfs, LES scale
i=3; j=0; subplot('Position',[xp+i*xoff+0.12,yp+j*yoff,0.23,hp])
semilogy(squeeze(bin_fl(ic,1,:)), ...
         squeeze(pdf_fl(ic,1,:)),'-k','LineWidth',lwid)
hold on
semilogy(squeeze(binSmag_fl(ic,1,:)), ...
         squeeze(pdfSmag_fl(ic,1,:)),'-k','LineWidth',1)
semilogy(squeeze(binEst_fln1(ic,1,:)), ...
         squeeze(pdfEst_fln1(ic,1,:)),'-r','LineWidth',lwid)
semilogy(squeeze(binEst_fln2(ic,1,:)), ...
         squeeze(pdfEst_fln2(ic,1,:)),'-b','LineWidth',lwid)
hold off;
title('(h) Pdfs, $\Delta$','FontSize',lfnt,'Interpreter','Latex')
set(gca,'FontName','Times','FontSize',pfnt,'TickLength',[0.02,0.02],...
    'Box','on','Layer','top','XTick',[-1,-0.5,0,0.5,1],...
    'YTick',[1e-5,1e-4,1e-3,1e-2,1e-1,1e0,1e1,1e2],...
    'YTickLabel',{'10^{-5}','','10^{-3}','','10^{-1}','','10^{1}'})
ylabel('pdf','FontSize',lfnt,'Interpreter','Latex')
xlabel('$\tau_{11}^\Delta$, $\tau_{11}^{\Delta_t}$','FontSize',lfnt,...
    'Interpreter','Latex')
axis([-1.1,1.1,4e-5,50])

set(gcf,'PaperPositionMode','auto')
print(gcf,'-r600','-dpng',[fdir 'stress_pdf' num2str(ic) '.png'])
