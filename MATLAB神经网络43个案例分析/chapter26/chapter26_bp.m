%% BP������ķ��ࡪ�������������

%% ��������
net = newff(minmax(P_train),[50 1],{'tansig','purelin'},'trainlm');

%% �����������
net.trainParam.epochs = 1000;
net.trainParam.show = 10;
net.trainParam.lr = 0.1;
net.trainParam.goal = 0.1;

%% ѵ������
net = train(net,P_train,Tc_train);

%% �������
T_sim = sim(net,P_test);
for i = 1:length(T_sim)
    if T_sim(i) <= 1.5
        T_sim(i) = 1;
    else
        T_sim(i) = 2;
    end
end
result = [T_sim;Tc_test]

number_B = length(find(Tc_test == 1));
number_M = length(find(Tc_test == 2));
number_B_sim = length(find(T_sim == 1 & Tc_test == 1));
number_M_sim = length(find(T_sim == 2 &Tc_test == 2));

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