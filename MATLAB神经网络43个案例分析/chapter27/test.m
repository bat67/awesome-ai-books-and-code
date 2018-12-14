%% LVQ�������Ԥ�⡪������ʶ��

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
direction_label = repmat(1:N,1,M);
% ѵ����
train_label = rand_label(1:30);
P_train = pixel_value(train_label,:)';
Tc_train = direction_label(train_label);
% ���Լ�
test_label = rand_label(31:end);
P_test = pixel_value(test_label,:)';
Tc_test = direction_label(test_label);

%% ����PC
for i = 1:5
    rate{i} = length(find(Tc_train == i))/30;
end

%% LVQ1�㷨
[w1,w2] = lvq1_train(P_train,Tc_train,20,cell2mat(rate),0.01,5);
result_1 = lvq_predict(P_test,Tc_test,20,w1,w2);

%% LVQ2�㷨
[w1,w2] = lvq2_train(P_train,Tc_train,20,0.01,5,w1,w2);
result_2 = lvq_predict(P_test,Tc_test,20,w1,w2);