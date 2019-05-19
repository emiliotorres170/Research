%% Figure 6
figure(6)
fd=[20 5.5 4 3.2];             
set(gcf,'Units','inches ','Position',fd,'Color','w'); 
clf;

xp=0.12; yp=0.122; wp=0.85; hp=0.85;

kp=linspace(1,length(Ek(2:end)),length(Ek(2:end)));

subplot('Position',[xp,yp,wp,hp])
%semilogx(lamm,errnEst_fln2(:,1),'-.b','LineWidth',lwid)
semilogy(ftm,errnEst_fln2(:,1),'-.b','LineWidth',lwid)
hold on;
%semilogx(lamm,errnEst_fln1(:,1),'--r','LineWidth',lwid)
plot(ftm,errnEst_fln1(:,1),'--r','LineWidth',lwid)
hold off;
axis tight;
set(gca,'FontName','Times','FontSize',pfnt,'TickLength',[0.02,0.02])
%xlabel('$\lambda$','Interpreter','Latex','FontSize',lfnt)
xlabel('$\Delta_t$','Interpreter','Latex','FontSize',lfnt)
ylabel('Error','Interpreter','Latex','FontSize',lfnt)

set(gcf,'PaperPositionMode','auto')
print(gcf,'-dpdf',[fdir 'error_test.pdf'])

