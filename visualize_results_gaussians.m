function [fig] = visualize_results_gaussians(X,Y,Y_hat,r,X1,X2,mu1,mu2,cov1,cov2,TOL)

figure
%points
plot(X1(1,:),X1(2,:),'ob');
hold on 
plot(X2(1,:),X2(2,:),'or');
xlabel('x1');
ylabel('x2');

%ellipsoids
fig = gcf;
min_x = fig.Children.XLim(1);max_x = fig.Children.XLim(end);
min_y = fig.Children.YLim(1);max_y = fig.Children.YLim(end);
dx1 = .1;dx2 = dx1;
range_x = min_x:dx1:max_x;range_y = min_y:dx2:max_y;
[x,y] = meshgrid(range_x,range_y);
x_vect = [reshape(x,1,numel(x));reshape(y,1,numel(y))];

mahal_1 = reshape(diag((x_vect-mu1)'*(cov1\(x_vect-mu1))),size(x,1),size(x,2));
mahal_2 = reshape(diag((x_vect-mu2)'*(cov2\(x_vect-mu2))),size(x,1),size(x,2));
contour(range_x,range_y,mahal_1,[1 1],'b');
contour(range_x,range_y,mahal_2,[1 1],'r');

%support vectors 
svs = r.dual > TOL;
plot(X(1,svs),X(2,svs),'sk','MarkerSize',12);

%labels
plot(X(1,Y_hat==1),X(2,Y_hat==1),'+b');
plot(X(1,Y_hat==-1),X(2,Y_hat==-1),'xr');

err = 0;
if sum(Y~=Y_hat)> 0
    err = 1;
    plot(X(1,Y~=Y_hat),X(2,Y~=Y_hat),'vg','MarkerSize',10);
end 

%decision boundary
if isnan(r.b)
    title('Infeasible');
    if err == 1
        legend('x1','x2','sd1','sd2','support vects','label x1','label x2','label error');
    else
        legend('x1','x2','sd1','sd2','support vects','label x1','label x2');
    end
else 
    f = reshape(r.w'*x_vect + r.b,size(x,1),size(x,2));
    contour(x,y,f,[0,0],'-k');
    if err == 1 
        legend('x1','x2','sd1','sd2','support vects','label x1','label x2','label error','decision boundary');
    else
        legend('x1','x2','sd1','sd2','support vects','label x1','label x2','decision boundary');
    end 
end
%margin
%to do maybe 

