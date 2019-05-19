function Sij = Sij3DFaster(var,dx)

u=squeeze(var(1,:,:,:));
v=squeeze(var(2,:,:,:));
w=squeeze(var(3,:,:,:));

[A12,A11,A13] = gradient(u,dx(1),dx(2),dx(3));
[A22,A21,A23] = gradient(v,dx(1),dx(2),dx(3));
[A32,A31,A33] = gradient(w,dx(1),dx(2),dx(3));

Sij(1,1,:,:,:)=0.5*(A11+A11); 
Sij(1,2,:,:,:)=0.5*(A12+A21);
Sij(1,3,:,:,:)=0.5*(A13+A31); 
Sij(2,2,:,:,:)=0.5*(A22+A22); 
Sij(2,3,:,:,:)=0.5*(A23+A32);
Sij(3,3,:,:,:)=0.5*(A33+A33);
Sij(2,1,:,:,:)=Sij(1,2,:,:,:);
Sij(3,1,:,:,:)=Sij(1,3,:,:,:);
Sij(3,2,:,:,:)=Sij(2,3,:,:,:);

end


