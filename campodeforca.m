function  [Frx,Fry,Tr]=campodeforca(Xp,Yp,Xc,Yc)
Xmin=0;
Xmax=5;
Ymin=0;
Ymax=20;
dx=0.02;
dy=dx;
nx=ceil((Xmax-Xmin)/dx);
ny=ceil ((Ymax-Ymin)/dy);

%Campo de força
F=struct('x',0.1*ones(ny,nx),'y',0.1*ones(ny,nx));
[Frx,Fry,Tr]=forcaresultante(Xp,Yp,Xc,Yc,F,nx,ny,dx,Xmin,Ymin);