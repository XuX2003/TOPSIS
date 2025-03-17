function [posit_x] = Inter2Max(x ,a, b)
    r_x = size(x, 1);
    M = max([a - min(x), max(x) - b]);
    % ����ƫ�������������Զ����
    posit_x = zeros(r_x, 1);
    % ��ʼ��posit_x��Ŀ���ǽ�ʡ����ʱ��
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