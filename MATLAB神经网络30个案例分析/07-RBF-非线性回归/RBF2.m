%% ����7��RBF����Ļع�-�����Ժ����ع��ʵ�� 

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

xx1=x1;xx2=x2;FF=F;

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
subplot(2,2,1)
mesh(x1,x2,F);
zlim([0,60])
title('�����ĺ���ͼ��')

% ����ó��ĺ���ͼ��
v=reshape(ty,row);
subplot(2,2,2)
mesh(i,j,v);
zlim([0,60])
title('RBF��������')

% ѵ��ͼ��
subplot(2,2,3)
scatter3(xx1,xx2,FF,6,'filled');
zlim([0,60])
title('ѵ��ͼ��')

% ���ͼ��
subplot(2,2,4)
mesh(x1,x2,F-v);
%zlim([0,0.1])
title('���ͼ��')

set(gcf,'position',[140 ,100,900,600])

err1=sum(sum(abs(F-v))')

