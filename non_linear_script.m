clear all
close all

d = 2;  l=200;
mu1 = [1, -1]';
cov1 = diag([1,1]);
mu2 = 2*[0, 0]';
cov2 = diag([1,1]);
mu3 = 2*[1, 1]';

Y1 = 1*ones(1,l/2);
Y2 = -1*ones(1,l/2);
Y3 = 1*ones(1,l/2);
X1 = repmat(mu1,1,l/2) + chol(cov1)*randn(d,l/2);
X2 = repmat(mu2,1,l/2) + chol(cov2)*randn(d,l/2);  
X3 = repmat(mu3,1,l/2) + chol(cov1)*randn(d,l/2);
X1 = [X1, X3];
Y1 = [Y1, Y3];
X = [X1,X2];
Y = [Y1,Y2];

figure();
plot(X1(1,:),X1(2,:),'+');
hold on
plot(X2(1,:),X2(2,:)','o');
title('training set');

svm = non_linear_train(X,Y);

test_labels = non_linear_test(svm.alpha,X,Y,X);
X1_test = X(:,test_labels>0);
X2_test = X(:,test_labels<0);


figure();
plot(X1_test(1,:),X1_test(2,:),'+');
hold on;
plot(X2_test(1,:),X2_test(2,:),'+');
title('test verify');

[a,b] = meshgrid([-1:0.1:2],[-1:0.1:2]);
X_map = [reshape(a,1,numel(a)); reshape(b,1,numel(b))];
map_labels = non_linear_test(svm.alpha,X,Y,X_map);

X1_map = X_map(:,map_labels>0);
X2_map = X_map(:,map_labels<0);

figure();
plot(X1_map(1,:),X1_map(2,:),'+');
hold on;
plot(X2_map(1,:),X2_map(2,:),'+');
title('test map');
