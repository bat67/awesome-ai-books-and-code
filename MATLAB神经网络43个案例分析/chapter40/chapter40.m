%% Matlab������43����������

% ��̬������ʱ������Ԥ���о�-����MATLAB��NARXʵ��
% by ��С��(@��С��_matlab)
% http://www.matlabsky.com
% Email:sina363@163.com
% http://weibo.com/hgsz2003

%% ��ջ�������
clear
clc

%% ��������
load phdata
inputSeries = phInputs;
targetSeries = phTargets;

%% �����������Իع�ģ��
inputDelays = 1:2;
feedbackDelays = 1:2;
hiddenLayerSize = 10;
net = narxnet(inputDelays,feedbackDelays,hiddenLayerSize);

%% ��������Ԥ����������
net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
net.inputs{2}.processFcns = {'removeconstantrows','mapminmax'};

%% ʱ����������׼������
[inputs,inputStates,layerStates,targets] = preparets(net,inputSeries,{},targetSeries);

%% ѵ�����ݡ���֤���ݡ��������ݻ���
net.divideFcn = 'dividerand';  
net.divideMode = 'value';  
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

%% ����ѵ�������趨
net.trainFcn = 'trainlm';  % Levenberg-Marquardt

%% �����趨
net.performFcn = 'mse';  % Mean squared error

%% ��ͼ�����趨
net.plotFcns = {'plotperform','plottrainstate','plotresponse', ...
  'ploterrcorr', 'plotinerrcorr'};

%% ����ѵ��
[net,tr] = train(net,inputs,targets,inputStates,layerStates);

%% �������
outputs = net(inputs,inputStates,layerStates);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs)

%% ����ѵ��������֤�������Լ����
trainTargets = gmultiply(targets,tr.trainMask);
valTargets = gmultiply(targets,tr.valMask);
testTargets = gmultiply(targets,tr.testMask);
trainPerformance = perform(net,trainTargets,outputs)
valPerformance = perform(net,valTargets,outputs)
testPerformance = perform(net,testTargets,outputs)

%% ����ѵ��Ч�����ӻ�
figure, plotperform(tr)
figure, plottrainstate(tr)
figure, plotregression(targets,outputs)
figure, plotresponse(targets,outputs)
figure, ploterrcorr(errors)
figure, plotinerrcorr(inputs,errors)


%% close loopģʽ��ʵ��
% ����NARX������ģʽ
narx_net_closed = closeloop(net);
view(net)
view(narx_net_closed)

% ����1500-2000��������Ч��
phInputs_c=phInputs(1500:2000);
PhTargets_c=phTargets(1500:2000);

[p1,Pi1,Ai1,t1] = preparets(narx_net_closed,phInputs_c,{},PhTargets_c);
% �������
yp1 = narx_net_closed(p1,Pi1,Ai1);
plot([cell2mat(yp1)' cell2mat(t1)'])
