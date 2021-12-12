clear all
clc
close all

L = 1000; % nr de incercari = randuri din matricea cu date pe care facem estimarea de probabilitate
N = 1000; % marimea esantionului de date, volumul de date; cu cat e mai mare cu atat Beta scade
nr_bins = 21; % numarul de bar-uri pentru histograma experimentala a estimatiilor de probabilitate
val_Q = 0.5; % vom crea evenimentul Q comparand mereu X (uniforma) cu val_Q

X = rand(L,N); % matricea de date uniforme
probabilitatea_teoretica = 0.5; % probabilitatea ca X<0.5 pentru o uniforma in [0,1]

X_m = X<val_Q; % vom obtine o matrice de 0 si 1 depinzand daca valorile sunt mai mici sau mai mari decat val_Q
probabilitatea_experimentala = sum(X_m,2)/N; % calculam probabilitate pe coloane si vom obtine un vector coloana

Conditia_deMoivre_Laplace = sqrt(N.*probabilitatea_experimentala.*(1-probabilitatea_experimentala)); % sqrt(N*p*p_barat)>>1
['Conditia de Moivre Laplace este indeplinita in ', num2str(sum(Conditia_deMoivre_Laplace>10)),' cazuri din ', num2str(L)]

alpha_teoretic = 0.05 % nivelul de semnificatie statistica
cuantila_alpha_pe_2 = 1.96; % corespunde lui alpha = nivelul de semnificatie statistica = 0.05

eps = cuantila_alpha_pe_2.*sqrt(probabilitatea_experimentala.*(1-probabilitatea_experimentala)./N); % intervalul teoretic unde ar trebui sa se gaseasca probabilitate reala = 0.5 in jurul probabilitatii
% practice calculata in experiment; diferenta fata de inferenta probabilitatii este
% ca aici sigma e necunoscut si il estimam pe baza valorilor experimentale
% gasite din experiment

I = [probabilitatea_experimentala-eps,probabilitatea_experimentala+eps]; % intervalurile (L) unde vedem daca valoarea reala de 0.5 se gaseste sau nu in jurul probabilitate experimentale cu o deviatie espilom
% I este intervalul de incredere statistica

succese = (I(:,1) < probabilitatea_teoretica) & (I(:,2) > probabilitatea_teoretica); % in cate cazuri probabilitate teoretica se gaseste in +/- epsilon in jurul probabilitatei teoretice = 0.5

alpha_experimental = 1 - sum(succese)/L % calculam numarul de cazuri in care probabilitate nu e in intervalul I = alpha_experimental

% plotam si estimatiile de probabilitate pentru a vedea ca obtinem o distributie normala in
% jurul probabilitatii reale = 0.5 (uniforma [0,1])
delta = [max(probabilitatea_experimentala)-min(probabilitatea_experimentala)]/nr_bins;
[frecv,u] = hist(probabilitatea_experimentala,nr_bins);
q = normpdf(u,probabilitatea_teoretica,sqrt(probabilitatea_teoretica*(1-probabilitatea_teoretica)/N)); % gaussiana rezultata prin probabilitaterea a N uniforme
figure,bar(u, frecv/L/delta), hold on, plot(u,q,'*-r')
xlabel('x'), ylabel('Densitatea de probabilitate'), legend('X_{mediu} experimental', 'Gaussiana de referinta pentru probabilitate')
