clear all
close all
clc

L = 1000; % nr de incercari = randuri din matricea cu date pe care facem probabilitatea
N = [500 1000 3000 5000]; % marimea esantionului de date, volumul de date; cu cat e mai mare cu atat Beta scade

delta = 0.05; %[0.01:0.01:0.1 0.15 0.2]; % delta este un procent relativ cu cat fata de probabilitatea reala e shiftata distributia
% in acest fel se va calcula o probabilitate experimentala cu o probabilitate p_tilda
% si se poate calcula eroare de tip 2, beta, sansa sa ne bucuram degeaba
nr_bins = 51; % nr bins for histogram
val_Q = 0.5; % vom crea evenimentul Q comparand mereu X (uniforma) cu val_Q

cuantila_alpha_pe_2 = 1.96; % corespunde lui alpha = nivelul de semnificatie statistica = 0.05

for i = 1:length(N)
    for j = 1:length(delta)
        [i,j]
        X = rand(L,N(i)) + delta(j); % probabilitatea_noua = probabilitatea_teoretica-delta(j)
        
        probabilitatea_teoretica = 0.5; % aceasta e probabilitatea care mi s-a spus ca este reala
        ss_teoretica = probabilitatea_teoretica*(1-probabilitatea_teoretica)/N(i);
        
        probabilitatea_shiftata = probabilitatea_teoretica - delta(j); % probabilitatea ca X<0.5 pentru o uniforma in [delta,1+delta]
        ss_shiftata = probabilitatea_shiftata*(1-probabilitatea_shiftata)/N(i);
        
        X_mediu = X<val_Q; % vom obtine o matrice de 0 si 1 depinzand daca valorile sunt mai mici sau mai mari decat val_Q
        probabilitatea_experimentala = sum(X_mediu,2)/N(i); % calculam probabilitatea pe coloane si vom obtine un vector coloana
        
        Conditia_deMoivre_Laplace = sqrt(N(i).*probabilitatea_experimentala.*(1-probabilitatea_experimentala)); % sqrt(N*p*p_barat)>>1
        ['Conditia de Moivre Laplace este indeplinita in ', num2str(sum(Conditia_deMoivre_Laplace>10)),' cazuri din ', num2str(L)]
        
        alpha_teoretic = 0.05; % nivelul de semnificatie statistica
        cuantila_alpha_pe_2 = 1.96; % corespunde lui alpha = nivelul de semnificatie statistica = 0.05
        
        Z = (probabilitatea_experimentala-probabilitatea_teoretica)/(sqrt(ss_teoretica)); % calculam variabila de test (aducem gaussiana X_m intr-o gaussiana standard)
        
        Zl = abs(Z)<cuantila_alpha_pe_2; % facem testul propriu zis corespunzator unei valori alpha_teoretic = 0.05
        
        Beta_experimental(i,j) = sum(Zl)/L; % eroarea de gradul doi calculata experimental
        eps = cuantila_alpha_pe_2*sqrt(ss_teoretica);
        Beta_teoretic(i,j) = normcdf(probabilitatea_teoretica+eps,probabilitatea_shiftata,sqrt(ss_shiftata)) - normcdf(probabilitatea_teoretica-eps,probabilitatea_shiftata,sqrt(ss_shiftata));
    end
end

% if(length(N)>1)
%     figure,
%     subplot(2,1,1), surf(N,delta,Beta_experimental), title('Beta experimental'), xlabel('N'), ylabel('delta'), zlabel('Beta'), colorbar
%     subplot(2,1,2), surf(N,delta,Beta_teoretic), title('Beta teoretic'), xlabel('N'), ylabel('delta'), zlabel('Beta'),colorbar
% else
%     figure,
%     plot(delta,Beta_experimental), xlabel('delta'), ylabel('Beta')
%     hold on
%     plot(delta,Beta_teoretic,'r'),
%     grid on, legend('Beta experimental','Beta teoretic')
% end

figure, plot(N,Beta_teoretic,'b'), grid on
hold on
plot(N, Beta_experimental,'r')
xlabel('N'), ylabel('Beta'), legend('Beta teoretic', 'Beta experimental')