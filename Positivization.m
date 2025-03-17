function [posit_x] = Positivization(x, type, i)
% 输入:
% x：需要正向化处理的指标对应的原始列向量
% type： 指标的类型（1：极小型， 2：中间型， 3：区间型）
% i: 正在处理的是原始矩阵中的哪一列
% 输出:
% posit_x：正向化后的列向量
    if type == 1  %极小型
        posit_x = Min2Max(x);
        disp('~~~~~~~~~~~~~~~~~~~~分界线~~~~~~~~~~~~~~~~~~~~');
    elseif type == 2  %中间型
        best = input('请输入最佳的那一个值： ');
        posit_x = Mid2Max(x, best);
        disp('~~~~~~~~~~~~~~~~~~~~分界线~~~~~~~~~~~~~~~~~~~~');
    elseif type == 3  %区间型
        a = input('请输入区间的下界： ');
        b = input('请输入区间的上界： '); 
        posit_x = Inter2Max(x,a,b);
        disp('~~~~~~~~~~~~~~~~~~~~分界线~~~~~~~~~~~~~~~~~~~~');
    else
        disp('没有这种类型的指标，请检查Type向量中是否有除了1、2、3之外的其他值');
    end
end
