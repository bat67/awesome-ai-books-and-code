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
T_train = ind2vec(Tc_train);
% ���Լ�
test_label = rand_label(31:end);
P_test = pixel_value(test_label,:)';
Tc_test = direction_label(test_label);

%% K-fold������֤ȷ�������Ԫ����
k_fold = 10;
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
        for j = 1:5
            rate{j} = length(find(Tc_train(:,train_set_index) == j))/length(find(train_set_index == 1));
        end
        net = newlvq(minmax(train_set_input),number,cell2mat(rate));
        % �����������
        net.trainParam.epochs = 100;
        net.trainParam.show = 10;
        net.trainParam.lr = 0.1;
        net.trainParam.goal = 0.001;
        % ѵ������
        net = train(net,train_set_input,train_set_output);
        waitbar(((i-1)*21 + number)/219,h);
        
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

%% ����LVQ����
for i = 1:5
    rate{i} = length(find(Tc_train(:,best_train_set_index) == i))/length(find(best_train_set_index == 1));
end
net = newlvq(minmax(best_input),best_number,cell2mat(rate),0.01);
% ����ѵ������
net.trainParam.epochs = 100;
net.trainParam.goal = 0.001;
net.trainParam.lr = 0.1;

%% ѵ������
net = train(net,best_input,best_output);

%% ����ʶ�����
T_sim = sim(net,P_test);
Tc_sim = vec2ind(T_sim);
result = [Tc_test;Tc_sim]

%% �����ʾ
% ѵ�����������
strain_label = sort(train_label(best_train_set_index));
htrain_label = ceil(strain_label/N);
% ѵ��������������
dtrain_label = strain_label - floor(strain_label/N)*N;
dtrain_label(dtrain_label == 0) = N;
% ��ʾѵ����ͼ�����
disp('ѵ����ͼ��Ϊ��' );
for i = 1:length(find(best_train_set_index == 1))
    str_train = [num2str(htrain_label(i)) '_'...
               num2str(dtrain_label(i)) '  '];
    fprintf('%s',str_train)
    if mod(i,5) == 0
        fprintf('\n');
    end
end
% ��֤���������
svalidation_label = sort(train_label(best_validation_set_index));
hvalidation_label = ceil(svalidation_label/N);
% ��֤������������
dvalidation_label = svalidation_label - floor(svalidation_label/N)*N;
dvalidation_label(dvalidation_label == 0) = N;
% ��ʾ��֤��ͼ�����
fprintf('\n');
disp('��֤��ͼ��Ϊ��' );
for i = 1:length(find(best_validation_set_index == 1)) 
    str_validation = [num2str(hvalidation_label(i)) '_'...
                    num2str(dvalidation_label(i)) '  '];
    fprintf('%s',str_validation)
    if mod(i,5) == 0
        fprintf('\n');
    end
end
% ���Լ��������
stest_label = sort(test_label);
htest_label = ceil(stest_label/N);
% ���Լ�����������
dtest_label = stest_label - floor(stest_label/N)*N;
dtest_label(dtest_label == 0) = N;
% ��ʾ���Լ�ͼ�����
fprintf('\n');
disp('���Լ�ͼ��Ϊ��');
for i = 1:20 
    str_test = [num2str(htest_label(i)) '_'...
              num2str(dtest_label(i)) '  '];
    fprintf('%s',str_test)
    if mod(i,5) == 0
        fprintf('\n');
    end
end
% ��ʾʶ�����ͼ��
error = Tc_sim - Tc_test;
location = {'��' '��ǰ��' 'ǰ��' '��ǰ��' '�ҷ�'};
for i = 1:length(error)
    if error(i) ~= 0
        % ʶ�����ͼ���������
        herror_label = ceil(test_label(i)/N);
        % ʶ�����ͼ������������
        derror_label = test_label(i) - floor(test_label(i)/N)*N;
        derror_label(derror_label == 0) = N;
        % ͼ��ԭʼ����
        standard = location{Tc_test(i)};
        % ͼ��ʶ��������
        identify = location{Tc_sim(i)};
        str_err = strcat(['ͼ��' num2str(herror_label) '_'...
                        num2str(derror_label) 'ʶ�����.']);
        disp([str_err '(��ȷ���������' standard...
                      '��ʶ����������' identify ')']);
    end
end
% ��ʾʶ����
disp(['ʶ����Ϊ��' num2str(length(find(error == 0))/20*100) '%']);