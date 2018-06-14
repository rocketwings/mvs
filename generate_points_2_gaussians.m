function [X1,X2,Y1,Y2] = generate_points_2_gaussians(l,d,mu1,mu2,cov1,cov2)

if nargin < 3
    mu1 = zeros(d,1);
    mu1(1,1) = 2;
    cov1 = diag([1,1]);
    mu2 = zeros(d,1);
    mu2(end,1) = 2;
    cov2 = diag([1,1]);
end 

Y1 = 1*ones(1,l/2);
Y2 = -1*ones(1,l/2);
X1 = repmat(mu1,1,l/2) + chol(cov1)*randn(d,l/2);
X2 = repmat(mu2,1,l/2) + chol(cov2)*randn(d,l/2);
X = [X1,X2];
Y = [Y1,Y2];

%% separable
d1_1 = diag((X1-mu1)'*(cov1\(X1-mu1))); %mahal from point of 1 to mu 1  
d1_2 = diag((X1-mu2)'*(cov2\(X1-mu2))); %mahal from point of 1 to mu 2 
d2_1 = diag((X2-mu1)'*(cov1\(X2-mu1))); %mahal from point of 1 to mu 1  
d2_2 = diag((X2-mu2)'*(cov2\(X2-mu2))); %mahal from point of 1 to mu 2 

d1 = ones(l/2,1);
d2 = ones(l/2,1);
d1(d1_1>d1_2) = 0;
d2(d2_2>d2_1) = 0;

X1s = X1(:,d1 == 1);
Y1s = 1*ones(1,size(X1s,2));
X2s = X2(:,d2 == 1);
Y2s = -1*ones(1,size(X2s,2));
Xs = [X1s,X2s];
Ys = [Y1s,Y2s];


