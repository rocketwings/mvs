clear all
close all

d = 2;
l =1000;

mu1 = zeros(d,1);
mu1(1,1) = 2;
cov1 = diag([1,1]);
mu2 = zeros(d,1);
mu2(end,1) = 2;
cov2 = diag([1,1]);

y = [-1*ones(1,l/2),1*ones(1,l/2)];
X1 = repmat(mu1,1,l/2) + chol(cov1)*randn(d,l/2);
X2 = repmat(mu2,1,l/2) + chol(cov2)*randn(d,l/2);
X = [X1,X2];

%% 
figure
subplot(2,1,1)
histogram(X1(1,:))
title('X1');
subplot(2,1,2)
histogram(X1(2,:))

figure
subplot(2,1,1)
histogram(X2(1,:))
title('X2');
subplot(2,1,2)
histogram(X2(2,:))

figure
subplot(2,1,1)
histogram(X(1,:))
title('X');
subplot(2,1,2)
histogram(X(2,:))

non_separable_train(X,y)

%% create separable

% d = zeros(l,1);
% 
% d1 = diag((X1-mu1)'cov1\(X1-mu1))