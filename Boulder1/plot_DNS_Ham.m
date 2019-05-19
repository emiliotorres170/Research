
figure(); clims=[-20 20];
colormap jet
    subplot(331); imagesc(squeeze(var_ft(1,:,:,vizSlice1)),clims);
    title('$\widehat{\widetilde{u_1}}$','interpreter','latex','fontsize',12);
    h = gca; h.XTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    h.YTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    ylabel('z = 64');
    axis square;
    subplot(332);imagesc(squeeze(var_ft(2,:,:,vizSlice1)),clims);
    title('$\widehat{\widetilde{u_1}}$','interpreter','latex','fontsize',12);
    h=gca; h.XTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    h.YTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    axis square;
    subplot(333);imagesc(squeeze(var_ft(3,:,:,vizSlice1)),clims);
    title('$\widehat{\widetilde{u_1}}$','interpreter','latex','fontsize',12);
    h=gca;h.XTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    h.YTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    axis square;
    
    subplot(334);imagesc(squeeze(var_ft(1,:,:,vizSlice2)),clims);
    h=gca;h.XTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    h.YTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    ylabel('z = 128');
    axis square;
    subplot(335);imagesc(squeeze(var_ft(2,:,:,vizSlice2)),clims);
    h=gca;h.XTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    h.YTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    axis square;
    subplot(336);imagesc(squeeze(var_ft(3,:,:,vizSlice2)),clims);
    h=gca;h.XTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    h.YTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    axis square;
    
    subplot(337);imagesc(squeeze(var_ft(1,:,:,vizSlice3)),clims);
    h=gca;h.XTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    h.YTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    ylabel('z = 192');
    axis square;
    subplot(338);imagesc(squeeze(var_ft(2,:,:,vizSlice3)),clims);
    h=gca;h.XTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    h.YTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    axis square;
    subplot(339);imagesc(squeeze(var_ft(3,:,:,vizSlice3)),clims);
    h=gca;h.XTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    h.YTick = [0, 0.25*grid, 0.5*grid, 0.75*grid, grid];
    axis square;
   