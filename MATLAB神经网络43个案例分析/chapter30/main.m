%% �������ɭ��˼�����Ϸ��������

%% ��ջ�������
clear all
clc
warning off

%% ��������
load data.mat
% �������ѵ����/���Լ�
a = randperm(569);
Train = data(a(1:500),:);
Test = data(a(501:end),:);
% ѵ������
P_train = Train(:,3:end);
T_train = Train(:,2);
% ��������
P_test = Test(:,3:end);
T_test = Test(:,2);

%% �������ɭ�ַ�����
model = classRF_train(P_train,T_train);

%% �������
[T_sim,votes] = classRF_predict(P_test,model);

%% �������
count_B = length(find(T_train == 1));
count_M = length(find(T_train == 2));
total_B = length(find(data(:,2) == 1));
total_M = length(find(data(:,2) == 2));
number_B = length(find(T_test == 1));
number_M = length(find(T_test == 2));
number_B_sim = length(find(T_sim == 1 & T_test == 1));
number_M_sim = length(find(T_sim == 2 & T_test == 2));
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
  
%% ��ͼ
figure

index = find(T_sim ~= T_test);
plot(votes(index,1),votes(index,2),'r*')
hold on

index = find(T_sim == T_test);
plot(votes(index,1),votes(index,2),'bo')
hold on

legend('�����������','��ȷ��������')

plot(0:500,500:-1:0,'r-.')
hold on

plot(0:500,0:500,'r-.')
hold on

line([100 400 400 100 100],[100 100 400 400 100])

xlabel('���Ϊ���1�ľ���������')
ylabel('���Ϊ���2�ľ���������')
title('���ɭ�ַ��������ܷ���')


%% ���ɭ���о��������������ܵ�Ӱ��
Accuracy = zeros(1,20);
for i = 50:50:1000
    i
    %ÿ�����������100�Σ�ȡƽ��ֵ
    accuracy = zeros(1,100);
    for k = 1:100
        % �������ɭ��
        model = classRF_train(P_train,T_train,i);
        % �������
        T_sim = classRF_predict(P_test,model);
        accuracy(k) = length(find(T_sim == T_test)) / length(T_test);
    end
     Accuracy(i/50) = mean(accuracy);
end
% ��ͼ
figure
plot(50:50:1000,Accuracy)
xlabel('���ɭ���о���������')
ylabel('������ȷ��')
title('���ɭ���о��������������ܵ�Ӱ��')