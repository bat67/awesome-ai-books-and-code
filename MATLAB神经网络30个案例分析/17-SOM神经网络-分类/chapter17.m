%% SOM����������ݷ���--���ͻ��������

%% ��ջ�������
clc
clear

%% ¼����������
% ��������
load p;   %����Ϊ������

%ת�ú����������������ʽ
P=P';     %������

%% ���罨����ѵ��
% newsom����SOM���硣minmax��P��ȡ����������Сֵ��������Ϊ6*6=36����Ԫ
net=newsom(minmax(P),[7 7]);  %��һ��ΪR*2������������С���ֵ��
                              %�ڶ���Ϊ��i���ά��
figure(1)
plotsom(net.layers{1}.positions)
% 5��ѵ���Ĳ���
a=[10 30 50 100 200 500 1000];
% �����ʼ��һ��7*8������
yc=rands(7,8);

%% ����ѵ��
% ѵ������Ϊ10��
net.trainparam.epochs=a(1);
% ѵ������Ͳ鿴����
net=train(net,P);
y=sim(net,P);
yc(1,:)=vec2ind(y);
figure(2)
plotsom(net.IW{1,1},net.layers{1}.distances)

% ѵ������Ϊ30��
net.trainparam.epochs=a(2);
% ѵ������Ͳ鿴����
net=train(net,P);
y=sim(net,P);
yc(2,:)=vec2ind(y);
figure(2)
plotsom(net.IW{1,1},net.layers{1}.distances)

% ѵ������Ϊ50��
net.trainparam.epochs=a(3);
% ѵ������Ͳ鿴����
net=train(net,P);
y=sim(net,P);
yc(3,:)=vec2ind(y);
figure(2)
plotsom(net.IW{1,1},net.layers{1}.distances)


% ѵ������Ϊ100��
net.trainparam.epochs=a(4);
% ѵ������Ͳ鿴����
net=train(net,P);
y=sim(net,P);
yc(4,:)=vec2ind(y);
figure(2)
plotsom(net.IW{1,1},net.layers{1}.distances)


% ѵ������Ϊ200��
net.trainparam.epochs=a(5);
% ѵ������Ͳ鿴����
net=train(net,P);
y=sim(net,P);
yc(5,:)=vec2ind(y);
figure(2)
plotsom(net.IW{1,1},net.layers{1}.distances)

% ѵ������Ϊ500��
net.trainparam.epochs=a(6);
% ѵ������Ͳ鿴����
net=train(net,P);
y=sim(net,P);
yc(6,:)=vec2ind(y);
figure(2)
plotsom(net.IW{1,1},net.layers{1}.distances)

% ѵ������Ϊ1000��
net.trainparam.epochs=a(7);
% ѵ������Ͳ鿴����
net=train(net,P);
y=sim(net,P);
yc(7,:)=vec2ind(y);
figure(2)
plotsom(net.IW{1,1},net.layers{1}.distances)
yc

%% �����������Ԥ��
% ������������
t=[-0.45 -0.2800 -0.9 -0.9215 -0.0811 0.9945 -0.2941 0.5647]';
% sim( )�����������
r=sim(net,t);
% �任���� ����ֵ����ת����±�������ѡ��ÿ�еķ���������λ��ֵ
rr=vec2ind(r)

%% ������Ԫ�ֲ����
% �鿴��������ѧ�ṹ
figure(9)
plotsomtop(net)
% �鿴�ٽ���Ԫֱ�ӵľ������
figure(10)
plotsomnd(net)
% �鿴ÿ����Ԫ�ķ������
figure(11)
plotsomhits(net,P)
