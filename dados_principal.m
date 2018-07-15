clear all; clc;
close all;
na=input('número de vértices:');               %nÃºmero de arestas
[pt,x,y]=poligono(na);      %pt matriz com as coordenadas
na=4;
[XC,YC,I,m]=centromassa(pt,x,y);
dinamica(x,y,XC,YC,m);
%rotacao(x,y,XC,YC,I);
