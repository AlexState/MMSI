clear all
% close all
clc

L = 1000; % nr de incercari = randuri din matricea cu date pe care facem media
N =  1000; %[10:10:100 500 1000]; % marimea esantionului de date, volumul de date; cu cat e mai mare cu atat Beta scade

delta = [0.01:0.01:0.1 0.15 0.2]; % delta(j) este un procent relativ cu cat fata de media reala e shiftata distributia
% in acest fel se va calcula o medie experimentala cu o medie u_tilda
% si se poate calcula eroare de tip 2, beta, sansa sa ne bucuram degeaba
nr_bins = 21; % nr bins for histogram

media_teoretica = 0.5; % media unei uniforme in [0,1]
ss = 1/sqrt(12); % abaterea medie a unei uniforme in [0,1]

for i = 1:length(N)
    for j = 1:length(delta)
        [i,j]
        X = rand(L,N(i)) - media_teoretica*delta(j); % media_noua = media_teoretica* (1-delta(j))
        
        media_shiftata = media_teoretica*(1-delta(j));
        ss_shiftata = ss;
        cuantila_alpha_pe_2 = 1.96; % corespunde lui alpha = nivelul de semnificatie statistica = 0.05
        
        X_mediu = sum(X,2)/N(i); % calculam media variabile X pe coloane (X nu mai e uniforma in [0,1] , ci e shiftata la stanga cu delta(j) * media
        
        Z = (X_mediu-media_teoretica)/(ss/sqrt(N(i))); % calculam variabila de test (aducem gaussiana X_m intr-o gaussiana standard)
        
        Zl = abs(Z)<cuantila_alpha_pe_2; % facem testul propriu zis corespunzator unei valori alpha_teoretic = 0.05
        
        Beta_experimental(i,j) = sum(Zl)/L; % eroare de gradul doi calculata experimental
        eps = cuantila_alpha_pe_2*ss/sqrt(N(i));
        Beta_teoretic(i,j) = normcdf(media_teoretica+eps,media_shiftata,ss/sqrt(N(i))) - normcdf(media_teoretica-eps,media_shiftata,ss/sqrt(N(i)));
    end
end

if(length(N)>1)
    figure,
    subplot(2,1,1), surf(N,delta,Beta_experimental), title('Beta experimental'), xlabel('N'), ylabel('delta'), zlabel('Beta'), colorbar
    subplot(2,1,2), surf(N,delta,Beta_teoretic), title('Beta teoretic'), xlabel('N'), ylabel('delta'), zlabel('Beta'),colorbar
else
    figure,
    plot(delta,Beta_experimental), xlabel('delta'), ylabel('Beta')
    hold on
    plot(delta,Beta_teoretic,'r'), 
    grid on, legend('Beta experimental','Beta teoretic')
end
