function  [Frx,Fry,torque]=forcaresultante(Xp,Yp,Xc,Yc,F,nx,ny,dx,Xmin,Ymin)  %Xp e Yp
dy=dx;
Fry=0;
Frx=0;
Tr=0;
torque=0;
for i=1:1:(ny-1)
    y=Ymin+dy*(i-1);
   for j=1:1:(nx-1)
     x=Xmin+dx*(j-1);
     [ni]=pontointerno(x,y,Xp,Yp);
     
     if mod(ni,2)==1
      Fry=Fry+F.y(i,j);
      Frx=Frx+F.x(i,j);
      Raio=[x-Xc;y-Yc];                     %vetor raio
      r=sqrt(Raio(1,1)^2+ Raio(2,1)^2);     %módulo do vetor R
      f=sqrt(F.x(i,j)^2+ F.y(i,j)^2);       %módulo da força
      Fp=[F.x(i,j); F.y(i,j)];
      pe=Raio'*Fp;                         %produto interno entre F e R
      ang=acos(pe/(f*r));                  %ângulo entre F e R
      torque=torque+f*r*sin(ang);          %Torque resultante
                             
      end
   end
   
end