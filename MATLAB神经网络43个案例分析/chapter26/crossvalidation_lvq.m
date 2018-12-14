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

%% K-fold������֤ȷ�������Ԫ����
k_fold = 5;
Indices = crossvalind('Kfold',size(P_train,2),k_fold);
error_min = 10e10;
best_number = 1;
best_input = [];
best_output = [];
best_train_set_index = [];
best_validation_set_index = [];
h = waitbar(0,'����Ѱ�������Ԫ����.....');
for i = 1:k_fold
    % ��֤�����
    validation_set_index = (Indices == i);
    % ѵ�������
    train_set_index = ~validation_set_index;
    % ��֤��
    validation_set_input = P_train(:,validation_set_index);
    validation_set_output = T_train(:,validation_set_index);
    % ѵ����
    train_set_input = P_train(:,train_set_index);
    train_set_output = T_train(:,train_set_index);
    for number = 10:30
        count_B_train = length(find(Tc_train(:,train_set_index) == 1));
        count_M_train = length(find(Tc_train(:,train_set_index) == 2));
        rate_B = count_B_train/length(find(train_set_index == 1));
        rate_M = count_M_train/length(find(train_set_index == 1));
        net = newlvq(minmax(train_set_input),number,[rate_B rate_M]);
        % �����������
        net.trainParam.epochs = 1000;
        net.trainParam.show = 10;
        net.trainParam.lr = 0.1;
        net.trainParam.goal = 0.1;
        % ѵ������
        net = train(net,train_set_input,train_set_output);
        waitbar(((i-1)*21+number)/114,h);
        %% �������
        T_sim = sim(net,validation_set_input);
        Tc_sim = vec2ind(T_sim);
        error = length(find(Tc_sim ~= Tc_train(:,validation_set_index)));
        if error < error_min
            error_min = error;
            best_number = number;
            best_input = train_set_input;
            best_output = train_set_output;
            best_train_set_index = train_set_index;
            best_validation_set_index = validation_set_index;
        end
    end
end
disp(['����������֤���õ��������Ԫ����Ϊ��' num2str(best_number)]);
close(h);

%% ��������
count_B_train = length(find(Tc_train(:,best_train_set_index) == 1));
count_M_train = length(find(Tc_train(:,best_train_set_index) == 2));
rate_B = count_B_train/length(find(train_set_index == 1));
rate_M = count_M_train/length(find(train_set_index == 1));
net = newlvq(minmax(best_input),best_number,[rate_B rate_M]);
% �����������
net.trainParam.epochs = 1000;
net.trainParam.show = 10;
net.trainParam.lr = 0.1;
net.trainParam.goal = 0.1;

%% ѵ������
net = train(net,best_input,best_output);

%% �������
T_sim = sim(net,P_test);
Tc_sim = vec2ind(T_sim);
result = [Tc_sim;Tc_test]

%% �����ʾ
total_B = length(find(data(:,2) == 1));
total_M = length(find(data(:,2) == 2));
count_B_validation = length(find(Tc_train(:,best_validation_set_index) == 1));
count_M_validation = length(find(Tc_train(:,best_validation_set_index) == 2));
number_B = length(find(Tc_test == 1));
number_M = length(find(Tc_test == 2));
number_B_sim = length(find(Tc_sim == 1 & Tc_test == 1));
number_M_sim = length(find(Tc_sim == 2 &Tc_test == 2));
disp(['����������' num2str(569)...
      '  ���ԣ�' num2str(total_B)...
      '  ���ԣ�' num2str(total_M)]);
disp(['ѵ��������������' num2str(length(find(best_train_set_index == 1)))...
      '  ���ԣ�' num2str(count_B_train)...
      '  ���ԣ�' num2str(count_M_train)]);  
disp(['��֤������������' num2str(length(find(best_validation_set_index == 1)))...
      '  ���ԣ�' num2str(count_B_validation)...
      '  ���ԣ�' num2str(count_M_validation)]);  
disp(['���Լ�����������' num2str(69)...
      '  ���ԣ�' num2str(number_B)...
      '  ���ԣ�' num2str(number_M)]);
disp(['������������ȷ�' num2str(number_B_sim)...
      '  ���' num2str(number_B-number_B_sim)...
      '  ȷ����p1 = ' num2str(number_B_sim/number_B*100) '%']);
disp(['������������ȷ�' num2str(number_M_sim)...
      '  ���' num2str(number_M-number_M_sim)...
      '  ȷ����p2 = ' num2str(number_M_sim/number_M*100) '%']);
