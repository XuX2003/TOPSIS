function [posit_x] = Mid2Max(x, best)
% {xi}��һ���м���ָ�����У��������ֵΪxbest����ʽΪ��
% M = max{|xi - xbest|}�� xi_zxh = 1 - |xi - xbest| / M
    M = max(abs(x - best));
    % abs���������ڼ�������ľ���ֵ������ģ
    posit_x = 1 - abs(x - best) / M;
    % ���㵽best�ľ���
end