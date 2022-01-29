clear all
clc
close all

L = 1000;
% L = input('L =  ');
N = 10000; 

mt = 0;
sigma = 1;

delta = 0.01; %deplasare sigma
X = mt+sigma*(1+delta)*randn(L,N);

Xm = sum(X,2)/N; % Calculul lui X_bar
for k = 1:L
    S_patrat(k,:) = X(k,:)-Xm(k); 
end

S_patrat = sum(S_patrat.^2,2)/(N-1); % Calculul lui S

% alfa = 0.05
% y1   y cuantila 1-alfa/2
% y2   y cuantila alfa/2

y = (N-1)*S_patrat/sigma^2;

% Calculez alfa/2 cuantilele necesare pentru testul de dispersie
u1 = 0:0.01:10*N;
V = chi2cdf(u1,N-1);
index = find(V>= 0.025);
y1 = u1(index(1));     % y1   y cuantila 1-alfa/2
index = find(V>= 0.975);
y2 = u1(index(1));     % y2   y cuantila alfa/2

% figure,plot(u1,chi2pdf(u1,N-1))
% for k = 1:L
%     I1(k,:) = [(N-1)*S(k)/y2 (N-1)*S(k)/y1]; 
% end

Interval_incredere_statistica_estimare_dispersie = (N-1)*[S_patrat/y2 S_patrat/y1];

v = ((sigma^2>Interval_incredere_statistica_estimare_dispersie(:,1))&(sigma^2<Interval_incredere_statistica_estimare_dispersie(:,2)));
Rata_succes_test = sum(v)/L

%reprezentare functie in scara pt 
%densitatea de probabilitate a estimatorului de dispersie
% C = nr de clase
z = y;
nr_bins = 50;
[frecv,u] = hist(z,nr_bins);
delta = u(2)-u(1);
frecv1 = frecv./(L*delta);

figure,stairs(u-0.5*delta,frecv1)
title('Histograma normalizata a datelor - reprezentare functie in trepte')
hold on
u2 = linspace(u(1)-delta*0.5,u(nr_bins)+delta*0.5,200);
HIpdf = chi2pdf(u2,N-1);
plot(u2,HIpdf,'--k')
plot(u,zeros(1,length(u)),'xr')
xlabel('x'), ylabel('Densitate de probabilitate'), grid on

% ct = 1/((2^((N-1)/2))*gamma((N-1)/2));
% u2 = (u2>0).*u2;
% HIpdf = ct*(u2.^((N-1)/2-1)).*exp(-u2/2);
% plot(u2,HIpdf,'--r')

hold off



% Calculez alfa cuantila superioare 
% alpha = 0.5 - > 1 - alpha = 0.95
u = 0:0.01:10*N;
V = chi2cdf(u1,N);
index = find(V>= 0.95);
y_cuantila = u(index(1));     % y1   y cuantila 1-alfa/2

