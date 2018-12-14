%% BP�������Ԥ�⡪������ʶ��

%% �����������
clear all
clc

%% ��������������ȡ 
% ����
M = 10;
% �������������
N = 5; 
% ����������ȡ
pixel_value = feature_extraction(M,N);

%% ѵ����/���Լ�����
% ����ͼ����ŵ��������
rand_label = randperm(M*N);  
% ����������
direction_label = [1 0 0;1 1 0;0 1 0;0 1 1;0 0 1];
% ѵ����
train_label = rand_label(1:30);
P_train = pixel_value(train_label,:)';
dtrain_label = train_label - floor(train_label/N)*N;
dtrain_label(dtrain_label == 0) = N;
T_train = direction_label(dtrain_label,:)';
% ���Լ�
test_label = rand_label(31:end);
P_test = pixel_value(test_label,:)';
dtest_label = test_label - floor(test_label/N)*N;
dtest_label(dtest_label == 0) = N;
T_test = direction_label(dtest_label,:)';

%% ����BP����
net = newff(minmax(P_train),[10,3],{'tansig','purelin'},'trainlm');
% ����ѵ������
net.trainParam.epochs = 1000;
net.trainParam.show = 10;
net.trainParam.goal = 1e-3;
net.trainParam.lr = 0.1;

%% ����ѵ��
net = train(net,P_train,T_train);

%% �������
T_sim = sim(net,P_test);
for i = 1:3
    for j = 1:20
        if T_sim(i,j) < 0.5
            T_sim(i,j) = 0;
        else
            T_sim(i,j) = 1;
        end
    end
end
T_sim
T_test