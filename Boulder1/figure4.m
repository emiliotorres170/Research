%% Figure 4
figure(4)
fd=[18 5.5 6.69 3.5];             %Figure dimensions [x,y,w,h]
set(gcf,'Units','inches ','Position',fd,'Color','w'); %create figure
clf;

xp=0.055; yp=0.11; xoff=0.215; yoff=0.46;
wp=0.2; hp=0.37;
colormap(cmap)

clim1=[-1,1];
clim2=[-2,2];
tick=[0,2,4,6];

%True stresses, test scale
i=0; j=1; subplot('Position',[xp+i*xoff,yp+j*yoff,wp,hp])
surface(x,y,transpose(squeeze(sgs_ftm(ic,:,:))),'EdgeColor','none')
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
surface(x,y,transpose(squeeze(sgsOpt_ftn2m(ic,:,:))),'EdgeColor','none')
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
%ALES stresses N=1, test scale
i=2; j=1; subplot('Position',[xp+i*xoff,yp+j*yoff,wp,hp])
surface(x,y,transpose(squeeze(sgsOpt_ftn1m(ic,:,:))),'EdgeColor','none')
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
title('(c) ALES $N=1$, $\Delta_{t}$','FontSize',lfnt,'Interpreter','Latex')
axis equal tight;
caxis(clim2)
%Dyn Smag stresses, test scale
i=3; j=1; subplot('Position',[xp+i*xoff,yp+j*yoff,wp,hp])
surface(x,y,transpose(squeeze(sgsSmag_ftm(ic,:,:))),'EdgeColor','none')
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
title('(d) DS, $\Delta_{t}$','FontSize',lfnt,'Interpreter','Latex')
axis equal tight;
caxis(clim2)
colorbar('peer',gca,'Position',[xp+i*xoff+wp+0.01,yp+j*yoff,0.025,hp])

%True stresses, LES scale
i=0; j=0; subplot('Position',[xp+i*xoff,yp+j*yoff,wp,hp])
surface(x,y,transpose(squeeze(sgs_flm(ic,:,:))),'EdgeColor','none')
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
surface(x,y,transpose(squeeze(sgsEst_fln2m(ic,:,:))),'EdgeColor','none')
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
%ALES stresses N=1, LES scale
i=2; j=0; subplot('Position',[xp+i*xoff,yp+j*yoff,wp,hp])
surface(x,y,transpose(squeeze(sgsEst_fln1m(ic,:,:))),'EdgeColor','none')
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
title('(g) ALES $N=1$, $\Delta$','FontSize',lfnt,'Interpreter','Latex')
axis equal tight;
caxis(clim1)
%Dyn Smag stresses, LES scale
i=3; j=0; subplot('Position',[xp+i*xoff,yp+j*yoff,wp,hp])
surface(x,y,transpose(squeeze(sgsSmag_flm(ic,:,:))),'EdgeColor','none')
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
title('(h) DS, $\Delta$','FontSize',lfnt,'Interpreter','Latex')
axis equal tight;
caxis(clim1)
colorbar('peer',gca,'Position',[xp+i*xoff+wp+0.01,yp+j*yoff,0.025,hp])

set(gcf,'PaperPositionMode','auto')
print(gcf,'-r600','-dpng',[fdir 'sgsflux_ic' num2str(ic) '.png'])
