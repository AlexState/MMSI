function r = gaussian(x,m,ss)
% CALCULEAZA valorile PDF pentru o lege gaussiana pentru valorile definite in X
ct = 1/(ss*sqrt(2*pi));
x = (x-m)/ss;
r = exp(-x.*x.*0.5).*ct;
