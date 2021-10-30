clear all
clc
close all

N = 1000; % marimea vectorului de date experimentale
N1 = N; % marimea vectorului folosit pentru densitatea de probabilitate si functia de repartitie teoretice
%CAZ 1
a = 4
b = 6


%CAZ II
%a = -1; 
%b = 5; % a si b definesc transformarea liniara g(x)=a*x+b pornind de la legea de baza
C = 20; % numarul de clase ale histogramei

x = rand(1,N); % tipul de lege de probabilitate de studiat
x = (b-a)*x + a; % relatia folosita ca sa obtinem o distributie uniforma in [a,b] pornind de la o uniform in [0,1] - vezi explicatiile din Bibliografia cursului (Metropol/Paideia)
n = length(x); % va fi egal cu N

%Histograma nenormalizata cu C clase
figure
subplot(1,2,1), hist(x,C), title('Histograma nenormalizata'), xlabel('DATE EXPERIMENTALE'), ylabel('NUMAR APARITII')
[frecv,u] = hist(x,C); % returneaza frecventele nenormate si centrele claselor histogramei

%Histograma experimentala normalizata cu C clase
delta = u(2)-u(1); % gasim latimea unei clase din histograma
x1 = [u-0.5*delta, u(end)+0.5*delta]; % adaugam artificial un termen suportului histogramei normalizate ca sa inceapa fix din a si sa se termine in b 
frecv1 = [frecv./(n*delta), frecv(end)/(n*delta)]; %vectorul de frecvente normalizate *py*dy = px*dx
subplot(1,2,2), stairs(x1,frecv1), ylim([0 1.3]), xlabel('DATE EXPERIMENTALE'), ylabel('NUMAR APARITII (NORMATE)')
hold on

%Histograma normalizata teoretica
x2 = linspace(u(1)-0.5*delta,u(end)+0.5*delta,N1);
frecv2 = 1/(b-a)*ones(1,length(x2)); % distributia uniforma in [a,b]
plot(x2,frecv2),title('Histograma normalizata a datelor - densitatea de probabilitate - experimental')
legend('Histograma normalizata a datelor - experimental','Densitatea de probabilitate - teoretic','Location','SouthEast');
hold off

%Functia teoretica de repartitie
x4 = x2;
frecv4 = linspace(0,1,length(x4)); 
figure, plot(x4,frecv4,'+'), xlabel('VALORI EXPERIMENTALE'), ylabel('F_X(x)'), grid on
hold on

%Functia experimentala de repartitie in trepte
stairs([sort(x,'ascend')],[linspace(1/N,1,N)]), %added some additional padding terms at the ends of F(x)
legend('Functia de repartitie - teoretic','Functia de repartitie - experimental','Location','SouthEast');
hold off

%Media si Varianta teoretice si experimentale
medie_teoretica = (a+b)/2;
medie_experimentala = mean(x);
var_teoretica = (b-a)^2/12;
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