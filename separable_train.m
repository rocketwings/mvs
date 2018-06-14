function [ output_args ] = separable_train( data, labels )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


X = [[0 0]', [1 1]', [1 0]'];   %data
Y = [-1 1 1]; %labels

num_data = size(X,2);   l=num_data;
num_dim = size(X,1);    d=num_dim;

cvx_begin

variable w(d);
variable b;
dual variable alpha;

minimize( norm(w) );

subject to
    alpha : ((Y' .* (X'*w + ones(l,1)*b)) - ones(l,1)) >= 0 ;
    
cvx_end

end

