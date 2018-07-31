function  [F,Xp,Yp]=campodeforca(Xmin,Ymin,dx,dy,nx,ny)

%Campo de força
%F=struct('x',0.1*ones(ny,nx),'y',0.1*ones(ny,nx));
Xe=50;
Ye=50;
for i=1:1:nx
    Xp(i)=Xmin+(i-1)*dx;
    for j=i:1:ny
        Yp(j)=Ymin+(j-1)*dy;
        R(i)=sqrt((Xp(i)-Xe)^2+(Yp(j)-Ye)^2);
        r=R(i);
        if r==0
            F.x(i)=0;
            F.y(j)=0;
        else
            F.x(i)=(1/(r^2))*(Xe-Xp(i));
            F.y(j)=(1/(r^2))*(Ye-Yp(j));
        end
    end
    
end



