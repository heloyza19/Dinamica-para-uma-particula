function dinamica(X,Y,Xc,Yc,I,m)

ordem_y=sort(Y);
ordem_x=sort(X);
np=length(X); %Número de pontos

%PVI
[Frx,Fry,Tr]=campodeforca(X,Y,Xc,Yc);
F=[Frx; Fry]; 
Ax=Frx/m;
Ay=Fry/m;
Vx=0;                % Velocidade na coordenada X (m/s)
Vy=0;                 % Velocidade na coordenada Y (m/s)
W=0;
alfa=Tr/I;



for j=1:1:np
    R(j)=sqrt(((X(j)-Xc)^2)+((Y(j)-Yc)^2));
    teta(j)=atan((Y(j)-Yc)/(X(j)-Xc));
   if X(j)<Xc & Y(j)>Yc                 %segundo quadrante
       teta(j)=teta(j)+pi;
   elseif X(j)<Xc & Y(j)<Yc             %terceiro quadrante
       teta(j)=teta(j)-pi;
   end
end


%dimensionamento do gráfico  (ajeitar)
h =20;                %Altura max
d=20;                           %distancia maxima

%Tempo de integração
t=100;                 %(calcular o tempo para chegar ao solo)
dt = 0.01;             % Intervalo de tempo (s) 
times = 0 : dt : t;    %calcular tempo final da queda

%figure
ymax=ordem_y(1);
for i = 1:length(times)
    %h =20+ordem_y(np); 
    
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
    teta=teta+ones(1,np)*0.5*(c1+c2);
    W=W+alfa*dt; 
    %O objeto deve parar ao chegar em y=0 (chão)
    if ymax>h || xmax>d
        %deltay=ymin;
        %Y=Y+ones(1,np)*deltay;
        %ymin=0;
        %Xc
        %Ax
        %Yc
        %Ay
        %m
        %times(i)
        break
    end
    
    % Grava o plot atual
    mov(i)=getframe(gcf);
end
