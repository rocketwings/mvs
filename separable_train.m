function [ output_args ] = separable_train( data, labels )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    X = [[0 0]', [1 1]', [1 0]'];   %data
    Y = [-1 1 1]; %labels
else
    X = data;
    Y = labels;
end

num_data = size(X,2);   %l=num_data;
num_dim = size(X,1);    %d=num_dim;

cvx_begin

variable w(d);
variable b;
dual variable alpha;

minimize( norm(w) );

subject to
    alpha : ((Y' .* (X'*w + ones(num_data,1)*b)) - ones(num_data,1)) >= 0 ;
    
cvx_end

output_args = struct();
output_args.w = w;
output_args.b = b;
output_args.dual = alpha;

end
