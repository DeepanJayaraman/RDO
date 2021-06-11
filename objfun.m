function [f]= objfun(x)
f = 2.*pi.*2.5.*x(:,1).*sqrt(750.^2+x(:,2).^2);
end