clear all
clc
close all

%TLC - prin histograme pentru sume de v.a.

N1 = 1000; % input('nr de valori pt o v a  =  ');
m = 20 % input('nr de termeni in TLC  = ');% m = 5
C = 10; % input('nr de clase  =  ');

figure,hold on
y = rand(1,N1);

for k = 2:m
    x = rand(1,N1);
    y = y+x;
    [hx,cx] = hist(x,C);
    [hy,cy] = hist(y,C);
    
    % histograma normalizata = densitatea de probabilitate experimentala
    delta = cy(2)-cy(1);
    frecv1 = hy./(N1*delta);
    textul = strcat(int2str(k),' nr de termeni in TLC');
    %figure(2),bar(cy,hy/N1),title(textul),pause;
    %stairs([cy-0.5*delta,max(y)],[frecv1,max(frecv1)])
    x1 = [cy, cy(end)+0.5*delta]; % adaugam artificial un termen suportului histogramei normalizate ca sa inceapa fix din a si sa se termine in b
    frecv1 = [frecv1, frecv1(end)]; % vectorul de frecvente normalizate *py*dy = px*dx
    subplot(2,1,1), stairs(x1,frecv1), hold on
    text = ['PDF ',num2str(k), ' v.a. uniforme']; % densitatea de probabilitate experimentala finala
    title(text)% densitatea de probabilitate experimentala
    
    % densitatea de probabilitate teoretica
    media = k/2;
    ss = sqrt(k/12);
    ix = min(y):delta:max(y);
    gg = gaussian(ix,media,ss);
    plot(ix,gg,'--'), pause(0.5)  % densitatea de probabilitate teoretica
    xlabel('x'),ylabel('PDF')
    
    
    %Functia experimentala de repartitie in trepte
    x3 = cy;
    frecv3_1 = hy./N1;
    frecv3 = cumsum(frecv3_1);
    subplot(2,1,2),hold on
    stairs(x3,frecv3)
    text = ['CDF pentru ',num2str(k), ' v.a. uniforme']; % densitatea de probabilitate experimentala finala
    title(text)
    
    % Functia teoretica de repartitie
    x4 = ix; % plotam functia de repartitie in zona in care am obtinut valori din generatorul din Matlab
    frecv4 = normcdf(x4,media,sqrt(ss));
    plot(x4,frecv4,'+-')
    xlabel('x'),ylabel('CDF')
    legend('Diagrama frecventelor cumulate - experimental','Diagrama frecventelor cumulate - functia de repartitie - teoretic','Location','SouthEast');
end

figure,
subplot(2,1,1), hold on
stairs(x1,frecv1)
text = ['Histograma normalizata pentru ',num2str(k), ' v.a. uniforme']; % densitatea de probabilitate experimentala finala
title(text)
gg = gaussian(ix,media,ss);
plot(ix,gg,'--') % densitatea de probabilitate teoretica finala
xlabel('x'),ylabel('PDF')
legend('Histograma PDF - experimental','Histograma PDF - teoretic','Location','SouthEast');

subplot(2,1,2), hold on
text = ['CDF pentru ',num2str(k), ' v.a. uniforme']; % densitatea de probabilitate experimentala finala
title(text)
stairs(x3,frecv3)
plot(x4,frecv4,'+-')
xlabel('x'),ylabel('CDF')
legend('Diagrama frecventelor cumulate - experimental','Diagrama frecventelor cumulate - functia de repartitie - teoretic','Location','SouthEast');

