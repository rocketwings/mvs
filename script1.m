close all 
clear all

TOL = 1e-2;
%%
% to-do list
% 2 separable gaussians 
% 2 unseparable gaussians
% linear boundary but forced nonlinear (cubic)
% 1 gaussian in a ring centered at 0

%% generate for sep and unsep gaussians 

d = 2;
l = 1000;

mu1 = zeros(2,1);
mu1(1,1) = 3;
mu2 =zeros(2,1);
mu2(d,1) = 3;
cov1 = diag([3,1]);
cov2 = diag([1,3]);
[X,Y,X1,X2,Y1,Y2,Xs,Ys,X1s,X2s,Y1s,Y2s] = generate_points_2_gaussians(l,d,mu1,mu2,cov1,cov2); % s = separable

%% train and test 
r1 = separable_train(Xs,Ys);
Y_hat1 = mvs(Xs,r1.w,r1.b);
err_1 = sum(Y_hat1 ~= Ys);

r2 = non_separable_train(X,Y);
Y_hat2 = mvs(X,r2.w,r2.b);
err_2 = sum(Y_hat2 ~= Y);

%% plot
%points, ellipsoids, support vects,labels,decision boundary
[fig1] = visualize_results_gaussians(Xs,Ys,Y_hat1,r1,X1s,X2s,mu1,mu2,cov1,cov2,TOL);
[fig2] = visualize_results_gaussians(X,Y,Y_hat2,r2,X1,X2,mu1,mu2,cov1,cov2,TOL);


