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

%% training
rs = separable_train(Xs_tr,Ys_tr);
Ys_hat_tr = linear_test(Xs_tr,rs.w,rs.b);
err_s_tr = sum(Ys_hat_tr ~= Ys_tr);

r = non_separable_train(X_tr,Y_tr);
Y_hat_tr = linear_test(X_tr,r.w,r.b);
err_tr = sum(Y_hat_tr ~= Y_tr);

%% plot

[figs_tr,err] = visualize_training_linear(Xs_tr,Ys_tr,Ys_hat_tr,rs,X1s_tr,X2s_tr,TOL);
title(['Separable Linear Training, err= ' num2str(err) '/' num2str(size(Xs_tr,2))]);
saveas(gcf,'1_sep_lin.png')
[fig_tr,err] = visualize_training_linear(X_tr,Y_tr,Y_hat_tr,r,X1_tr,X2_tr,TOL);
title(['Non-separable Linear Training, err= ' num2str(err) '/' num2str(size(X_tr,2))]);
saveas(gcf,'2_non_sep_lin.png')
%% testing on unseparable 
[X_te,Y_te,X1_te,X2_te] = generate_points_2_gaussians(l/2,d,mu1,mu2,cov1,cov2);

Y_hat_te = linear_test(X_te,r.w,r.b);
err_te = sum(Y_hat_te ~= Y_te);

[fig_te,err] = visualize_testing_linear(X_te,Y_te,Y_hat_te,r,X1_te,X2_te);
title(['Non-Separable Linear Testing, err= ' num2str(err) '/' num2str(size(X_te,2))]);
saveas(gcf,'3_non_sep_lin_test.png')
%% train on more difficult set
d = 2;
l = 100;

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
X4 = generate_points_gaussian(l,d,mu4,cov4);
Y1 = 1*ones(1,size(X1,2));
Y2 = -1*ones(1,size(X2,2));
Y3 = 1*ones(1,size(X3,2));
Y4 = 1*ones(1,size(X4,2));

X1_3 = [X1,X2,X3];Y1_3 = [Y1,Y2,Y3];
visualize_set([X1 X3],X2);
title('Set 1 ')
saveas(gcf,'set_1.png')

%linear first
r = non_separable_train(X1_3,Y1_3);
Y1_3_hat = linear_test(X1_3,r.w,r.b);
[fig_linear,err] = visualize_training_linear(X1_3,Y1_3,Y1_3_hat,r,[X1,X3],X2,TOL);
title(['Linear Training, err= ' num2str(err) '/' num2str(size(X1_3,2))]);
saveas(gcf,'5_lin_1.png')
%nonlinear
r1_3 = non_linear_train(X1_3,Y1_3);
Y1_3_hat = non_linear_test(r1_3.alpha,X1_3,Y1_3,X1_3);
[fig_non_linear,err] = visualize_testing_non_linear(X1_3,Y1_3,Y1_3_hat,r1_3,[X1 X3],X2,TOL);
title(['NonLinear Training, err= ' num2str(err) '/' num2str(size(X1_3,2))]);
saveas(gcf,'6_nonlin_1.png')
%% set 2 

X1_4 = [X1,X2,X2,X3,X4];Y1_4 = [Y1,Y2,Y2,Y3,Y4];
visualize_set([X1 X3 X4],X2);
title('Set 2')
saveas(gcf,'7_Set_2.png')
%linear first
r = non_separable_train(X1_4,Y1_4);
Y1_4_hat = linear_test(X1_4,r.w,r.b);
[fig_linear,err] = visualize_training_linear(X1_4,Y1_4,Y1_4_hat,r,[X1,X3,X4],X2,TOL);
title(['Linear Training, err= ' num2str(err) '/' num2str(size(X1_4,2))]);
saveas(gcf,'8_lin_2.png')
%nonlinear
r1_4 = non_linear_train(X1_4,Y1_4);
Y1_4_hat = non_linear_test(r1_4.alpha,X1_4,Y1_4,X1_4);
[fig_non_linear,err] = visualize_testing_non_linear(X1_4,Y1_4,Y1_4_hat,r1_4,[X1 X3 X4],X2,TOL);
title(['NonLinear Training, err= ' num2str(err) '/' num2str(size(X1_4,2))]);
saveas(gcf,'9_nonlin_2.png')


