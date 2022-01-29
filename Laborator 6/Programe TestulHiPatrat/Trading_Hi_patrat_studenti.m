clear all
clc
close all

% % % *********** Get DAILY stock data ****************
end_date = datetime('now','TimeZone','local','Format','ddMMyyyy');
end_date = end_date; %this line helps if want to look not at today but severeal days back

start_date = char(end_date-600);
end_date = char(end_date);
stock_name = 'TSLA'; %Ticker name = stock name
numefisier = strcat(stock_name,'_',end_date);

% Get data from Yahoo Finance
% stocks = hist_stock_data(start_date,end_date,stock_name); %last date = current date + 1 day
% save(numefisier)

load(numefisier)

Open = stocks.Open;
Lows = stocks.Low;
Highs = stocks.High;
Closings = stocks.Close;

figure, cndl(Highs,Lows,Open,Closings), grid on, 
xlabel('Day number'), ylabel ('Stock Price'),  xlabel('Days'), title('Prices') %candlestick chart

typical_price = (Closings+Highs+Lows)/3;
N = length(typical_price);

%Histograma nenormalizata cu C clase
C = 30;
figure, hist(typical_price,C), title('Histograma nenormalizata'), xlabel('DATE EXPERIMENTALE'), ylabel('NUMAR APARITII')
[frecv,u] = hist(typical_price,C); % returneaza frecventele nenormate si centrele claselor histogramei

%Histograma experimentala normalizata cu C clase
delta = u(2)-u(1); % gasim latimea unei clase din histograma
typical_price1 = [u-0.5*delta, u(end)+0.5*delta]; % adaugam artificial un termen suportului histogramei normalizate ca sa inceapa fitypical_price din a si sa se termine in b
frecv1 = [frecv./(N*delta), frecv(end)/(N*delta)]; %vectorul de frecvente normalizate *py*dy = ptypical_price*dtypical_price
figure, stairs(typical_price1,frecv1), title('Histograma normalizata'), xlabel('DATE EXPERIMENTALE'), ylabel('NUMAR APARITII (NORMATE)'), grid on

%Functia experimentala de repartitie in trepte
figure, stairs([typical_price(1)-10;sort(typical_price,'ascend');typical_price(end)+10],[0 linspace(1/N,1,N) 1]), %added some additional padding terms at the ends of F(typical_price)
xlabel('Price'), ylabel('Functia de repartitie'), grid on
title('Functia de repartitie experimentala')


%APLICATI TESTUL HI PATRAT PENTRU TYPICAL PRICE AL STOCULUI TESLA
% Ipoteza H0 este ca pretul provinde dintr-o distributie gaussiana si o
% varianta (sigma^2) calculate pe baza datelor experimentale ale stocului



