%% LVQ�������Ԥ�⡪������ʶ��

%% �����������
clear all
clc
warning off

%% ��������������ȡ 
% ����
M = 10;
% �������������
N = 5; 
% ����������ȡ
pixel_value = feature_extraction(M,N);
% ��һ��
pixel_value = premnmx(pixel_value);

%% ѵ����/���Լ�����
% ����ͼ����ŵ��������
rand_label = randperm(M*N);  
% ����������
direction_label = repmat(1:N,1,M);
% ѵ����
rand_train = rand_label(1:30);
Train = pixel_value(rand_train,:);
Train_label = direction_label(rand_train)';
% ���Լ�
rand_test = rand_label(31:end);
Test = pixel_value(rand_test,:);
Test_label = direction_label(rand_test)';
% SVMģ��
model = svmtrain(Train_label,Train,'-c 2 -g 0.05');
% �������
[predict_label,accuracy] = svmpredict(Test_label,Test,model);
result_svm = [Test_label';predict_label']
