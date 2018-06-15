function [fig,err] = visualize_training_linear(X,Y,Y_hat,r,X1,X2,TOL)

fig = figure;
%points
plot(X1(1,:),X1(2,:),'ob');%,'LineWidth',2);
hold on 
plot(X2(1,:),X2(2,:),'or');%,'LineWidth',2);
xlabel('x');
ylabel('y');


%labels
plot(X(1,Y_hat==1),X(2,Y_hat==1),'+b');
plot(X(1,Y_hat==-1),X(2,Y_hat==-1),'xr');

%support vectors 
svs = r.dual > TOL;
plot(X(1,svs),X(2,svs),'sk','MarkerSize',12);%,'LineWidth',2);

%errors
err = sum(Y~=Y_hat);
if err > 0
    plot(X(1,Y~=Y_hat),X(2,Y~=Y_hat),'vg','MarkerSize',12);%,'LineWidth',2);
end 

%decision boundary
if isnan(r.b)
    title('Infeasible');
    if err > 0
        legend('True 1','True 2','Labeled 1','Labeled 2','support vectors','label error');
    else
        legend('True 1','True 2','Labeled 1','Labeled 2','support vectors');
    end
else 
    
    min_x = fig.Children.XLim(1);max_x = fig.Children.XLim(end);
    min_y = fig.Children.YLim(1);max_y = fig.Children.YLim(end);
    dx1 = .1;dx2 = dx1;
    range_x = min_x:dx1:max_x;range_y = min_y:dx2:max_y;
    [x,y] = meshgrid(range_x,range_y);
    x_vect = [reshape(x,1,numel(x));reshape(y,1,numel(y))];
    
    f = reshape(r.w'*x_vect + r.b,size(x,1),size(x,2));
    contour(x,y,f,[0,0],'-k');
    if err > 0 
        legend('True 1','True 2','Labeled 1','Labeled 2','support vectors','label error','decision boundary');
    else
        legend('True 1','True 2','Labeled 1','Labeled 2','support vectors','decision boundary');
    end 
    title(['err= ' num2str(err) '/' num2str(size(X,2))]);
end
%margin
%to do maybe 

