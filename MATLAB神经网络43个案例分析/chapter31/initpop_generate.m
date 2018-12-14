function initpop = initpop_generate(popsize,S1,S2,S3,P,T)

% ���볤�ȣ�Ȩֵ/��ֵ�ܸ�����
S = S1*S2 + S2*S3 + S2 + S3;

% Ԥ�����ʼ��Ⱥ����
initpop = zeros(popsize,S+1);

for i = 1:popsize
    % �������һ������[-1,1]
    x = rand(1,S)*2 - 1;
    
    % ǰS1*S2������ΪW1����������������Ȩֵ��
    temp = x(1:S1*S2);
    W1 = reshape(temp,S2,S1);
    
    % ���ŵ�S2*S3������ΪW2����������������Ȩֵ��
    temp = x(S1*S2+1:S1*S2+S2*S3);
    W2 = reshape(temp,S3,S2);

    % ���ŵ�S2������ΪB1����������Ԫ��ֵ��
    temp = x(S1*S2+S2*S3+1:S1*S2+S2*S3+S2);
    B1 = reshape(temp,S2,1);

    %���ŵ�S3������B2���������Ԫ��ֵ��
    temp = x(S1*S2+S2*S3+S2+1:end);
    B2 = reshape(temp,S3,1);
    
    % ������������Ԫ�����
    A1 = tansig(W1*P,B1);
    % �����������Ԫ�����
    A2 = purelin(W2*A1,B2);
    % ����������
    SE = mse(T-A2);
    % ˼ά�����㷨�ĵ÷�
    val = 1 / SE;
    % ������÷ֺϲ�
    initpop(i,:) = [x val];
end