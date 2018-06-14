function [y] = separable_test(X,w,b)
y = -1*ones(1,size(X,2)); 
y(w'*X + b > 0) = 1;
end 