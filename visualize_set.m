function [fig] = visualize_set(X1,X2)

fig = figure;
%points
plot(X1(1,:),X1(2,:),'ob');%,'LineWidth',2);
hold on 
plot(X2(1,:),X2(2,:),'or');%,'LineWidth',2);
xlabel('x');
ylabel('y');
