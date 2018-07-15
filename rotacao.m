function [X,Y]=rotacao(X,Y,Xc,Yc,I)


np=length(X);

%PVI
F=[3; 3];              %for�a aplicada
p=[X(2); Y(2)];        %ponto onde a for�a foi aplicada
tf=2;                  %tempo em que a for�a foi aplicada
W=0;                %velocidade angular rad/s

%An�lise da for�a
Raio=[p(1,1)-Xc; p(2,1)-Yc];          %vetor raio
f=sqrt(F(1,1)^2+ F(2,1)^2);           %m�dulo da for�a
r=sqrt(Raio(1,1)^2+ Raio(2,1)^2);     %m�dulo do vetor R
pe=Raio'*F;                           %produto interno entre F e R
ang=acos(pe/(f*r));                   %�ngulo entre F e R
torque=f*r*sin(ang);                  %Torque aplicado no ponto

%d=10;
%h=10;

%Impulso
if f>0
   alfa=torque/I;  %alfa=acelera��o angular
   W=W+alfa*tf; 
end

%Tempo de integra��o
t=5;                
dt = 0.01;             % Intervalo de tempo (s) 
times = 0 : dt : t;   

for j=1:1:np
    R(j)=sqrt(((X(j)-Xc)^2)+((Y(j)-Yc)^2));
    teta(j)=atan((Y(j)-Yc)/(X(j)-Xc));
   if X(j)<Xc & Y(j)>Yc         %segundo quadrante
       teta(j)=teta(j)+pi;
   elseif X(j)<Xc & Y(j)<Yc     %terceiro quadrante
       teta(j)=teta(j)-pi;
   end
end
tetai=teta;
figure
for i = 1:length(times)
    
    % Representa��o das part�culas e caixa 
    %plot(X,Y); fill(X,Y,'b'); hold on;
    %plot([0 d],[0 0],'k',[0 d],[h h],'w',[0 0],[0 h],'w',[d d],[0 h],'w','LineWidth',5); hold off;
    %axis([-0.1,d+0.1,-0.1,h+0.1]); 
    %xlabel('Coordenada x (m)');
    %ylabel('Coordenada y (m)');
     
    % Atualiza a posi��o do objeto 
    X=ones(1,np).*Xc+R.*cos(teta);
    Y=ones(1,np).*Yc+R.*sin(teta);
    teta=teta+W*dt;
   
    % Grava o plot atual
    mov(i)=getframe(gcf,[0 0 30 40]);
    end
  rev=(teta(1)-tetai(1))/(2*pi);   %n�mero de revolu��es
  revanalitico=(W*t)/(2*pi);       %N de rev analitico
  erropercentual=abs((rev-revanalitico)/revanalitico)*100;
  