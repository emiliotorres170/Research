%% Figure 9
figure(9)
fd=[18 5.5 6.69 3.3];             %Figure dimensions [x,y,w,h]
set(gcf,'Units','inches ','Position',fd,'Color','w'); %create figure
clf;

xp=0.055; yp=0.122; xoff=0.196; yoff=0.45;
wp=0.18; hp=0.37;
colormap(cmap)

clim1=[-0.4,0.4];
clim2=[-0.4,0.4];
tick=[0,2,4,6];

%ALES stresses N=2, test scale
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
%Dyn Smag stresses, test scale
i=1; j=1; subplot('Position',[xp+i*xoff,yp+j*yoff,wp,hp])
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
title('(b) DS, $\Delta_{t}$','FontSize',lfnt,'Interpreter','Latex')
axis equal tight;
caxis(clim2)
colorbar('peer',gca,'Position',[xp+i*xoff+wp+0.01,yp+j*yoff,0.025,hp])

%ALES stresses N=2, LES scale
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
title('(c) ALES $N=2$, $\Delta$','FontSize',lfnt,'Interpreter','Latex')
axis equal tight;
caxis(clim1)
%Dyn Smag stresses, LES scale
i=1; j=0; subplot('Position',[xp+i*xoff,yp+j*yoff,wp,hp])
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
title('(d) DS, $\Delta$','FontSize',lfnt,'Interpreter','Latex')
axis equal tight;
caxis(clim1)
colorbar('peer',gca,'Position',[xp+i*xoff+wp+0.01,yp+j*yoff,0.025,hp])
%pdfs, LES scale
i=2; j=0; subplot('Position',[xp+i*xoff+0.13,yp+j*yoff,0.4,0.8])
semilogy(squeeze(errbinSmag_fl(ic,1,:)), ...
         squeeze(errpdfSmag_fl(ic,1,:)),'-k','LineWidth',lwid)
hold on;
semilogy(squeeze(errbinEst_fln1(ic,1,:)), ...
         squeeze(errpdfEst_fln1(ic,1,:)),'-r','LineWidth',lwid)
semilogy(squeeze(errbinEst_fln2(ic,1,:)), ...
         squeeze(errpdfEst_fln2(ic,1,:)),'-b','LineWidth',lwid)
offs=1e0;
semilogy(squeeze(errbinSmag_ft(ic,1,:)), ...
         squeeze(errpdfSmag_ft(ic,1,:)).*offs,'--k','LineWidth',lwid)
semilogy(squeeze(errbinOpt_ftn1(ic,1,:)), ...
         squeeze(errpdfOpt_ftn1(ic,1,:)).*offs,'--r','LineWidth',lwid)
semilogy(squeeze(errbinOpt_ftn2(ic,1,:)), ...
         squeeze(errpdfOpt_ftn2(ic,1,:)).*offs,'--b','LineWidth',lwid)     
hold off;
title('(e) Pdfs, $\Delta$','FontSize',lfnt,'Interpreter','Latex')
set(gca,'FontName','Times','FontSize',pfnt,'TickLength',[0.02,0.02],...
    'Box','on','Layer','top')
ylabel('pdf','FontSize',lfnt,'Interpreter','Latex')
xlabel('$\tau_{11}$','FontSize',lfnt,'Interpreter','Latex')
axis([-2,2,1e-6,20])

set(gcf,'PaperPositionMode','auto')
print(gcf,'-r600','-dpng',[fdir 'errors_pdf' num2str(ic) '.png'])
