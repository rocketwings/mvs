function [X] = generate_points_gaussian(l,d,mu,cov)

X = repmat(mu,1,l/2) + chol(cov)*randn(d,l/2);
end 