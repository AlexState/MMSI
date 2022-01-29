clear all
clc
close all

mt = 3;
ss = 2; % ss = sigma
delta_mt = 0.0;

% N = input('N =  ');
N = 10000;
x = mt + delta_mt + ss*randn(1,N);

% m = input('nr clase =  ');
m = 7;

mi = min(x);
Ma = max(x);
% delta = (Ma-mi)/m;
% u = mi:delta:Ma;

mk = hist(x,m);
while min(mk)<5
    m = m-1;
    mk = hist(x,m);
end

delta = (Ma-mi)/m;
u = mi:delta:Ma;

q = length(u);
if q<5
  error('prea putine clase')
end

% ppV = [normcdf(u(2),mt,ss), normcdf(u(3),mt,ss)-normcdf(u(2),mt,ss),normcdf(u(4),mt,ss)-normcdf(u(3),mt,ss),normcdf(u(5),mt,ss)-normcdf(u(4),mt,ss),normcdf(u(6),mt,ss)-normcdf(u(5),mt,ss),normcdf(u(7),mt,ss)-normcdf(u(6),mt,ss),1-normcdf(u(7),mt,ss)];
% 
% pp = [normcdf(u(2),mt,ss),normcdf(u(3:q-1),mt,ss)-normcdf(u(2:q-2),mt,ss), 1-normcdf(u(q-1),mt,ss)];

pk = zeros(1,m);
pk(1) = normcdf(u(2),mt,ss);
for i = 2:m-1
    pk(i) = normcdf(u(i+1),mt,ss)-normcdf(u(i),mt,ss);
end
pk(m) = 1-normcdf(u(m),mt,ss);

z = sum(((mk-N*pk).^2)./(N*pk));

% alfa = 0.05
% y  =   z alfa cuantila pt Hi-patrat de (m-1)gr de lib si sigma = 1
% Hi-patrat aprox de o gaussiana de medie = (m-1) si var = 2*(m-1)


u1 = (m-1):0.01:5*sqrt(2*(m-1));
V = chi2cdf(u1,m-1);
alpha = 0.05;
index = find(V>=(1-alpha));
y = u1(index(1));     % y1   y  alfa-cuantila 
if z<=y
    Q = 1;%testul trecut
    display('Ipoteza H0 este acceptata') 
else
    Q = 0;
    display('Ipoteza H1 este acceptata = Ipoteza H0 este respinsa') 
end




