clear all
clc
close all

L = 1000;
% L = input('L =  ');
N = input('N =  ');
disp('parametrul tip selecteaza tipul de gaussiana:');
disp('tip  = 0 pt gaussiana de medie = 0 si dispersie = 1')
disp('tip  = 1 pt gaussiana de medie = 1 si dispersie = 1')
tip = input('tip  =  ' );

disp('epsilon se da ca procent. exp: 0.5 ');
er = input('er =  ');


mu = tip;

% for k = 1:L
%     X(k,:) = m+randn(1,N);
% end

X = mu + randn(L,N);

m = X<0; % nr de succese P(X<0)
pe = sum(m,2)/N; % prob experim: nr succese/nr total

p = normcdf(0,mu,1); % valoare, medie, dispersie(sigma)

ep = er*p;% eroarea = errelativa*p

P_1  = (sum(abs(pe-p)<ep))/L

n1 = -ep*sqrt(N/(p*(1-p)));
n2 =  ep*sqrt(N/(p*(1-p)));
P_teoretic = normcdf(n2,0,1)-normcdf(n1,0,1)

