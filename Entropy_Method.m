function [W] = Entropy_Method(Z)
% 计算有n个样本，m个指标的样本所对应的的熵权
% 输入
% Z ： n*m的矩阵（要经过正向化和标准化处理，且元素中不存在负数）
% 输出
% W：熵权，1*m的行向量
    [n,m] = size(Z);
    D = zeros(1,m);  % 初始化保存信息效用值的行向量
    for i = 1:m
        x = Z(:,i);
        % 熵权法第二步：计算第j项指标下第i个样本所占的比重，并将其看作相对熵计算中用到的概率
        p = x / sum(x);
        % 注意，p有可能为0，此时计算ln(p)*p时，Matlab会返回NaN，所以这里我们自己定义一个函数
        % 熵权法第三步：计算每个指标的信息熵，并计算信息效用值，并归一化得到每个指标的熵权
        e = -sum(p .* mylog(p)) / log(n); % 计算信息熵
        D(i) = 1- e; % 计算信息效用值
    end
    W = D ./ sum(D);  % 将信息效用值归一化，得到权重    
end
