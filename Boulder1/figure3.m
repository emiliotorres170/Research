%% Figure 3
figure(3)
fd=[18 5.5 6.69 3.3];             %Figure dimensions [x,y,w,h]
set(gcf,'Units','inches ','Position',fd,'Color','w'); %create figure
clf;

xp=0.055; yp=0.122; xoff=0.196; yoff=0.45;
wp=0.18; hp=0.37;
colormap(cmap)

clim1=[-0.1,0.1];
clim2=[-0.1,0.1];
tick=[0,2,4,6];

%ALES N=2 stresses, test scale
i=0; j=1; subplot('Position',[xp+i*xoff,yp+j*yoff,wp,hp])
surface(x,y,transpose(squeeze(errOpt_ftn2m(ic,1,:,:))),'EdgeColor','none')
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
title('(a) ALES $N=2$, $\Delta_{t}$','FontSize',lfnt,'Interpreter','Latex')
axis equal tight;
caxis(clim2)
%ALES N=1 stresses, test scale
i=1; j=1; subplot('Position',[xp+i*xoff,yp+j*yoff,wp,hp])
surface(x,y,transpose(squeeze(errOpt_ftn1m(ic,1,:,:))),'EdgeColor','none')
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
title('(b) ALES $N=1$, $\Delta_{t}$','FontSize',lfnt,'Interpreter','Latex')
axis equal tight;
caxis(clim2)
%DS, test scale
i=2; j=1; subplot('Position',[xp+i*xoff,yp+j*yoff,wp,hp])
surface(x,y,transpose(squeeze(errSmag_ftm(ic,1,:,:))),'EdgeColor','none')
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
i=3; j=1; subplot('Position',[xp+i*xoff+0.112,yp+j*yoff,0.23,hp])
semilogy(squeeze(errbinSmag_ft(ic,1,:)), ...
         squeeze(errpdfSmag_ft(ic,1,:)),'-k','LineWidth',lwid)
hold on
semilogy(squeeze(errbinOpt_ftn1(ic,1,:)), ...
         squeeze(errpdfOpt_ftn1(ic,1,:)),'--r','LineWidth',lwid)
semilogy(squeeze(errbinOpt_ftn2(ic,1,:)), ...
         squeeze(errpdfOpt_ftn2(ic,1,:)),'-.b','LineWidth',lwid)
hold off;
title('(d) Pdfs, $\Delta_{t}$','FontSize',lfnt,'Interpreter','Latex')
set(gca,'FontName','Times','FontSize',pfnt,'TickLength',[0.02,0.02],...
    'Box','on','Layer','top','XTicklabel',{})
ylabel('pdf','FontSize',lfnt,'Interpreter','Latex')
axis([10*clim1(1),10*clim1(2),1e-5,20])

%ALES N=2 stresses, LES scale
i=0; j=0; subplot('Position',[xp+i*xoff,yp+j*yoff,wp,hp])
surface(x,y,transpose(squeeze(errEst_fln2m(ic,1,:,:))),'EdgeColor','none')
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
title('(e) ALES $N=2$, $\Delta$','FontSize',lfnt,'Interpreter','Latex')
axis equal tight;
caxis(clim1)
%ALES stresses, LES scale
i=1; j=0; subplot('Position',[xp+i*xoff,yp+j*yoff,wp,hp])
surface(x,y,transpose(squeeze(errEst_fln1m(ic,1,:,:))),'EdgeColor','none')
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
title('(f) ALES $N=1$, $\Delta$','FontSize',lfnt,'Interpreter','Latex')
axis equal tight;
caxis(clim1)
%DS stresses, LES scale
i=2; j=0; subplot('Position',[xp+i*xoff,yp+j*yoff,wp,hp])
surface(x,y,transpose(squeeze(errSmag_flm(ic,1,:,:))),'EdgeColor','none')
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
i=3; j=0; subplot('Position',[xp+i*xoff+0.112,yp+j*yoff,0.23,hp])
semilogy(squeeze(errbinSmag_fl(ic,1,:)), ...
         squeeze(errpdfSmag_fl(ic,1,:)),'-k','LineWidth',lwid)
hold on
semilogy(squeeze(errbinEst_fln1(ic,1,:)), ...
         squeeze(errpdfEst_fln1(ic,1,:)),'--r','LineWidth',lwid)
semilogy(squeeze(errbinEst_fln2(ic,1,:)), ...
         squeeze(errpdfEst_fln2(ic,1,:)),'-.b','LineWidth',lwid)
hold off;
title('(h) Pdfs, $\Delta$','FontSize',lfnt,'Interpreter','Latex')
set(gca,'FontName','Times','FontSize',pfnt,'TickLength',[0.02,0.02],...
    'Box','on','Layer','top')
ylabel('pdf','FontSize',lfnt,'Interpreter','Latex')
xlabel('$\tau_{11}$','FontSize',lfnt,'Interpreter','Latex')
axis([10*clim1(1),10*clim1(2),1e-5,20])

set(gcf,'PaperPositionMode','auto')
print(gcf,'-r600','-dpng',[fdir 'stress_error_ic' num2str(ic) '.png'])
