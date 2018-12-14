%% Matlab������43����������

% ����������������-����CPU/GPU�Ĳ�������������
% by ��С��(@��С��_matlab)
% http://www.matlabsky.com
% Email:sina363@163.com
% http://weibo.com/hgsz2003
 

%% ��ջ�������
clear all
clc
warning off

%% ��matlabpool
matlabpool open
poolsize=matlabpool('size');

%% ��������
load bodyfat_dataset
inputs = bodyfatInputs;
targets = bodyfatTargets;

%% ����һ�����������
hiddenLayerSize = 10;   % ���ز���Ԫ����Ϊ10
net = fitnet(hiddenLayerSize);  % ��������

%% ָ�����������������(���������Ǳ���)
net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};

%% �����������ѵ������֤���������ݼ�����
net.divideFcn = 'dividerand';  % ����������ݼ�
net.divideMode = 'sample';  %  ���ֵ�λΪÿһ������
net.divideParam.trainRatio = 70/100; %ѵ��������
net.divideParam.valRatio = 15/100; %��֤������
net.divideParam.testRatio = 15/100; %���Լ�����

%% ���������ѵ������
net.trainFcn = 'trainlm';  % Levenberg-Marquardt

%% �������������
net.performFcn = 'mse';  % Mean squared error

%% ����������ӻ�����
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};

%% ���߳�����ѵ��
tic
[net1,tr1] = train(net,inputs,targets);
t1=toc;
disp(['���߳��������ѵ��ʱ��Ϊ',num2str(t1),'��']);

%% ��������ѵ��
tic
[net2,tr2] = train(net,inputs,targets,'useParallel','yes','showResources','yes');
t2=toc;
disp(['�����������ѵ��ʱ��Ϊ',num2str(t2),'��']);

%% ����Ч����֤
outputs1 = sim(net1,inputs);
outputs2 = sim(net2,inputs);
errors1 = gsubtract(targets,outputs1);
errors2 = gsubtract(targets,outputs2);
performance1 = perform(net1,targets,outputs1)
performance2 = perform(net2,targets,outputs2)

%% ��������ӻ�
figure, plotperform(tr1);
figure, plotperform(tr2);
figure, plottrainstate(tr1);
figure, plottrainstate(tr2);
figure,plotregression(targets,outputs1);
figure,plotregression(targets,outputs2);
figure,ploterrhist(errors1);
figure,ploterrhist(errors2);

matlabpool close