clear all
clc
close all

%Observam ca daca L scade, alpha_experimental are de suferit (e ca si cum
% am face o estimare a altei medii cu L valori)
% Pentru L = 1000, alpha e mult mai bine aproximat, dar histograma si
% implicit epsilon cresc (gaussiana se largeste) ... tpot 95% sunt in I,
% dar I este larg

L = 1000; % nr de incercari = randuri din matricea cu date pe care facem media
N = 500; % marimea esantionului de date, volumul de date; cu cat e mai mare cu atat Beta scade
nr_bins = 21; % numarul de bar-uri pentru histograma experimentala a estimatiilor de medie

X = rand(L,N); % matricea de date uniforme
media_teoretica = 0.5; % media unei uniforme in [0,1]

m = sum(X,2)/N; % calculam media pe coloane si vom obtine un vector coloana

alpha_teoretic = 0.05 % nivelul de semnificatie statistica
cuantila_alpha_pe_2 = 1.96; % corespunde lui alpha = nivelul de semnificatie statistica = 0.05 - vezi tabelul A1.1 din Metropol pentru alte valori

eps = [cuantila_alpha_pe_2*sqrt(1/12)]/sqrt(N); % intervalul teoretic unde ar trebui sa se gaseasca media reala = 0.5 in jurul medie 
% practice calculata in experiment

I = [m-eps,m+eps]; % intervalele (L) de incredere unde vedem daca valoarea reala de 0.5 se gaseste sau nu in jurul medie experimentale cu o deviatie espilom
% I este intervalul de incredere statistica

succese = (I(:,1) < media_teoretica) & (I(:,2) > media_teoretica); % in cate cazuri medie teoretica se gaseste in +/- epsilon in jurul mediei teoretice = 0.5

alpha_experimental = 1 - sum(succese)/L % calculam numarul de cazuri in care media nu e in intervalul I = alpha_experimental

% plotam si mediile pentru a vedea ca obtinem o distributie normala in
% jurul mediei reale = 0.5 (uniforma [0,1])
delta_histograma = [max(m)-min(m)]/nr_bins; 
[frecv,u] = hist(m,nr_bins);
q = normpdf(u,media_teoretica,sqrt(1/(12*N))); % gaussiana rezultata prin medierea a N uniforme
figure,bar(u, frecv/L/delta_histograma), hold on, plot(u,q,'*-r') 
xlabel('x'), ylabel('Densitate de probabilitate'), legend('X_{mediu} experimental', 'Legea teoretica pentru estimatorul medie')


