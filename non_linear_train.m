function [ output_args ] = non_linear_train( data, labels, C)

if nargin < 2
    X = [[-1,-1]', [0 0]', [1 1]', [1 0]', [5,5]'];   %data
    Y = [-1 -1 1 1 1]; %labels
    C = 1;
elseif nargin < 3
    C = 1;
    X = data;
    Y = labels;
else
    X = data;
    Y = labels;
end

num_data = size(X,2);   %l=num_data;
num_dim = size(X,1);    %d=num_dim;

X_matrix = X' * X;
X_matrix = zeros(num_data);
for i = 1:num_data
    for j = 1:num_data
        X_matrix(i,j) = g_kernel(X(:,i),X(:,j));
    end
end
Y_matrix = Y' * Y;
XY_matrix = X_matrix .* Y_matrix;

cvx_begin

variable w(num_dim);
variable b;
variable xi(num_data);

variable alph(num_data);

% maximize( sum(alph) - (1/2) * quad_form(alph, XY_matrix));
maximize( sum(alph) - (1/2) * alph' *  XY_matrix * alph);

subject to
%     alph : ( (Y' .* (X'*w + ones(num_data,1)*b)) - ones(num_data,1) + xi ) >= 0 ;
    alph >= 0;
    alph <= C;
    alph' * Y' == 0;
    
cvx_end

output_args = struct();
output_args.alpha = alph;

end
