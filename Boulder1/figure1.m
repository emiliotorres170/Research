%% Figure 1
figure(1)
fd=[20 5.5 4 3.2];             
set(gcf,'Units','inches ','Position',fd,'Color','w'); 
clf;

xp=0.12; yp=0.122; wp=0.85; hp=0.85;

kp=linspace(1,length(Ek(2:end)),length(Ek(2:end)));

subplot('Position',[xp,yp,wp,hp])
loglog(kp,Ek(2:end)./Ek(2),'-k','LineWidth',2)
hold on;
loglog(kp,kp.^(-5/3),'--r')
hold off;
set(gca,'FontName','Times','FontSize',pfnt,'TickLength',[0.02,0.02])
axis([1,500,1e-6,2])
line(flm(ic)*[1,1],ylim,'LineStyle','-.','Color','b')
line(ftm(ic)*[1,1],ylim,'LineStyle','-.','Color','b')
xlabel('Wavenumber $k$','Interpreter','Latex','FontSize',lfnt)
ylabel('$E(k)$','Interpreter','Latex','FontSize',lfnt) 
ty=get(gca,'ylim');
text(flm(ic)*1.06,ty(1)*3,'$\Delta^{-1}$','Interpreter','Latex','FontSize',lfnt)
text(ftm(ic)*1.06,ty(1)*3,'$\Delta_t^{-1}$','Interpreter','Latex','FontSize',lfnt)

set(gcf,'PaperPositionMode','auto')
print(gcf,'-dpdf',[fdir 'spectrum_ic' num2str(ic) '.pdf'])

