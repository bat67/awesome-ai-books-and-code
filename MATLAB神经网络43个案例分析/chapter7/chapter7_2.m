%% Matlab������43����������

% RBF����Ļع�--�����Ժ����ع��ʵ��
% by ��С��(@��С��_matlab)
% http://www.matlabsky.com
% Email:sina363@163.com
% http://weibo.com/hgsz2003
 
%% ��ջ�������
clc
clear
%% ����ѵ��������ѵ�����룬ѵ�������
% ldΪ��������
ld=400; 

% ����2*ld�ľ��� 
x=rand(2,ld); 

% ��xת����[-1.5 1.5]֮��
x=(x-0.5)*1.5*2; 

% x�ĵ�һ��Ϊx1���ڶ���Ϊx2.
x1=x(1,:);
x2=x(2,:);

% �����������Fֵ
F=20+x1.^2-10*cos(2*pi*x1)+x2.^2-10*cos(2*pi*x2);

%% ����RBF������ 
% ����approximate RBF�����硣spreadΪĬ��ֵ
net=newrb(x,F);

%% ������������

% generate the testing data
interval=0.1;
[i, j]=meshgrid(-1.5:interval:1.5);
row=size(i);
tx1=i(:);
tx1=tx1';
tx2=j(:);
tx2=tx2';
tx=[tx1;tx2];

%% ʹ�ý�����RBF�������ģ�⣬�ó��������
ty=sim(net,tx);

%% ʹ��ͼ�񣬻���3άͼ

% �����ĺ���ͼ��
interval=0.1;
[x1, x2]=meshgrid(-1.5:interval:1.5);
F = 20+x1.^2-10*cos(2*pi*x1)+x2.^2-10*cos(2*pi*x2);
subplot(1,3,1)
mesh(x1,x2,F);
zlim([0,60])
title('�����ĺ���ͼ��')

% ����ó��ĺ���ͼ��
v=reshape(ty,row);
subplot(1,3,2)
mesh(i,j,v);
zlim([0,60])
title('RBF��������')


% ���ͼ��
subplot(1,3,3)
mesh(x1,x2,F-v);
zlim([0,60])
title('���ͼ��')

set(gcf,'position',[300 ,250,900,400])

