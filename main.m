clear;clc
load X

%% 第一步：判断是否需要正向化（得分越高越好）
[n, m] = size(X);
disp(['共有', num2str(n), '个评价对象, ', num2str(m), '个评价指标']);
Judge = input(['这' num2str(m) '个指标是否需要经过正向化处理，需要输入1，不需要输入0：']);
if Judge == 1
    Position = input('需要正向化处理的指标所在的列，例如第2、3、6三列需要处理，则输入[2, 3, 6]：');
    disp('需要处理的这些列的指标类型（1：极小型，2：中间型，3：区间型）')
    Type = input('例如：第2列是极小型，第3列是区间型，第6列是中间型，就输入[1, 3, 2]：');
    for i = 1: size(Position, 2)
        X(:, Position(i)) = Positivization(X(:, Position(i)), Type(i), Position(i));
    end
    disp('正向化后的矩阵X =  ');
    disp(X);
end

%% 第二步：是否需要增加权重
disp("请输入是否需要增加权重向量，需要输入1，不需要输入0")
Judge = input('请输入是否需要增加权重：');
if Judge == 1
    Judge = input('使用熵权法确定权重请输入1，否则输入0：');
    if Judge == 1
        % 熵权法第一步：判断之前标准化后的Z矩阵中是否存在负数，如果有则重新对X进行标准化
        if sum(sum(Z < 0)) > 0
            disp('原来标准化得到的Z矩阵中存在负数，所以需要对X重新标准化')
            for i = 1: n
                for j = 1: m
                    Z(i, j) = [X(i, j) - min(X(:, j))] / [max(X(:, j)) - min(X(:, j))];
                end
            end
            disp('X重新进行标准化得到的标准化矩阵Z为: ');
            disp(Z)
        end
        % 熵权法第二步：见函数Entropy_Method
        weight = Entropy_Method(Z);
        disp('熵权法确定的权重为：')
        disp(weight)
    else
        disp(['如果你有3个指标，你就需要输入3个权重，例如它们分别为0.25,0.25,0.5, 则你需要输入[0.25,0.25,0.5]']);
        weight = input(['你需要输入' num2str(m) '个权数。' '请以行向量的形式输入这' num2str(m) '个权重: ']);
        OK = 0;  % 用来判断用户的输入格式是否正确
        while OK == 0 
            if abs(sum(weight) - 1)<0.000001 && size(weight, 1) == 1 && size(weight, 2) == m  % 注意，Matlab中浮点数的比较要小心
                OK = 1;
            else
                weight = input('你输入的有误，请重新输入权重行向量: ');
            end
        end
        % while循环判断输入的权重矩阵是否合理
    end
else
    weight = ones(1, m) ./ m ; %如果不需要加权重就默认权重都相同，即都为1/m
end

%% 第三步：对正向化后的矩阵进行标准化
% 目的：消除不同量纲的影响
% 方法：每一个元素/（其所在列的元素的平方和）^0.5
Z = X ./ repmat(sum(X .* X) .^ 0.5, n, 1); 
disp('标准化矩阵 Z = ');
disp(Z);

%% 第四步：对标准化后的矩阵计算得分并进行归一化
% 方法：z与最小值的距离 / （z与最大值的距离 + z与最小值的距离）
D_P = sum([(Z - repmat(max(Z), n, 1)) .^ 2 ] .* ...
    repmat(weigh, n, 1) ,2) .^ 0.5;   % D+ 与最大值的距离向量
D_N = sum([(Z - repmat(min(Z),n,1)) .^ 2 ] .* ...
    repmat(weigh,n,1) ,2) .^ 0.5;   % D- 与最小值的距离向量
S = D_N ./ (D_P + D_N);    % 未归一化的得分
stand_S = S / sum(S);
disp('最后的得分为：');
disp(stand_S);
[sorted_S, index] = sort(stand_S ,'descend')
