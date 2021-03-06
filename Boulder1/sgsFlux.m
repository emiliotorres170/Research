function sgs=sgsFlux(tau,Sij)

sgs=squeeze(tau(1,:,:,:)).*squeeze(Sij(1,1,:,:,:))...
 +2*squeeze(tau(2,:,:,:)).*squeeze(Sij(1,2,:,:,:))...
 +2*squeeze(tau(3,:,:,:)).*squeeze(Sij(1,3,:,:,:))...
   +squeeze(tau(4,:,:,:)).*squeeze(Sij(2,2,:,:,:))...
 +2*squeeze(tau(5,:,:,:)).*squeeze(Sij(2,3,:,:,:))...
   +squeeze(tau(6,:,:,:)).*squeeze(Sij(3,3,:,:,:));      

end