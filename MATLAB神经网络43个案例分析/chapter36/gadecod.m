function[W1,B1,W2,B2,val] = gadecod(x)
global p t r s1 s2
W1 = zeros(s1,r);
W2 = zeros(s2,s1);
B1 = zeros(s1,1);
B2 = zeros(s2,1);
% ǰr*s1������ΪW1
for i = 1:s1
    for k = 1:r
        W1(i,k) = x(r*(i-1)+k);
    end
end
% ���ŵ�s1*s2������(����r*s1����ı���)ΪW2
for i = 1:s2
    for k = 1:s1
        W2(i,k) = x(s1*(i-1)+k+r*s1);
    end
end
% ���ŵ�s1������(����r*s1+s1*s2����ı���)ΪB1
for i = 1:s1
    B1(i,1) = x((r*s1+s1*s2)+i);
end
% ���ŵ�s2������(����r*s1+s1*s2+s1����ı���)ΪB2
for i = 1:s2
    B2(i,1) = x((r*s1+s1*s2+s1)+i);
end
% ����S1��S2������
A1 = tansig(W1*p,B1);
A2 = purelin(W2*A1,B2);
% �������ƽ����
SE = sumsqr(t - A2);
% �Ŵ��㷨����Ӧֵ
val = 1/SE;