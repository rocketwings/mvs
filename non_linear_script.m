% clear all
% close all
% 
% 
% [X1_train,X2_train,Y1_train, Y2_train] = generate_points_2_gaussians(500,2,[1 0]',[0 1]', eye(2),eye(2));
% 
% plot(X1_train(1,:),X1_train(2,:),'+');
% hold on
% plot(X2_train(1,:),X2_train(2,:)','o');
% 
% X_train = [X1_train,X2_train];
% Y_train = [Y1_train,Y2_train];
% svm = non_linear_train(X_train,Y_train);
% 
% X_test = X_train;
% Y_test = Y_train;
% 
[a,b] = meshgrid([-1:0.1:2],[-1:0.1:2]);
X_test = [reshape(a,1,numel(a)); reshape(b,1,numel(b))];
test_labels = non_linear_test(svm.alpha,X_train,Y_train,X_test);

X1_test = X_test(:,test_labels>0);
X2_test = X_test(:,test_labels<0);

figure();
plot(X1_test(1,:),X1_test(2,:),'+');
hold on;
plot(X2_test(1,:),X2_test(2,:),'+');