%% �����������������ٰ�����е�Ӧ���о���2012b�汾��

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

%% ����������������
ctree = ClassificationTree.fit(P_train,T_train);
% �鿴��������ͼ
view(ctree);
view(ctree,'mode','graph');

%% �������
T_sim = predict(ctree,P_test);

%% �������
count_B = length(find(T_train == 1));
count_M = length(find(T_train == 2));
rate_B = count_B / 500;
rate_M = count_M / 500;
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
  
%% Ҷ�ӽڵ㺬�е���С�������Ծ��������ܵ�Ӱ��
leafs = logspace(1,2,10);

N = numel(leafs);

err = zeros(N,1);
for n = 1:N
    t = ClassificationTree.fit(P_train,T_train,'crossval','on','minleaf',leafs(n));
    err(n) = kfoldLoss(t);
end
plot(leafs,err);
xlabel('Ҷ�ӽڵ㺬�е���С������');
ylabel('������֤���');
title('Ҷ�ӽڵ㺬�е���С�������Ծ��������ܵ�Ӱ��')

%% ����minleafΪ28�������Ż�������
OptimalTree = ClassificationTree.fit(P_train,T_train,'minleaf',28);
view(OptimalTree,'mode','graph')

% �����Ż�����������ز������ͽ�����֤���
resubOpt = resubLoss(OptimalTree)
lossOpt = kfoldLoss(crossval(OptimalTree))
% �����Ż�ǰ���������ز������ͽ�����֤���
resubDefault = resubLoss(ctree)
lossDefault = kfoldLoss(crossval(ctree))

%% ��֦
[~,~,~,bestlevel] = cvLoss(ctree,'subtrees','all','treesize','min')
cptree = prune(ctree,'Level',bestlevel);
view(cptree,'mode','graph')

% �����֦����������ز������ͽ�����֤���
resubPrune = resubLoss(cptree)
lossPrune = kfoldLoss(crossval(cptree))

