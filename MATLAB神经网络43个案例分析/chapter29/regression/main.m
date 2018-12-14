%% ����ѧϰ���ڻع���������е�Ӧ���о�

%% ��ջ�������
clear all
clc

%% ��������
load data
% �������ѵ���������Լ�
k = randperm(size(input,1));
% ѵ��������1900������
P_train=input(k(1:1900),:)';
T_train=output(k(1:1900));
% ���Լ�����100������
P_test=input(k(1901:2000),:)';
T_test=output(k(1901:2000));

%% ��һ��
% ѵ����
[Pn_train,inputps] = mapminmax(P_train,-1,1);
Pn_test = mapminmax('apply',P_test,inputps);
% ���Լ�
[Tn_train,outputps] = mapminmax(T_train,-1,1);
Tn_test = mapminmax('apply',T_test,outputps);

tic
%% ELM����/ѵ��
[IW,B,LW,TF,TYPE] = elmtrain(Pn_train,Tn_train,20,'sig',0);

%% ELM�������
Tn_sim = elmpredict(Pn_test,IW,B,LW,TF,TYPE);
% ����һ��
T_sim = mapminmax('reverse',Tn_sim,outputps);

toc
%% ����Ա�
result = [T_test' T_sim'];
% �������
E = mse(T_sim - T_test)
% ����ϵ��
N = length(T_test);
R2 = (N*sum(T_sim.*T_test)-sum(T_sim)*sum(T_test))^2/((N*sum((T_sim).^2)-(sum(T_sim))^2)*(N*sum((T_test).^2)-(sum(T_test))^2))

%% ��ͼ
figure
plot(1:length(T_test),T_test,'r*')
hold on
plot(1:length(T_sim),T_sim,'b:o')
xlabel('���Լ��������')
ylabel('���Լ����')
title('ELM���Լ����')
legend('�������','Ԥ�����')

figure
plot(1:length(T_test),T_test-T_sim,'r-*')
xlabel('���Լ��������')
ylabel('�������')
title('ELM���Լ�Ԥ�����')

