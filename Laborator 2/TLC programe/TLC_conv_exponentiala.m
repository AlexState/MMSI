clear all
clc
close all
format long

%TLC - prin convolutii intre PDF

delta = 0.1; % step folosit pentru crearea PDF-urilor pentru convolutie
lambda = 1; % mean of the exponential and the main variable of the exp PDF
%delta = input('delta =  ');
termeni_convolutie = 20;

corectie = delta*1.5;
a = 0-corectie;
b = 9*lambda+corectie;
c = a;
d = b;

k = 2;
m = k*lambda;
ss = sqrt(k)*lambda; % media si sigma pt suma de doua exponentiale
ix1 = a:delta:b;
ix2 = c:delta:d;

f1 = functia_exponentiala(ix1,lambda);
f2 = functia_exponentiala(ix2,lambda);

e = a+c;
f = b+d;
ix3 = e:delta:f; % suportul noii distributii obtinute prin insumarea a doua exponentiale
f3 = conv(f1,f2).*delta; % inmultim cu delta ca sa obtinem integrala din convolutia numerica
f4 = gaussian(ix3,m,ss); % gaussiana teoretica, cea cu care comparam suma celor doua exponentiale
textul = strcat(sprintf('%d',k),' exponentiale')
if(length(ix3)==length(f3))
    figure,hold on,plot(ix3,f3,ix3,f4,'--'),title(textul)
else
    figure,hold on,plot([ix3, ix3(end)],f3,ix3,f4,'--'),title(textul)
end

pause(0.5)
%disp('Apasati o tasta'), pause;
epsilon(1) = max(abs(f3-f4)); % calculeaza devierea maxima intre convolutie si gaussiana de referinta

%trapz(f3)*delta;

for k = 3:termeni_convolutie
    m = k*lambda; % media unei sume de k exponentiale de parametru lambda
    ss = sqrt(k)*lambda;  % abaterea medie a unei sume de k exponentiale de parametru lambda
    
    e = a + e;
    f = b + f; % calculam noile suporturi folosind suportul standard [a,b] si suportul obtinut anterior din convolutie
    f2 = f3;
    ix3 = e:delta:f;
    f1 = functia_exponentiala(ix1,lambda);
    
    f3 = conv(f1,f2).*delta; % noua convolutie de k exponentiale
    f4 = gaussian(ix3,m,ss); % noua gaussiana cu care comparam
    if(length(ix3)==length(f3))
        plot(ix3,f3,ix3,f4,'--'),title(textul)
    else
        plot([ix3, ix3(end)],f3,ix3,f4,'--'),title(textul)
    end
    grid
    textul = strcat(sprintf('%d',k),' exponentiale')
    title(textul); xlabel('x'), ylabel('px(x)')
    %     trapz(f3)*delta;
    if(length(ix3)==length(f3))
        epsilon(k-1) = max(abs(f3-f4)); % calculeaza devierea maxima intre convolutie si gaussiana de referinta
    else
        epsilon(k-1) = max(abs(f3(1:end-1)-f4));
    end
    
    pause(0.5)
    %disp('Apasati o tasta'),pause;
end

% rezultatul final = suma a k distributii exponentiale
figure
if(length(ix3)==length(f3))
    plot(ix3,f3,ix3,f4,'--'),title(textul)
else
    plot([ix3, ix3(end)],f3,ix3,f4,'--'),title(textul)
end
grid
textul = strcat(sprintf('%d',k),' exponentiale')
title(textul);
legend(['Convolutia a ', num2str(k), ' variabile exponentiale'], 'Distributia Gaussiana de referinta');
xlabel('x'), ylabel('px(x)')

% k = k+1;
% p_i = -5;    % a = -5;
% p_f = 6;
% m = m+(p_i+p_f)*0.5;
% ss = sqrt(ss^2+(p_f-p_i)^2/12);
% a = p_i-corectie;
% b = p_f+corectie;
% ix1 = a:delta:b;
% f1 = functia_exponentiala(ix1,p_i,p_f);
% e = a+e;
% f = b+f;
% f2 = f3;
% ix3 = e:delta:f;
% f3 = conv(f1,f2).*delta;
% f4 = gaussian(ix3,m,ss);
% figure
% plot(ix3,f3,ix3,f4,'--'), grid
% textul = strcat(sprintf('%d',k),' exponentiale');
% title(textul);
% pause(0.5)
% %trapz(f3)*delta;
% %
figure,plot(epsilon,'*'), grid, xlabel('Nr de va insumate'), ylabel('Eroarea maxima fata de Gaussiana')
