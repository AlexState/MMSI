function r = functia_exponentiala(x,lambda)
% CALCULEAZA valorile PDF pentru o lege exponentiala pentru valorile definite in X
grad = length(x);
ct = 1/lambda;
r = zeros(1,grad);

for i = 1:grad
    if x(i)<0
        r(i) = 0;
    else
        r(i) = ct*exp(-ct*x(i));
    end
end

        