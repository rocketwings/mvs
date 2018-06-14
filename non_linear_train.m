% function [ output_args ] = non_linear_train( data, labels, C)

% if nargin < 2
    X = [[0 0]', [1 1]', [1 0]'];   %data
    Y = [-1 1 1]; %labels
    C = 1;
% elseif nargin < 3
%     C = 1;
% else
%     X = data;
%     Y = labels;
% end

num_data = size(X,2);   %l=num_data;
num_dim = size(X,1);    %d=num_dim;

X_matrix = X' * X;
Y_matrix = Y' * Y;
XY_matrix = X_matrix .* Y_matrix;

cvx_begin

variable w(num_dim);
variable b;
variable xi(num_data);

variable alph(num_data);

maximize( sum(alph) - (1/2) * quad_form(alph, XY_matrix));

subject to
%     alph : ( (Y' .* (X'*w + ones(num_data,1)*b)) - ones(num_data,1) + xi ) >= 0 ;
    alph >= 0;
    alph <= C;
    sum( alph' * Y' ) == 0;
    
cvx_end
% 
% output_args = struct();
% output_args.w = w;
% output_args.b = b;
% output_args.xi = xi;
% output_args.dual = alph;

% end
