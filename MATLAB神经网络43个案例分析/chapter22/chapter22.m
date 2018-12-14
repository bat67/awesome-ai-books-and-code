%% Matlab������43����������

% ���㾺������������ݷ��ࡪ���߰�֢����Ԥ��
% by ��С��(@��С��_matlab)
% http://www.matlabsky.com
% Email:sina363@163.com
% http://weibo.com/hgsz2003

%% ��ջ�������
clc
clear

%% ¼����������
% ��������
load p;

%ת�ú����������������ʽ
P=P';

%% ���罨����ѵ��
% newsom����SOM���硣minmax��P��ȡ����������Сֵ��������Ϊ6*6=36����Ԫ
net=newsom(minmax(P),[6 6]);
plotsom(net.layers{1}.positions)
% 5��ѵ���Ĳ���
a=[10 30 50 100 200 500 1000];
% �����ʼ��һ��1*10������
yc=rands(7,8);
%% ����ѵ��
% ѵ������Ϊ10��
net.trainparam.epochs=a(1);
% ѵ������Ͳ鿴����
net=train(net,P);
y=sim(net,P);
yc(1,:)=vec2ind(y);
plotsom(net.IW{1,1},net.layers{1}.distances)

% ѵ������Ϊ30��
net.trainparam.epochs=a(2);
% ѵ������Ͳ鿴����
net=train(net,P);
y=sim(net,P);
yc(2,:)=vec2ind(y);
plotsom(net.IW{1,1},net.layers{1}.distances)

% ѵ������Ϊ50��
net.trainparam.epochs=a(3);
% ѵ������Ͳ鿴����
net=train(net,P);
y=sim(net,P);
yc(3,:)=vec2ind(y);
plotsom(net.IW{1,1},net.layers{1}.distances)


% ѵ������Ϊ100��
net.trainparam.epochs=a(4);
% ѵ������Ͳ鿴����
net=train(net,P);
y=sim(net,P);
yc(4,:)=vec2ind(y);
plotsom(net.IW{1,1},net.layers{1}.distances)


% ѵ������Ϊ200��
net.trainparam.epochs=a(5);
% ѵ������Ͳ鿴����
net=train(net,P);
y=sim(net,P);
yc(5,:)=vec2ind(y);
plotsom(net.IW{1,1},net.layers{1}.distances)

% ѵ������Ϊ500��
net.trainparam.epochs=a(6);
% ѵ������Ͳ鿴����
net=train(net,P);
y=sim(net,P);
yc(6,:)=vec2ind(y);
plotsom(net.IW{1,1},net.layers{1}.distances)

% ѵ������Ϊ1000��
net.trainparam.epochs=a(7);
% ѵ������Ͳ鿴����
net=train(net,P);
y=sim(net,P);
yc(7,:)=vec2ind(y);
plotsom(net.IW{1,1},net.layers{1}.distances)
yc
%% �����������Ԥ��
% ������������
t=[0.9512 1.0000 0.9458 -0.4215 0.4218 0.9511 0.9645 0.8941]';
% sim( )�����������
r=sim(net,t);
% �任���� ����ֵ����ת����±�������
rr=vec2ind(r)

%% ������Ԫ�ֲ����
% �鿴��������ѧ�ṹ
plotsomtop(net)
% �鿴�ٽ���Ԫֱ�ӵľ������
plotsomnd(net)
% �鿴ÿ����Ԫ�ķ������
plotsomhits(net,P)
