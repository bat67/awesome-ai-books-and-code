%% Matlab������43����������

% GRNN������Ԥ�⡪���ڹ���ع�������Ļ�����Ԥ��
% by ��С��(@��С��_matlab)
% http://www.matlabsky.com
% Email:sina363@163.com
% http://weibo.com/hgsz2003
 
%% ��ջ�������
clc;
clear all
close all
nntwarn off;

%% ��������
load data;
% �������ݲ������ݷֳ�ѵ����Ԥ������
p_train=p(1:12,:);
t_train=t(1:12,:);
p_test=p(13,:);
t_test=t(13,:);
%% ������֤
desired_spread=[];
mse_max=10e20;
desired_input=[];
desired_output=[];
result_perfp=[];
indices = crossvalind('Kfold',length(p_train),4);
h=waitbar(0,'����Ѱ�����Ż�����....');
k=1;
for i = 1:4
    perfp=[];
    disp(['����Ϊ��',num2str(i),'�ν�����֤���'])
    test = (indices == i); train = ~test;
    p_cv_train=p_train(train,:);
    t_cv_train=t_train(train,:);
    p_cv_test=p_train(test,:);
    t_cv_test=t_train(test,:);
    p_cv_train=p_cv_train';
    t_cv_train=t_cv_train';
    p_cv_test= p_cv_test';
    t_cv_test= t_cv_test';
    [p_cv_train,minp,maxp,t_cv_train,mint,maxt]=premnmx(p_cv_train,t_cv_train);
    p_cv_test=tramnmx(p_cv_test,minp,maxp);
    for spread=0.1:0.1:2;
        net=newgrnn(p_cv_train,t_cv_train,spread);
        waitbar(k/80,h);
        disp(['��ǰspreadֵΪ', num2str(spread)]);
        test_Out=sim(net,p_cv_test);
        test_Out=postmnmx(test_Out,mint,maxt);
        error=t_cv_test-test_Out;
        disp(['��ǰ�����mseΪ',num2str(mse(error))])
        perfp=[perfp mse(error)];
        if mse(error)<mse_max
            mse_max=mse(error);
            desired_spread=spread;
            desired_input=p_cv_train;
            desired_output=t_cv_train;
        end
        k=k+1;
    end
    result_perfp(i,:)=perfp;
end;
close(h)
disp(['���spreadֵΪ',num2str(desired_spread)])
disp(['��ʱ�������ֵΪ'])
desired_input
disp(['��ʱ������ֵΪ'])
desired_output
%% ������ѷ�������GRNN����
net=newgrnn(desired_input,desired_output,desired_spread);
p_test=p_test';
p_test=tramnmx(p_test,minp,maxp);
grnn_prediction_result=sim(net,p_test);
grnn_prediction_result=postmnmx(grnn_prediction_result,mint,maxt);
grnn_error=t_test-grnn_prediction_result';
disp(['GRNN��������������Ԥ������Ϊ',num2str(abs(grnn_error))])
save best desired_input desired_output p_test t_test grnn_error mint maxt

