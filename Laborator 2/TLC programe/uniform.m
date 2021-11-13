function r = uniform(x,a,b)
% CALCULEAZA valorile PDF pentru o lege uniforma pentru valorile definite in X
grad = length(x);
ct = 1/(b-a);
r = zeros(1,grad);
for i = 1:grad
    if x(i)<a
        r(i) = 0;
    elseif x(i)>b
        r(i) = 0;
    else
        r(i) = ct;
    end
end

        