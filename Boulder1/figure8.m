%% Figure 8
figure(8)
fd=[18 5.5 6.69 3.3];             %Figure dimensions [x,y,w,h]
set(gcf,'Units','inches ','Position',fd,'Color','w'); %create figure
clf;

xp=0.05; yp=0.122; xoff=0.196; yoff=0.45;
wp=0.18; hp=0.37;
colormap(cmap)
pfnt=9; 
lfnt=10;

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
%Dyn Smag stresses, test scale
i=2; j=1; subplot('Position',[xp+i*xoff,yp+j*yoff,wp,hp])
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
title('(c) DS, $\Delta_{t}$','FontSize',lfnt,'Interpreter','Latex')
axis equal tight;
caxis(clim2)
colorbar('peer',gca,'Position',[xp+i*xoff+wp+0.01,yp+j*yoff,0.025,hp])
%pdfs, test scale
i=3; j=1; subplot('Position',[xp+i*xoff+0.12,yp+j*yoff,0.23,hp])
semilogy(squeeze(sgsbin_ft(ic,:)), ...
         squeeze(sgspdf_ft(ic,:)),'-k','LineWidth',lwid)
hold on
semilogy(squeeze(sgsbinSmag_ft(ic,:)), ...
         squeeze(sgspdfSmag_ft(ic,:)),'-k','LineWidth',1)
semilogy(squeeze(sgsbinOpt_ftn1(ic,:)), ...
         squeeze(sgspdfOpt_ftn1(ic,:)),'-r','LineWidth',lwid)
semilogy(squeeze(sgsbinOpt_ftn2(ic,:)), ...
         squeeze(sgspdfOpt_ftn2(ic,:)),'-b','LineWidth',lwid)
hold off;
title('(d) Pdfs, $\Delta_{t}$','FontSize',lfnt,'Interpreter','Latex')
set(gca,'FontName','Times','FontSize',pfnt,'TickLength',[0.02,0.02],...
    'Box','on','Layer','top','XTick',[-4,-2,0,2,4],'XTicklabel',{},...
    'YTick',[1e-5,1e-4,1e-3,1e-2,1e-1,1e0,1e1,1e2],...
    'YTickLabel',{'10^{-5}','','10^{-3}','','10^{-1}','','10^{1}'})
ylabel('pdf','FontSize',lfnt,'Interpreter','Latex')
axis([-4.1,4.1,1e-5,20])

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
%Dyn Smag stresses, LES scale
i=2; j=0; subplot('Position',[xp+i*xoff,yp+j*yoff,wp,hp])
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
title('(g) DS, $\Delta$','FontSize',lfnt,'Interpreter','Latex')
axis equal tight;
caxis(clim1)
colorbar('peer',gca,'Position',[xp+i*xoff+wp+0.01,yp+j*yoff,0.025,hp])
%pdfs, LES scale
i=3; j=0; subplot('Position',[xp+i*xoff+0.12,yp+j*yoff,0.23,hp])
semilogy(squeeze(sgsbin_fl(ic,:)), ...
         squeeze(sgspdf_fl(ic,:)),'-k','LineWidth',lwid)
hold on
semilogy(squeeze(sgsbinSmag_fl(ic,:)), ...
         squeeze(sgspdfSmag_fl(ic,:)),'-k','LineWidth',1)
semilogy(squeeze(sgsbinEst_fln1(ic,:)), ...
         squeeze(sgspdfEst_fln1(ic,:)),'-r','LineWidth',lwid)
semilogy(squeeze(sgsbinEst_fln2(ic,:)), ...
         squeeze(sgspdfEst_fln2(ic,:)),'-b','LineWidth',lwid)
hold off;
title('(h) Pdfs, $\Delta$','FontSize',lfnt,'Interpreter','Latex')
set(gca,'FontName','Times','FontSize',pfnt,'TickLength',[0.02,0.02],...
    'Box','on','Layer','top','XTick',[-4,-2,0,2,4],...
    'YTick',[1e-5,1e-4,1e-3,1e-2,1e-1,1e0,1e1,1e2],...
    'YTickLabel',{'10^{-5}','','10^{-3}','','10^{-1}','','10^{1}'})
ylabel('pdf','FontSize',lfnt,'Interpreter','Latex')
xlabel('$\tau^\Delta_{ij}\widetilde{S}_{ij}$, $\tau^{\Delta_t}_{ij}\widehat{S}_{ij}$',...
    'FontSize',lfnt,'Interpreter','Latex')
axis([-4.1,4.1,1e-5,20])

set(gcf,'PaperPositionMode','auto')
print(gcf,'-r600','-dpng',[fdir 'sgs_pdf' num2str(ic) '.png'])
