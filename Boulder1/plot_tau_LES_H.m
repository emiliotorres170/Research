figure();
colormap jet;

    subplot(231);imagesc(squeeze(tau_ft(1,:,:,vizSlice1)),ctau);
    title('$T_{uu}$','interpreter','latex','fontsize',12);
    h = gca; h.XTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    h.YTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    ylabel('z = 64');
    axis square;
    
   
    
    subplot(234);imagesc(squeeze(tau_ft(4,:,:,vizSlice1)),ctau);
    title('$T_{vv}$','interpreter','latex','fontsize',12);
    h=gca;h.XTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    h.YTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    axis square;
    
    
    
    subplot(236);imagesc(squeeze(tau_ft(6,:,:,vizSlice1)),ctau);
    title('$T_{ww}$','interpreter','latex','fontsize',12);
    h=gca;h.XTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    h.YTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    axis square;
    

 figure();
 colormap jet;
    subplot(231);imagesc(squeeze(tau_ft(1,:,:,vizSlice2)),ctau);
    title('$T_{uu}$','interpreter','latex','fontsize',12);
    h = gca; h.XTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    h.YTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    ylabel('z = 128');
    axis square;
    
   
    
    subplot(234);imagesc(squeeze(tau_ft(4,:,:,vizSlice2)),ctau);
    title('$T_{vv}$','interpreter','latex','fontsize',12);
    h=gca;h.XTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    h.YTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    axis square;
    
    
    
    subplot(236);imagesc(squeeze(tau_ft(6,:,:,vizSlice2)),ctau);
    title('$T_{ww}$','interpreter','latex','fontsize',12);
    h=gca;h.XTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    h.YTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    axis square;
    
    
 figure();
 colormap jet;
    subplot(231);imagesc(squeeze(tau_ft(1,:,:,vizSlice3)),ctau);
    title('$T_{uu}$','interpreter','latex','fontsize',12);
    h = gca; h.XTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    h.YTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    ylabel('z = 192');
    axis square;
    
   
    
    subplot(234);imagesc(squeeze(tau_ft(4,:,:,vizSlice3)),ctau);
    title('$T_{vv}$','interpreter','latex','fontsize',12);
    h=gca;h.XTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    h.YTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    axis square;
    
    
    
    subplot(236);imagesc(squeeze(tau_ft(6,:,:,vizSlice3)),ctau);
    title('$T_{ww}$','interpreter','latex','fontsize',12);
    h=gca;h.XTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    h.YTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    axis square;
    