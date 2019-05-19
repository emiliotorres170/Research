% $$$ figure(1)
% $$$      grid=256;colormap jet;
% $$$      set(gcf, 'Color', 'w');
% $$$     imagesc(squeeze(var(1,:,:,vizSlice2)),clims);
% $$$     %XTick('off');
% $$$     ylabel('$u_1$','interpreter','latex', ...
% $$$            'fontsize',18);
% $$$     axis square tight;
% $$$     
% $$$     export_fig gcf M1_u.png -q101
% $$$     
% $$$ figure(2)
% $$$      grid=256;colormap jet;
% $$$      set(gcf, 'Color', 'w');
% $$$     imagesc(squeeze(tau_fl(1,:,:,vizSlice2)),clims1);
% $$$    
% $$$     ylabel('$\widetilde{\tau_{11}}$','interpreter','latex', ...
% $$$            'fontsize',18);
% $$$     axis square tight;
% $$$     
% $$$     export_fig gcf tau1_uf.png -q101
% $$$     
% $$$ figure(3)
% $$$      grid=256;colormap jet;
% $$$      set(gcf, 'Color', 'w');
% $$$     imagesc(squeeze(tau_ft(1,:,:,vizSlice2)),clims);
% $$$     
% $$$     ylabel('$\widehat{\widetilde{\tau_{11}}}$','interpreter','latex', ...
% $$$            'fontsize',18);
% $$$     axis square tight;
% $$$     
% $$$     export_fig gcf tau1_ut.png -q101
% $$$     
   
    figure(2)
     grid=256;colormap jet;
     set(gcf, 'Color', 'w');
    imagesc(squeeze(tau_fl(1,:,:,vizSlice2)),clims1);
   
    ylabel('$\tau_{11}$','interpreter','latex', ...
           'fontsize',18);
    axis square tight;
    
    export_fig gcf tau1_uf.png -q101
    
figure(3)
     grid=256;colormap jet;
     set(gcf, 'Color', 'w');
    imagesc(squeeze(tau_ft(1,:,:,vizSlice2)),clims);
    
    ylabel('$T_{11}$','interpreter','latex', ...
           'fontsize',18);
    axis square tight;
    
    export_fig gcf tau1_ut.png -q101