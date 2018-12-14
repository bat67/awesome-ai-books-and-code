%% LVQ������ķ��ࡪ�������������

%% ��ջ�������
clear all
clc
warning off

%% ��������
load data.mat
a = randperm(569);
Train = data(a(1:500),:);
Test = data(a(501:end),:);
% ѵ������
P_train = Train(:,3:end)';
Tc_train = Train(:,2)';
T_train = ind2vec(Tc_train);
% ��������
P_test = Test(:,3:end)';
Tc_test = Test(:,2)';

%% ��������
count_B = length(find(Tc_train == 1));
count_M = length(find(Tc_train == 2));
rate_B = count_B/500;
rate_M = count_M/500;
net = newlvq(minmax(P_train),20,[rate_B rate_M],0.01,'learnlv1');
% �����������
net.trainParam.epochs = 1000;
net.trainParam.show = 10;
net.trainParam.lr = 0.1;
net.trainParam.goal = 0.1;

%% ѵ������
net = train(net,P_train,T_train);

%% �������
T_sim = sim(net,P_test);
Tc_sim = vec2ind(T_sim);
result = [Tc_sim;Tc_test]
%% �����ʾ
total_B = length(find(data(:,2) == 1));
total_M = length(find(data(:,2) == 2));
number_B = length(find(Tc_test == 1));
number_M = length(find(Tc_test == 2));
number_B_sim = length(find(Tc_sim == 1 & Tc_test == 1));
number_M_sim = length(find(Tc_sim == 2 &Tc_test == 2));
disp(['����������' num2str(569)...
      '  ���ԣ�' num2str(total_B)...
      '  ���ԣ�' num2str(total_M)]);
disp(['ѵ��������������' num2str(500)...
      '  ���ԣ�' num2str(count_B)...
      '  ���ԣ�' num2str(count_M)]);
disp(['���Լ�����������' num2str(69)...
      '  ���ԣ�' num2str(number_B)...
      '  ���ԣ�' num2str(number_M)]);
disp(['������������ȷ�' num2str(number_B_sim)...
      '  ���' num2str(number_B - number_B_sim)...
      '  ȷ����p1=' num2str(number_B_sim/number_B*100) '%']);
disp(['������������ȷ�' num2str(number_M_sim)...
      '  ���' num2str(number_M - number_M_sim)...
      '  ȷ����p2=' num2str(number_M_sim/number_M*100) '%']);