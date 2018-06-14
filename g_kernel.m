function [ y ] = g_kernel( x1, x2, sigma )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
if nargin < 3
    sigma = 1;
end

y = exp(-norm(x1-x2)^2/(2*sigma^2));

end

