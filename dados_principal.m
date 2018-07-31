clear all; clc;
close all;
%na=input('número de vértices:');         %número de arestas
pt=[25 25; 25 27;27 27; 27 25];
x=[25 25 27 27 ];
y=[25 27 27 25 ];
%[pt,x,y]=poligono(na);                   %pt matriz com as coordenadas
%[XC,YC,I,m]=centromassa(pt,x,y);
XC=26;
YC=26;
I= 13.50;
m=9;
dinamica(x,y,XC,YC,I,m);

