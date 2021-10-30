clear all
clc
close all

N = 10000;
R = 4; % logistic map parameter R*X((1-X)
N1 = N; % marimea vectorului folosit pentru densitatea de probabilitate si functia de repartitie teoretice
C = 50; % numarul de clase ale histogramei
iteratia = 5000;

logistic_map(:,1) = rand(1,N);
for i = 2:N
    logistic_map(:,i) = R.*logistic_map(:,i-1).*(1-logistic_map(:,i-1)); % create the different logistic map trajectories starting from the initial conditions (seeds)
end

figure, plot(logistic_map(:,iteratia),logistic_map(:,iteratia+1),'*'), xlabel('x(n)'), ylabel('x(n+1)'), title('Logistic map'), grid on

figure,
subplot(311), plot(logistic_map(1,1:100)), xlabel('n (discrete time)'), ylabel('Logistic map'), grid on, title('Trajectory 1')
subplot(312), plot(logistic_map(2,1:100)), xlabel('n (discrete time)'), ylabel('Logistic map'), grid on, title('Trajectory 2')
subplot(313), plot(logistic_map(3,1:100)), xlabel('n (discrete time)'), ylabel('Logistic map'), grid on, title('Trajectory 3')


%variabila analizata = bazata experimental pe datele de la o anumita iteratie
x = logistic_map(:,iteratia).';
n = length(x);

%Histograma nenormalizata cu C clase
figure
subplot(1,2,1), hist(x,C), title('Histograma nenormalizata'), xlabel('DATE EXPERIMENTALE'), ylabel('NUMAR APARITII'), grid on
[frecv,u] = hist(x,C); % returneaza frecventele nenormate si centrele claselor histogramei

%Histograma experimentala normalizata cu C clase
delta = u(2)-u(1); % gasim latimea unei clase din histograma
x1 = [u-0.5*delta, u(end)+0.5*delta]; % adaugam artificial un termen suportului histogramei normalizate ca sa inceapa fix din a si sa se termine in b 
frecv1 = [frecv./(n*delta), frecv(end)/(n*delta)]; %vectorul de frecvente normalizate *py*dy = px*dx
subplot(1,2,2), stairs(x1,frecv1), ylim([0 1.3]), xlabel('DATE EXPERIMENTALE'), ylabel('NUMAR APARITII (NORMATE)'), grid on
hold on

%Histograma normalizata teoretica
x2 = linspace(u(1)-(0.5-10^-15)*delta,u(end)+(0.5-10^-15)*delta,N1); % (0.5-10^-15) this is done to avoid division by 0
frecv2 = 1/pi./sqrt(x2.*(1-x2)); % distributia uniforma in [a,b]
plot(x2,frecv2),title('Histograma normalizata a datelor - densitatea de probabilitate - experimental')
legend('Histograma normalizata a datelor - experimental','Densitatea de probabilitate pentru logistic map','Location','SouthEast'), grid on
hold off

%Functia experimentala de repartitie in trepte
figure, stairs([x(1)-1 sort(x,'ascend') x(end)+1],[0 linspace(1/N,1,N) 1]), %added some additional padding terms at the ends of F(x)
xlabel('x'), ylabel('F_X(x)'), title('Functia de repartitie - experimental'), grid on, xlim([-0.5 1.5])
