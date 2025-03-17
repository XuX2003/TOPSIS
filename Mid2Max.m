function [posit_x] = Mid2Max(x, best)
% {xi}是一组中间型指标序列，且最佳数值为xbest，则公式为：
% M = max{|xi - xbest|}， xi_zxh = 1 - |xi - xbest| / M
    M = max(abs(x - best));
    % abs函数：用于计算数组的绝对值或复数的模
    posit_x = 1 - abs(x - best) / M;
    % 计算到best的距离
end