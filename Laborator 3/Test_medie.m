clear all
close all
clc

L = 1000; %s nr de incercari = randuri din matricea cu date pe care facem media
N = 100; % marimea esantionului de date, volumul de date; cu cat e mai mare cu atat Beta scade

delta = 0.2; % delta este un procent relativ cu cat fata de media reala e shiftata distributia
% in acest fel se va calcula o medie experimentala cu o medie u_tilda
% si se poate calcula eroare de tip 2, beta, sansa sa ne bucuram degeaba
nr_bins = 21; % nr bins for histogram

media_teoretica = 0.5; % media unei uniforme in [0,1]
ss = 1/sqrt(12); % abaterea medie a unei uniforme in [0,1]

X = rand(L,N) - media_teoretica*delta; % media_noua = media_teoretica* (1-delta) - cazul 2 din Tema Lab 3

media_shiftata = media_teoretica*(1-delta);
ss_shiftata = ss;
cuantila_alpha_pe_2 = 1.96; % corespunde lui alpha = nivelul de semnificatie statistica = 0.05

X_mediu = sum(X,2)/N; % calculam media variabile X pe coloane (X nu mai e uniforma in [0,1] , ci e shiftata la stanga cu delta * media

delta_histograma = [max(X_mediu)-min(X_mediu)]/nr_bins; 
[frecv,u] = hist(X_mediu,nr_bins);
q = normpdf(linspace(media_teoretica-3*sqrt(1/(12*N)),media_teoretica+3*sqrt(1/(12*N)),nr_bins),media_teoretica,sqrt(1/(12*N))); % gaussiana rezultata prin medierea a N uniforme
figure,bar(u, frecv/L/delta_histograma), hold on, plot(linspace(media_teoretica-3*sqrt(1/(12*N)),media_teoretica+3*sqrt(1/(12*N)),nr_bins),q,'*-r') 
xlabel('x'), ylabel('Densitate de probabilitate'),legend('Estimatiile mediei','Legea teoretica pentru estimatorul medie')

Z = (X_mediu-media_teoretica)/(ss/sqrt(N)); % calculam variabila de test (aducem gaussiana X_m intr-o gaussiana standard)

delta_histograma = [max(Z)-min(Z)]/nr_bins; 
[frecv,u] = hist(Z,nr_bins);
q = normpdf(linspace(-3,3,nr_bins),0,1); % gaussiana rezultata prin medierea a N uniforme
figure,bar(u, frecv/L/delta_histograma), hold on, plot(linspace(-3,3,nr_bins),q,'*-r') 
xlabel('x'), ylabel('Densitate de probabilitate'),legend('Valorile de test Z','Gaussiana standard')

Zl = abs(Z)<=cuantila_alpha_pe_2; % facem testul propriu zis corespunzator unei valori alpha_teoretic = 0.05 

Beta_experimental = sum(Zl)/L % eroarea de gradul doi calculata experimental
eps = cuantila_alpha_pe_2*ss/sqrt(N); 
Beta_teoretic = normcdf(media_teoretica+eps,media_shiftata,ss/sqrt(N)) - normcdf(media_teoretica-eps,media_shiftata,ss/sqrt(N))