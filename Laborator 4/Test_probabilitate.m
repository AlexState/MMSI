clear all
close all
clc

L = 1000; % nr de incercari = randuri din matricea cu date pe care facem probabilitatea
N = 2000; % marimea esantionului de date, volumul de date; cu cat e mai mare cu atat Beta scade

delta = 0.1; % delta este un procent relativ cu cat fata de probabilitatea reala e shiftata distributia
% in acest fel se va calcula o probabilitate experimentala cu o probabilitate p_tilda
% si se poate calcula eroare de tip 2, beta, sansa sa ne bucuram degeaba
nr_bins = 21; % nr bins for histogram
val_Q = 0.5; % vom crea evenimentul Q comparand mereu X (uniforma) cu val_Q

X = rand(L,N) + delta; % matricea de date uniforme shiftate la dreapta cu delta
probabilitatea_teoretica = 0.5; % aceasta e probabilitatea care mi s-a spus ca este reala
ss_teoretica = probabilitatea_teoretica*(1-probabilitatea_teoretica)/N;
probabilitatea_shiftata = probabilitatea_teoretica - delta; % probabilitatea ca X<0.5 pentru o uniforma in [delta,1+delta]
ss_shiftata = probabilitatea_shiftata*(1-probabilitatea_shiftata)/N;

X_mediu = X<val_Q; % vom obtine o matrice de 0 si 1 depinzand daca valorile sunt mai mici sau mai mari decat val_Q
probabilitatea_experimentala = sum(X_mediu,2)/N; % calculam probabilitatea pe coloane si vom obtine un vector coloana

Conditia_deMoivre_Laplace = sqrt(N.*probabilitatea_experimentala.*(1-probabilitatea_experimentala)); % sqrt(N*p*p_barat)>>1
['Conditia de Moivre Laplace este indeplinita in ', num2str(sum(Conditia_deMoivre_Laplace>3)),' cazuri din ', num2str(L)]

alpha_teoretic = 0.05; % nivelul de semnificatie statistica
cuantila_alpha_pe_2 = 1.96; % corespunde lui alpha = nivelul de semnificatie statistica = 0.05

delta_histograma = [max(probabilitatea_experimentala)-min(probabilitatea_experimentala)]/nr_bins; 
[frecv,u] = hist(probabilitatea_experimentala,nr_bins);
q = normpdf(linspace(probabilitatea_teoretica-3*sqrt(ss_teoretica),probabilitatea_teoretica+3*sqrt(ss_teoretica),nr_bins),probabilitatea_teoretica,sqrt(ss_teoretica)); % gaussiana rezultata prin probabilitaterea a N uniforme
figure,bar(u, frecv/L/delta_histograma), hold on, plot(linspace(probabilitatea_teoretica-3*sqrt(ss_teoretica),probabilitatea_teoretica+3*sqrt(ss_teoretica),nr_bins),q,'*-r') 
xlabel('x'), ylabel('Densitatea de probabilitate'),legend('Estimatiile probabilitatii','Gaussiana aproximand distributia probabilitatilor')

Z = (probabilitatea_experimentala-probabilitatea_teoretica)/(sqrt(ss_teoretica)); % calculam variabila de test (aducem gaussiana X_m intr-o gaussiana standard)

delta_histograma = [max(Z)-min(Z)]/nr_bins; 
[frecv,u] = hist(Z,nr_bins);
q = normpdf(linspace(-3,3,nr_bins),0,1); % Z va fi o gaussiana pentru delta = 0; cand shiftam uniforma nu mai obtinem Z 0, doar X_mediu e gaussiana
figure,bar(u, frecv/L/delta_histograma), hold on, plot(linspace(-3,3,nr_bins),q,'*-r') 
xlabel('z'), ylabel('Densitatea de probabilitate'),legend('Valorile de test Z','Gaussiana standard')

Zl = abs(Z)<=cuantila_alpha_pe_2; % facem testul propriu zis corespunzator unei valori alpha_teoretic = 0.05 

Beta_experimental = sum(Zl)/L % eroarea de gradul doi calculata experimental
eps = cuantila_alpha_pe_2*sqrt(ss_teoretica); 
Beta_teoretic = normcdf(probabilitatea_teoretica+eps,probabilitatea_shiftata,sqrt(ss_shiftata)) - normcdf(probabilitatea_teoretica-eps,probabilitatea_shiftata,sqrt(ss_shiftata))