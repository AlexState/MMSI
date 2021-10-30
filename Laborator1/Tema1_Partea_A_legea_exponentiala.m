clear all
clc
close all

N = 100000; % marimea vectorului folosit pentru histograma
N1 = N; % marimea vectorului folosit pentru densitatea de probabilitate si functia de repartitie teoretice
lambda = 2;
sigma = 3; % lambda si sigma definesc transformarea liniara g(x)=a*x+b pornind de la legea normala standard
C = 50; % numarul de clase ale histogramei

x = exprnd(lambda,1, N); % tipul de lege de probabilitate de studiat
% x = sigma*x + lambda; 
% x = lambda + sigma.*sqrt(-2.*log(rand(1,N))).*cos(2*pi.*rand(1,N));
% % x = lambda + sigma.*sqrt(-2.*log(rand(1,N))).*sin(2*pi.*rand(1,N));
n = length(x); % va fi egal cu N

%Histograma nenormalizata cu C clase
figure
subplot(1,2,1), hist(x,C), title('Histograma nenormalizata'), xlabel('DATE EXPERIMENTALE'), ylabel('NUMAR APARITII')
[frecv,u] = hist(x,C); % returneaza frecventele nenormate si centrele claselor histogramei

%Histograma experimentala normalizata cu C clase
delta = u(2)-u(1); % gasim latimea unei clase din histograma
x1 = [u-0.5*delta, u(end)+0.5*delta]; % adaugam artificial un termen suportului histogramei normalizate ca sa inceapa fix din a si sa se termine in b 
frecv1 = [frecv./(n*delta), frecv(end)/(n*delta)]; %vectorul de frecvente normalizate *py*dy = px*dx
subplot(1,2,2), stairs(x1,frecv1), ylim([0 0.4]), xlabel('DATE EXPERIMENTALE'), ylabel('NUMAR APARITII (NORMATE)')
hold on

%Histograma normalizata teoretica
x2 = linspace(u(1)-0.5*delta,u(end)+0.5*delta,N1);
%frecv2 = 1/(sigma*sqrt(2*pi)).*exp(-(x2-lambda).^2/2/sigma^2); % am putea zice si normpdf(x2) / distributia normala de medie lambda si abatere standard sigma
frecv2 = exppdf(x2, lambda);
plot(x2,frecv2),title('Histograma normalizata a datelor - densitatea de probabilitate - experimental')
legend('Histograma normalizata a datelor - experimental','Densitatea de probabilitate - teoretic','Location','SouthEast');

hold on
x_arrow = [0.85 0.8]; %Aceste valori depind de distributia/legea folosita si au rol doar estetic/vizualizarea pe grafic a unor valori; trebuie avut grija cand modificati legea sa schimbati/adaptati si valorile
y_arrow = [0.9 0.9]; %Aceste valori depind de distributia/legea folosita si au rol doar estetic/vizualizarea pe grafic a unor valori; trebuie avut grija cand modificati legea sa schimbati/adaptati si valorile
annotation('textarrow',x_arrow,y_arrow,'String',['Max pdf in lambda = ',num2str(1/sigma/sqrt(2*pi))]) %aceasta valoare e valabila pentru gaussiana standard; pentru alte gaussiene poate fi omisa
hold off

%Functia teoretica de repartitie
x4 = x2;
frecv4 = expcdf(x4,lambda,sigma);
figure, plot(x4,frecv4,'+'), xlabel('VALORI EXPERIMENTALE'), ylabel('F_X(x)'), grid on
hold on

%Functia experimentala de repartitie in trepte
stairs([sort(x,'ascend')],[linspace(1/N,1,N)]), %added some additional padding terms at the ends of F(x)
legend('Functia de repartitie - teoretic','Functia de repartitie - experimental','Location','SouthEast');
hold off

%Media si Varianta teoretice si experimentale

medie_teoretica = lambda;
medie_experimentala = mean(x);
var_teoretica = sigma^2;
var_experimentala = var(x);
figure
dim1 = [0.2 0.5 0.3 0.4];
annotation('textbox',dim1,'String',['Media teoretica este ', num2str(medie_teoretica)],'FitBoxToText','on');
dim2 = [0.2 0.5 0.2 0.3];
annotation('textbox',dim2,'String',['Media experimentala este ', num2str(medie_experimentala)],'FitBoxToText','on');
dim3 = [0.2 0.5 0.1 0.2];
annotation('textbox',dim3,'String',['Varianta teoretica este ', num2str(var_teoretica)],'FitBoxToText','on');
dim4 = [0.2 0.5 0.0 0.1];
annotation('textbox',dim4,'String',['Varianta experimentala este ', num2str(var_experimentala)],'FitBoxToText','on');