function [test_labels,f_values] = non_linear_test_contour(alpha, train_x, train_y, test_x)

alpha_tol = 1e-6;   %value at which alpha is considered 0
idxs = find(alpha>alpha_tol);

b_sum = sum(1./train_y);
for i = idxs'
    for j = idxs'
        b_sum = b_sum - (alpha(j)*train_y(j)*g_kernel(train_x(:,i), train_x(:,j)));
    end
end
b_sum = b_sum/length(idxs);
b = b_sum;

num_test = size(test_x, 2);
test_labels = zeros(1, num_test);
f_values = zeros(1,num_test);
for test_idx = 1:num_test
    wx = b;
    for i = [idxs']
        wx = wx + alpha(i)*train_y(i)*g_kernel(train_x(:,i), test_x(:,test_idx));
    end
    test_labels(test_idx) = sign(wx);
    f_values(test_idx) = wx;
end
end

