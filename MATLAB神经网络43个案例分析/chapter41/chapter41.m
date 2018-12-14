%% Matlab������43����������

% �����������ʵ��-������ĸ��Ի���ģ�����
% by ��С��(@��С��_matlab)
% http://www.matlabsky.com
% Email:sina363@163.com
% http://weibo.com/hgsz2003

%% ��ջ�������
clear all
clc
warning off
%% ����һ�����ա�������
net = network

%% ����������������� 
net.numInputs = 2;
net.numLayers = 3;

%% ʹ��view(net)�۲�������ṹ��
view(net)
% ��ʱ���������������룬������Ԫ�㡣����ע�⣺net.numInputs���õ���
% ����������������ÿ�������ά������net.inputs{i}.size���ơ�

%%  ��ֵ���Ӷ���
net.biasConnect(1) = 1;
net.biasConnect(3) = 1;
% ����ʹ��net.biasConnect = [1; 0; 1];
view(net)

%% ����������Ӷ���
net.inputConnect(1,1) = 1;
net.inputConnect(2,1) = 1;
net.inputConnect(2,2) = 1;
% ����ʹ��net.inputConnect = [1 0; 1 1; 0 0];
view(net)
net.layerConnect = [0 0 0; 0 0 0; 1 1 1];
view(net)
%% ����������� 
net.outputConnect = [0 1 1];
view(net)

%% ��������
net.inputs
net.inputs{1}
net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
net.inputs{2}.size = 5;
net.inputs{1}.exampleInput = [0 10 5; 0 3 10];
view(net)

%% ������
net.layers{1}
% ���������һ�����Ԫ��������Ϊ4�����䴫�ݺ�������Ϊ��tansig����
% �����ʼ����������ΪNguyen-Widrow������
net.layers{1}.size = 4;
net.layers{1}.transferFcn = 'tansig';
net.layers{1}.initFcn = 'initnw';
% ���ڶ�����Ԫ��������Ϊ3�����䴫�ݺ�������Ϊ��logsig������ʹ�á�initnw����ʼ����
net.layers{2}.size = 3;
net.layers{2}.transferFcn = 'logsig';
net.layers{2}.initFcn = 'initnw';
% ���������ʼ����������Ϊ��initnw��
net.layers{3}.initFcn = 'initnw';
view(net)

%% �������
net.outputs
net.outputs{2}

%% ��ֵ������Ȩֵ���Ȩֵ����
net.biases
net.biases{1}
net.inputWeights
net.layerWeights

%% ���������ĳЩȨֵ���ӳٽ������� 
net.inputWeights{2,1}.delays = [0 1];
net.inputWeights{2,2}.delays = 1;
net.layerWeights{3,3}.delays = 1;

%% ���纯������
% ���������ʼ������Ϊ��initlay��������������Ϳ��԰���
% �������õĲ��ʼ�������� initnw����Nguyen-Widrow���г�ʼ����
net.initFcn = 'initlay';
% ����������������Ϊ��mse����mean squared error����ͬʱ���������ѵ������
% ����Ϊ��trainlm��Levenberg-Marquardt backpropagation)��
net.performFcn = 'mse';
net.trainFcn = 'trainlm';
% Ϊ��ʹ����������������ѵ�����ݼ������ǿ��Խ�divideFcn����Ϊ��dividerand����
net.divideFcn = 'dividerand';
% �� plot functions����Ϊ����plotperform��,��plottrainstate��
net.plotFcns = {'plotperform','plottrainstate'};

%% Ȩֵ��ֵ��С����
net.IW{1,1}, net.IW{2,1}, net.IW{2,2}
net.LW{3,1}, net.LW{3,2}, net.LW{3,3}
net.b{1}, net.b{3}

%% �������ʼ��
net = init(net);
net.IW{1,1}

%% �������ѵ��
X = {[0; 0] [2; 0.5]; [2; -2; 1; 0; 1] [-1; -1; 1; 0; 1]};
T = {[1; 1; 1] [0; 0; 0]; 1 -1};
Y = sim(net,X)

%% �������ѵ������
net.trainParam

%%  ѵ������
net = train(net,X,T);

%% ����������������Ƿ���Ӧ������
Y = sim(net,X)