clear all; clc;
close all;
%na=input('número de vértices:');         %número de arestas
pt=[1 1; 1 2; 2 2; 2 1; 1.5 1.5];
x=[1 1 2 2 1.5];
y=[1 2 2 1 1.5];
%[pt,x,y]=poligono(na);                   %pt matriz com as coordenadas
[XC,YC,I,m]=centromassa(pt,x,y);
dinamica(x,y,XC,YC,I,m);

