clear all
close all

d = 2;
l = 1000;

mu1 = zeros(d,1);
mu1(1,1) = 2;
cov1 = diag([1,1]);
mu2 = zeros(d,1);
mu2(end,1) = 2;
cov2 = diag([1,1]);

Y1_non_sep = 1*ones(1,l/2);
Y2_non_sep = -1*ones(1,l/2);
X1_non_sep = repmat(mu1,1,l/2) + chol(cov1)*randn(d,l/2);
X2_non_sep = repmat(mu2,1,l/2) + chol(cov2)*randn(d,l/2);
X_non_sep = [X1_non_sep,X2_non_sep];
Y_non_sep = [Y1_non_sep,Y2_non_sep];


%% test 
r1 = non_separable_train(X_non_sep,Y_non_sep);
err_xi_non_sep = sum(r1.xi > 1);
Y_hat_non_sep = mvs(X_non_sep,r1.w,r1.b);
err_non_sep = sum(Y_hat_non_sep ~= Y_non_sep);

%% plots 

figure(1)
plot(X1_non_sep(1,:),X1_non_sep(2,:),'+');
hold on 
plot(X2_non_sep(1,:),X2_non_sep(2,:), 'o');
title(['non sep, error = ' num2str(err_non_sep) '/' num2str(l)]);


%% histograms
% figure
% subplot(2,1,1)
% histogram(X1_non_sep(1,:))
% title('X1_non_sep');
% subplot(2,1,2)
% histogram(X1_non_sep(2,:))
% 
% figure
% subplot(2,1,1)
% histogram(X2_non_sep(1,:))
% title('X2_non_sep');
% subplot(2,1,2)
% histogram(X2_non_sep(2,:))
% 
% figure
% subplot(2,1,1)
% histogram(X_non_sep(1,:))
% title('X_non_sep');
% subplot(2,1,2)
% histogram(X_non_sep(2,:))

%% create separable

d1_1 = diag((X1_non_sep-mu1)'*(cov1\(X1_non_sep-mu1))); %mahal from point of 1 to mu 1  
d1_2 = diag((X1_non_sep-mu2)'*(cov2\(X1_non_sep-mu2))); %mahal from point of 1 to mu 2 

d2_1 = diag((X2_non_sep-mu1)'*(cov1\(X2_non_sep-mu1))); %mahal from point of 1 to mu 1  
d2_2 = diag((X2_non_sep-mu2)'*(cov2\(X2_non_sep-mu2))); %mahal from point of 1 to mu 2 

d1 = ones(l/2,1);
d2 = ones(l/2,1);

d1(d1_1>d1_2) = 0;
d2(d2_2>d2_1) = 0;

X1_sep = X1_non_sep(:,d1 == 1);
Y1_sep = 1*ones(1,size(X1_sep,2));
X2_sep = X2_non_sep(:,d2 == 1);
Y2_sep = -1*ones(1,size(X2_sep,2));
X_sep = [X1_sep,X2_sep];
Y_sep = [Y1_sep,Y2_sep];
%% plot 
figure(2)
plot(X1_sep(1,:),X1_sep(2,:),'+');
hold on 
plot(X2_sep(1,:),X2_sep(2,:), 'o');
title(['sep, error = ' num2str(err_non_sep) '/' num2str(l)]);

%% histograms
% figure
% subplot(2,1,1)
% histogram(X1_sep(1,:))
% title('X1 s');
% subplot(2,1,2)
% histogram(X1_sep(2,:))
% 
% figure
% subplot(2,1,1)
% histogram(X2_sep(1,:))
% title('X2 s');
% subplot(2,1,2)
% histogram(X2_sep(2,:))
% 
% figure
% subplot(2,1,1)
% histogram(X_sep(1,:))
% title('X s');
% subplot(2,1,2)
% histogram(X_sep(2,:))

%% test 
r2 = separable_train(X_sep,Y_sep);
Y_sep_hat = mvs(X_sep,r2.w,r2.b);
error_sep = sum(Y_sep ~= Y_sep_hat);
