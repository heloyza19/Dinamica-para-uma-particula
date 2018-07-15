function dinamica(X,Y,Xc,Yc,m)
ordem_y=sort(Y);
ordem_x=sort(X);
np=length(X); %Número de pontos
%PVI
Ax=0;
Ay=-9.81;
Vx =10;       % Velocidade na coordenada X (m/s)
Vy =0;        % Velocidade na coordenada Y (m/s)

%dimensionamento do gráfico  (ajeitar)
h =ordem_y(np)+2;                %Altura max
d=100;                           %distancia maxima

%Tempo de integração
t=100;                 %(calcular o tempo para chegar ao solo)
dt = 0.01;             % Intervalo de tempo (s) 
times = 0 : dt : t;    %calcular tempo final da queda

%figure
ymin=ordem_y(1);
for i = 1:length(times)
    
    % Representação das partículas e caixa 
    plot(X,Y); fill(X,Y,'b'); hold on;
    plot([0 d],[0 0],'k',[0 d],[h h],'w',[0 0],[0 h],'w',[d d],[0 h],'w','LineWidth',5); hold off;
    axis([-0.1,d+0.1,-0.1,h+0.1]); 
    xlabel('Coordenada x (m)');
    ylabel('Coordenada y (m)');
     if ymin==0
         break
     end
    
    % Atualiza a posição do objeto através de RK2
    %Componente X
    m1=Vx;
    m2=Vx+dt*Ax;
    X=X+ones(1,np)*dt*0.5*(m1+m2);
    Vx=Vx+Ax*dt;
    
    %Componente Y
    M1=Vy;
    M2=Vy+dt*Ay;
    Y=Y+ones(1,np)*dt*0.5*(M1+M2);
    Vy=Vy+Ay*dt;
    
    ordem_y=sort(Y);
    ymin=ordem_y(1);
    
    %Rotação
    %[X,Y]=rotacao(X,Y,Xc,Yc,I)

    %O objeto deve parar ao chegar em y=0 (chão)
    if ymin<0
        deltay=ymin;
        Y=Y+ones(1,np)*deltay;
        ymin=0;
    end
    
    % Grava o plot atual
    mov(i)=getframe(gcf);
end
