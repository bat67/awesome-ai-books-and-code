%% �Ŵ��㷨���Ż����㡪�������Ա�����ά

%% ��ջ�������
clear all
clc
warning off
%% ����ȫ�ֱ���
global P_train T_train P_test T_test  mint maxt S s1
S = 30;
s1 = 50;
%% ��������
load data.mat
a = randperm(569);
Train = data(a(1:500),:);
Test = data(a(501:end),:);
% ѵ������
P_train = Train(:,3:end)';
T_train = Train(:,2)';
% ��������
P_test = Test(:,3:end)';
T_test = Test(:,2)';
% ��ʾʵ������
total_B = length(find(data(:,2) == 1));
total_M = length(find(data(:,2) == 2));
count_B = length(find(T_train == 1));
count_M = length(find(T_train == 2));
number_B = length(find(T_test == 1));
number_M = length(find(T_test == 2));
disp('ʵ������Ϊ��');
disp(['����������' num2str(569)...
      '  ���ԣ�' num2str(total_B)...
      '  ���ԣ�' num2str(total_M)]);
disp(['ѵ��������������' num2str(500)...
      '  ���ԣ�' num2str(count_B)...
      '  ���ԣ�' num2str(count_M)]);
disp(['���Լ�����������' num2str(69)...
      '  ���ԣ�' num2str(number_B)...
      '  ���ԣ�' num2str(number_M)]);
%% ���ݹ�һ��
[P_train,minp,maxp,T_train,mint,maxt] = premnmx(P_train,T_train);
P_test = tramnmx(P_test,minp,maxp);
%% ������BP����
t = cputime;
net_bp = newff(minmax(P_train),[s1,1],{'tansig','purelin'},'trainlm');
% ����ѵ������
net_bp.trainParam.epochs = 1000;
net_bp.trainParam.show = 10;
net_bp.trainParam.goal = 0.1;
net_bp.trainParam.lr = 0.1;
net_bp.trainParam.showwindow = 0;
%% ѵ����BP����
net_bp = train(net_bp,P_train,T_train);
%% ������Ե�BP����
tn_bp_sim = sim(net_bp,P_test);
% ����һ��
T_bp_sim = postmnmx(tn_bp_sim,mint,maxt);
e = cputime - t;
T_bp_sim(T_bp_sim > 1.5) = 2;
T_bp_sim(T_bp_sim < 1.5) = 1;
result_bp = [T_bp_sim' T_test'];
%% �����ʾ����BP���磩
number_B_sim = length(find(T_bp_sim == 1 & T_test == 1));
number_M_sim = length(find(T_bp_sim == 2 &T_test == 2));
disp('(1)BP����Ĳ��Խ��Ϊ��');
disp(['������������ȷ�' num2str(number_B_sim)...
      '  ���' num2str(number_B - number_B_sim)...
      '  ȷ����p1 = ' num2str(number_B_sim/number_B*100) '%']);
disp(['������������ȷ�' num2str(number_M_sim)...
      '  ���' num2str(number_M - number_M_sim)...
      '  ȷ����p2 = ' num2str(number_M_sim/number_M*100) '%']);
disp(['��ģʱ��Ϊ��' num2str(e) 's'] );
%% �Ŵ��㷨�Ż�
popu = 20;  
bounds = ones(S,1)*[0,1];
% ������ʼ��Ⱥ
initPop = randint(popu,S,[0 1]);
% �����ʼ��Ⱥ��Ӧ��
initFit = zeros(popu,1);
for i = 1:size(initPop,1)
    initFit(i) = de_code(initPop(i,:));
end
initPop = [initPop initFit];
gen = 100; 
% �Ż�����
[X,EndPop,BPop,Trace] = ga(bounds,'fitness',[],initPop,[1e-6 1 0],'maxGenTerm',...
    gen,'normGeomSelect',0.09,'simpleXover',2,'boundaryMutation',[2 gen 3]);
[m,n] = find(X == 1);
disp(['�Ż�ɸѡ��������Ա������Ϊ:' num2str(n)]);
% ������Ӧ�Ⱥ�����������
figure
plot(Trace(:,1),Trace(:,3),'r:')
hold on
plot(Trace(:,1),Trace(:,2),'b')
xlabel('��������')
ylabel('��Ӧ�Ⱥ���')
title('��Ӧ�Ⱥ�����������')
legend('ƽ����Ӧ�Ⱥ���','�����Ӧ�Ⱥ���')
xlim([1 gen])
%% ��ѵ����/���Լ�������ȡ
p_train = zeros(size(n,2),size(T_train,2));
p_test = zeros(size(n,2),size(T_test,2));
for i = 1:length(n)
    p_train(i,:) = P_train(n(i),:);
    p_test(i,:) = P_test(n(i),:);
end
t_train = T_train;
%% �����Ż�BP����
t = cputime;
net_ga = newff(minmax(p_train),[s1,1],{'tansig','purelin'},'trainlm');
% ѵ����������
net_ga.trainParam.epochs = 1000;
net_ga.trainParam.show = 10;
net_ga.trainParam.goal = 0.1;
net_ga.trainParam.lr = 0.1;
net_ga.trainParam.showwindow = 0;
%% ѵ���Ż�BP����
net_ga = train(net_ga,p_train,t_train);
%% ��������Ż�BP����
tn_ga_sim = sim(net_ga,p_test);
% ����һ��
T_ga_sim = postmnmx(tn_ga_sim,mint,maxt);
e = cputime - t;
T_ga_sim(T_ga_sim > 1.5) = 2;
T_ga_sim(T_ga_sim < 1.5) = 1;
result_ga = [T_ga_sim' T_test'];
%% �����ʾ���Ż�BP���磩
number_b_sim = length(find(T_ga_sim == 1 & T_test == 1));
number_m_sim = length(find(T_ga_sim == 2 &T_test == 2));
disp('(2)�Ż�BP����Ĳ��Խ��Ϊ��');
disp(['������������ȷ�' num2str(number_b_sim)...
      '  ���' num2str(number_B - number_b_sim)...
      '  ȷ����p1=' num2str(number_b_sim/number_B*100) '%']);
disp(['������������ȷ�' num2str(number_m_sim)...
      '  ���' num2str(number_M - number_m_sim)...
      '  ȷ����p2=' num2str(number_m_sim/number_M*100) '%']);
disp(['��ģʱ��Ϊ��' num2str(e) 's'] );
