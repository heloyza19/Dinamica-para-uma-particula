function  [F]=campodeforcacont(Xmin,Ymin,dx,dy,nx,ny)

%Campo de força
F=struct('x',0.1*ones(ny,nx),'y',0.1*ones(ny,nx));