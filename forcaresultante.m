function  [Frx,Fry,Tr]=forcaresultante(Xp,Yp,Xc,Yc,F,nx,ny,dx)  %Xp e Yp
Xmin=0;
Ymin=0;
dy=dx;
Fry=0;
Frx=0;
Tr=0;
m=0;
torque=0;
for i=1:1:(nx)
    x=Xmin+dx*(i-1);
    %x=Xm(i);
   for j=1:1:(ny)
     y=Ymin+dy*(j-1);
     %y=Ym(j);
     [ni]=pontointerno(x,y,Xp,Yp);
     
     if mod(ni,2)==1
      m=m+1;
      Fry=Fry+F.y(j);
      Frx=Frx+F.x(i);
      Raio=[x-Xc;y-Yc];                     %vetor raio
      r=sqrt(Raio(1,1)^2+ Raio(2,1)^2);     %módulo do vetor R
      f=sqrt(F.x(i)^2+ F.y(i)^2);       %módulo da força
      Fp=[F.x(i); F.y(j)];
      pe=Raio'*Fp;                         %produto interno entre F e R
      ang=acos(pe/(f*r));                  %ângulo entre F e R
      torque=torque+f*r*sin(ang);          %Torque resultante
                             
      end
   end
   
end
