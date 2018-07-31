function dinamica(X,Y,Xc,Yc,I,m)
Xmin=0;
Xmax=100;
Ymin=0;
Ymax=100;
dx=0.2;
dy=dx;
nx=ceil((Xmax-Xmin)/dx);
ny=ceil ((Ymax-Ymin)/dy);
xco=Xc;
yco=Yc;
ordem_y=sort(Y);
ordem_x=sort(X);
np=length(X); %Número de pontos

%PVI
%[F]=campodeforcacont(Xmin,Ymin,dx,dy,nx,ny);
[F,Xp,Yp]=campodeforca(Xmin,Ymin,dx,dy,nx,ny);
Vx=0;                 % Velocidade na coordenada X (m/s)
Vxo=Vx;
Vy=0;                 % Velocidade na coordenada Y (m/s)
Vyo=Vy;
W=0;                  %Velocidade angular
Wo=W;

%Tempo de integração
t=50;                 
dt = 0.05;             % Intervalo de tempo (s) 
times = 0 : dt : t;    


for j=1:1:np
    R(j)=sqrt(((X(j)-Xc)^2)+((Y(j)-Yc)^2));
    teta(j)=atan((Y(j)-Yc)/(X(j)-Xc));
   if X(j)<Xc & Y(j)>Yc                 %segundo quadrante
       teta(j)=teta(j)+pi;
   elseif X(j)<Xc & Y(j)<Yc             %terceiro quadrante
       teta(j)=teta(j)-pi;
   end
end
tetai=teta;

%dimensionamento do gráfico  (ajeitar)
h =100;                %Altura max
d=100;                           %distancia maxima

set(gca,'nextplot','replacechildren'); 
v = VideoWriter('peaks.avi');
open(v);

%figure
ymax=ordem_y(1);
for i = 1:length(times)
    [Frx,Fry,Tr]=forcaresultante(X,Y,Xc,Yc,F,nx,ny,dx);
    Ax=Frx/m;
    Ay=Fry/m; 
    alfa=Tr/I;            %Aceleração angular
    % Representação das partículas e caixa 
    plot(X,Y); fill(X,Y,'r'); hold on;
    plot([0 d],[0 0],'k',[0 d],[h h],'w',[0 0],[0 h],'w',[d d],[0 h],'w','LineWidth',5); hold off;
    axis([-0.1,d+0.1,-0.1,h+0.1]); 
    xlabel('Coordenada x (m)');
    ylabel('Coordenada y (m)');
     if ymax==0
         break
     end
    
    % Atualiza a posição do objeto através de RK2
    %Componente X
    m1=Vx;
    m2=Vx+dt*Ax;
    Xc=Xc+dt*0.5*(m1+m2);
    Vx=Vx+Ax*dt;
    
    %Componente Y
    M1=Vy;
    M2=Vy+dt*Ay;
    Yc=Yc+dt*0.5*(M1+M2);
    Vy=Vy+Ay*dt;
    
    ordem_y=sort(Y);
    ordem_x=sort(X);
    ymax=ordem_y(np);
    xmax=ordem_x(np);
    
    %Rotação do objeto
    X=ones(1,np).*Xc+R.*cos(teta);
    Y=ones(1,np).*Yc+R.*sin(teta);
    c1=W;
    c2=W+alfa*dt;
    teta=teta+ones(1,np)*0.5*(c1+c2)*dt;
    W=W+alfa*dt; 
    %O objeto deve parar ao chegar em y=0 (chão)
    if ymax>h || xmax>d 
        %T=times(i);
        %xanalitico=xco+Vxo*times(i)+0.5*Ax*T*T;
        %erro_relaticox=(Xc-xanalitico)/xanalitico
        %yanalitico=yco+Vyo*times(i)+0.5*Ay*T*T;
        %erro_relativoy=(Yc-yanalitico)/yanalitico
        %rev=(teta(1)-tetai(1))/(2*pi);
        %revanalitico=(Wo*T+0.5*alfa*T*T)/(2*pi);
        %erro_relativoteta=(rev-revanalitico)/revanalitico
       
        break
    end
 
    % Grava o plot atual
    frame=getframe(gcf);
    writeVideo(v,frame);
end
close(v);