clear all
close all

d = 2;
l =1000;

mu1 = zeros(d,1);
mu1(1,1) = 1;
cov1 = diag([1,1]);
mu2 = zeros(d,1);
mu2(end,1) = 1;
cov2 = diag([1,1]);

Y1 = 1*ones(1,l/2);
Y2 = -1*ones(1,l/2);
X1 = repmat(mu1,1,l/2) + chol(cov1)*randn(d,l/2);
X2 = repmat(mu2,1,l/2) + chol(cov2)*randn(d,l/2);
X = [X1,X2];
Y = [Y1,Y2];

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

r1 = non_separable_train(X,Y);
err_xi = sum(r1.xi > 1);
Y_hat = 

%% create separable

d1_1 = diag((X1-mu1)'*(cov1\(X1-mu1))); %mahal from point of 1 to mu 1  
d1_2 = diag((X1-mu2)'*(cov2\(X1-mu2))); %mahal from point of 1 to mu 2 

d2_1 = diag((X2-mu1)'*(cov1\(X2-mu1))); %mahal from point of 1 to mu 1  
d2_2 = diag((X2-mu2)'*(cov2\(X2-mu2))); %mahal from point of 1 to mu 2 

d1 = ones(l/2,1);
d2 = ones(l/2,1);

d1(d1_1>d1_2) = 0;
d2(d2_2>d2_1) = 0;

X1_sep = X1(:,d1 == 1);
Y1_sep = 1*ones(1,size(X1_sep,2));
X2_sep = X2(:,d2 == 1);
Y2_sep = -1*ones(1,size(X2_sep,2));
X_sep = [X1_sep,X2_sep];
Y_sep = [Y1_sep,Y2_sep];

%% 
figure
subplot(2,1,1)
histogram(X1_sep(1,:))
title('X1 s');
subplot(2,1,2)
histogram(X1_sep(2,:))

figure
subplot(2,1,1)
histogram(X2_sep(1,:))
title('X2 s');
subplot(2,1,2)
histogram(X2_sep(2,:))

figure
subplot(2,1,1)
histogram(X_sep(1,:))
title('X s');
subplot(2,1,2)
histogram(X_sep(2,:))

r2 = separable_train(X_sep,Y_sep);
Y_sep_hat = separable_test(X_sep,r2.w,r2.b);
error_sep = sum(Y_sep - Y_sep_hat);

