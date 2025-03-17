function [posit_x] = Inter2Max(x ,a, b)
    r_x = size(x, 1);
    M = max([a - min(x), max(x) - b]);
    % 计算偏离最优区间的最远距离
    posit_x = zeros(r_x, 1);
    % 初始化posit_x，目的是节省处理时间
    for i = 1: r_x
        if x(i) < a
           posit_x(i) = 1 - (a - x(i)) / M;
        elseif x(i) > b
           posit_x(i) = 1 - (x(i) - b) / M;
        else
           posit_x(i) = 1;
        end
    end
end