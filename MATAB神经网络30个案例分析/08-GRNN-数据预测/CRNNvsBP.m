%% ����8��GRNN������Ԥ�⡪���ڹ���ع�������Ļ�����Ԥ��

%% ���³���Ϊ������չ���GRNN��BP�Ƚ� ��Ҫload chapter8.1���������
clc
clear
load best
n=13
p=desired_input
t=desired_output
net_bp=newff(minmax(p),[n,3],{'tansig','purelin'},'trainlm');
% ѵ������
net.trainParam.show=50;
net.trainParam.epochs=2000;
net.trainParam.goal=1e-3;
%����TRAINLM�㷨ѵ��BP����
net_bp=train(net_bp,p,t);
bp_prediction_result=sim(net_bp,p_test);
bp_prediction_result=postmnmx(bp_prediction_result,mint,maxt);
bp_error=t_test-bp_prediction_result';
disp(['BP��������������Ԥ������Ϊ',num2str(abs(bp_error))])
