clear all
clc
close all

%TLC - prin convolutii intre PDF

delta = 0.01;
termeni_convolutie = 20; % cate v.a. se insumeaza (N)
%delta = input('delta =  ');
corectie = delta*1.5;
a = 0-corectie;
b = 1+corectie;
c = 0-corectie;
d = 1+corectie;

m = 1; %2*1/2
ss = sqrt(2/12); % media si sigma pentru gaussiana care aproximeaza suma a doua uniforme in [0,1]
ix1 = a:delta:b;
ix2 = c:delta:d; % suporturile celor doua distributii (PDF = probability density function)
f1 = uniform(ix1,0,1);
f2 = uniform(ix2,0,1); % call functia uniform care calculeaza px(x) in punctele de interes

k = 2;
e = a+c;
f = b+d;
ix3 = e:delta:f; % suportul noi distributii obtinute prin insumarea a doua uniforme
f3 = conv(f1,f2).*delta; % inmultim cu delta ca sa obtinem integrala din convolutia numerica
f4 = gaussian(ix3,m,ss); % gaussiana teoretica, cea cu care comparam suma celor doua uniforme
textul = strcat(sprintf('%d',k),' uniforme')
figure, hold on,plot(ix3,f3,'k',ix3,f4,'b--'),title(textul)
%pause(0.5)
%disp('Apasati o tasta'), pause;
epsilon(1) = max(abs(f3-f4)); % calculeaza devierea maxima intre convolutie si gaussiana de referinta

% trapz(f3)*delta;

for k = 3:termeni_convolutie
    m = k/2; % k* media unei uniforme in 1/2
    ss = sqrt(k/12); % 1/12 e abaterea medie a unei uniforme in [0,1]
    e = a+e;
    f = b+f; % calculam noile suporturi folosind suportul standard [a,b] si suportul anterior
    f2 = f3;
    ix3 = e:delta:f;
    f1 = uniform(ix1,0,1);
    f3 = conv(f1,f2).*delta; % noua convolutie de k uniforme
    f4 = gaussian(ix3,m,ss); % noua gaussiana cu care comparam
    plot(ix3,f3,ix3,f4,'--'),grid
    textul = strcat(sprintf('%d',k),' uniforme')
    title(textul);
    xlabel('x'), ylabel('px(x)')
    
%     trapz(f3)*delta
    epsilon(k-1) = max(abs(f3-f4)); % calculeaza devierea maxima intre convolutie si gaussiana de referinta
    pause(0.5)
    %disp('Apasati o tasta'),pause;
end

% rezultatul final = suma a k distributii uniforme
figure,  plot(ix3,f3,ix3,f4,'--'),grid
textul = strcat(sprintf('%d',k),' uniforme')
title(textul);
legend(['Convolutia a ', num2str(k), ' variabile uniforme'], 'Distributia Gaussiana de referinta');
xlabel('x'), ylabel('px(x)')

% this experiment is done in order to show what happens when you add a
% distribution of a different law than all the others
k = k+1;
p_i = -6;    % a = -5;
p_f = 7;
m = m+(p_i+p_f)*0.5;
ss = sqrt(ss^2+(p_f-p_i)^2/12);
a = p_i-corectie;
b = p_f+corectie;
ix1 = a:delta:b;
f1 = uniform(ix1,p_i,p_f);
e = a+e;
f = b+f;
f2 = f3;
ix3 = e:delta:f;
f3 = conv(f1,f2).*delta;
f4 = gaussian(ix3,m,ss);
figure,
plot(ix3,f3,ix3,f4,'--'), grid
textul = strcat(sprintf('%d',k),' uniforme - ultima avand dispersia mult diferita - uniforma in (-6,7)');
title(textul);
legend(['Convolutia a ', num2str(k), ' variabile uniforme'], 'Distributia Gaussiana de referinta');
xlabel('x'), ylabel('px(x)')
pause(0.5)
%trapz(f3)*delta;

figure, plot(epsilon,'*'), grid, xlabel('Nr de va insumate'), ylabel('Eroarea maxima fata de Gaussiana')
