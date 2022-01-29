clear all
clc
close all

% creare matrice de date LxN
L = 100; % volumul de date experimentale
% L = input('L =  ');
N = 1000;% nr de gaussiene insumate pentru a obtine Hi-patrat

mt = 0;
sigma = 1;

for k = 1:L
    X(k,:) = sigma*randn(1,N) + mt; %creare Gaussiana de media mt si varianta ss
end

z = sum(X.^2,2); %creare Hi-patrat

nr_bins = 50;
[h,u] = hist(z,nr_bins);

[frecv,u] = hist(z,nr_bins);

delta = u(2)-u(1);
frecv1 = frecv./(L*delta);
% figure,stairs(u-0.5*delta,frecv1)
figure(1),stairs(u-0.5*delta,frecv1)
title('Histograma normalizata a datelor')
hold on

u1 = linspace(u(1)-delta*0.5,u(nr_bins)+delta*0.5,200);
ct = 1/((2^(N/2))*gamma(N/2)*sigma^N);
u1 = (u1>0).*u1;
x1 = ct*(u1.^(N/2-1)).*exp(-u1/(2*sigma^2)); %densitate de probabilitate Hi_patrat
plot(u1,x1,'--r')
hold on

HIpdf = chi2pdf(u1,N);
plot(u1,HIpdf,'r');
% 
% plot(u,zeros(1,length(u)),'xr')
xlabel('x'), ylabel('Densitate de probabilitate'), grid on

hold off

