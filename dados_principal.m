clear all; clc;
close all;
na=input('número de vértices:');         %número de arestas
[pt,x,y]=poligono(na);                   %pt matriz com as coordenadas
[XC,YC,I,m]=centromassa(pt,x,y);
dinamica(x,y,XC,YC,I,m);

