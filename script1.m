close all 
clear all

TOL = 1e-3;
%%
% to-do list
% 2 separable gaussians, linear
% 2 unseparable gaussians, linear 

% 2 unseparable gaussians test 

% 3 unseparable gaussians, linear
% 3 unseparable, nonlinear

% 4
% 4

% linear boundary but forced nonlinear (cubic)
% 1 gaussian in a ring centered at 0

%% generate for sep and unsep gaussians 

d = 2;
l = 1000;

mu1 = 3*[1,0]';
mu2 = 3*[0,1]';
cov1 = diag([1,1]);
cov2 = diag([1,1]);
[X_tr,Y_tr,X1_tr,X2_tr,~,~,Xs_tr,Ys_tr,X1s_tr,X2s_tr,~,~] = generate_points_2_gaussians(l,d,mu1,mu2,cov1,cov2); % s = separable

%% train and test 
rs = separable_train(Xs_tr,Ys_tr);
Ys_hat_tr = linear_test(Xs_tr,rs.w,rs.b);
err_s_tr = sum(Ys_hat_tr ~= Ys_tr);

r = non_separable_train(X_tr,Y_tr);
Y_hat_tr = linear_test(X_tr,r.w,r.b);
err_tr = sum(Y_hat_tr ~= Y_tr);

%% plot
%points, ellipsoids, support vects,labels,decision boundary
%[figs_tr] = visualize_training_gaussians(Xs_tr,Ys_tr,Ys_hat_tr,rs,X1s_tr,X2s_tr,mu1,mu2,cov1,cov2,TOL);
%[fig_tr] = visualize_training_gaussians(X_tr,Y_tr,Y_hat_tr,r,X1_tr,X2_tr,mu1,mu2,cov1,cov2,TOL);

%same, no ellipsoids
[figs_tr] = visualize_training_linear(Xs_tr,Ys_tr,Ys_hat_tr,rs,X1s_tr,X2s_tr,TOL);
[fig_tr] = visualize_training_linear(X_tr,Y_tr,Y_hat_tr,r,X1_tr,X2_tr,TOL);

%% testing on unseparable 
[X_te,Y_te,X1_te,X2_te] = generate_points_2_gaussians(l/2,d,mu1,mu2,cov1,cov2);

Y_hat_te = linear_test(X_te,r.w,r.b);
err_te = sum(Y_hat_te ~= Y_te);

[fig_te] = visualize_testing_linear(X_te,Y_te,Y_hat_te,r,X1_te,X2_te);

%% train linear on nonlinear: multiple gaussians 

mu1 = 3*[1,0]';
mu2 = 3*[0,1]';
mu3 = 3*[1,1]';
mu4 = 3*[-1,0]';
cov1 = diag([1,1]);
cov2 = diag([1,1]);
cov3 = diag([1,1]);
cov4 = diag([1,1]);
X1 = generate_points_gaussian(l,d,mu1,cov1);
X2 = generate_points_gaussian(l,d,mu2,cov2);
X3 = generate_points_gaussian(l,d,mu3,cov3);
X4 = generate_points_gaussian(l,d,mu3,cov3);
Y1 = 1*ones(1,size(X1,2));
Y2 = -1*ones(1,size(X2,2));
Y3 = 1*ones(1,size(X3,2));
Y4 = 1*ones(1,size(X4,2));

X1_3 = [X1,X2,X3];Y1_3 = [Y1,Y2,Y3];

r1_3 = non_linear_train(X1_3,Y1_3);
Y1_3_hat = non_linear_test(r1_3.alpha,X1_3,Y1_3,X1_3);
err_te = sum(Y_hat_te ~= Y_te);

fig = figure;
%points
plot(X1(1,:),X1(2,:),'ob');%,'LineWidth',2);
hold on 
plot(X2(1,:),X2(2,:),'or');%,'LineWidth',2);
plot(X3(1,:),X3(2,:),'or');%,'LineWidth',2);
xlabel('x1');
ylabel('x2');

