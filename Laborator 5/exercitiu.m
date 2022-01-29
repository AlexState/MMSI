clear all
clc
close all

L = 1000;
N = 200; 


% Calculez alfa cuantila superioare 
% alpha = 0.5 - > 1 - alpha = 0.95
u = 0:0.01:10*N;
V = chi2cdf(u,N);
index = find(V>= 0.95);
y_cuantila = u(index(1));    