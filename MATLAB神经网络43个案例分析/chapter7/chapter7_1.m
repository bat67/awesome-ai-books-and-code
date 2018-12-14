%% Matlab������43����������

% RBF����Ļع�--�����Ժ����ع��ʵ��
% by ��С��(@��С��_matlab)
% http://www.matlabsky.com
% Email:sina363@163.com
% http://weibo.com/hgsz2003
 
%% ��ջ�������
clc
clear

%% �������� ������� 
% ���ò��� 
interval=0.01;

% ����x1 x2
x1=-1.5:interval:1.5;
x2=-1.5:interval:1.5;

% ���պ����������Ӧ�ĺ���ֵ����Ϊ����������
F =20+x1.^2-10*cos(2*pi*x1)+x2.^2-10*cos(2*pi*x2); 

%% ���罨����ѵ��
% ���罨�� ����Ϊ[x1;x2],���ΪF��Spreadʹ��Ĭ�ϡ�
net=newrbe([x1;x2],F)

%% �����Ч����֤

% ���ǽ�ԭ���ݻش�����������Ч����
ty=sim(net,[x1;x2]);

% ����ʹ��ͼ����������Է����Ժ��������Ч��
figure
plot3(x1,x2,F,'rd');
hold on;
plot3(x1,x2,ty,'b-.');
view(113,36)
title('���ӻ��ķ����۲�׼ȷRBF����������Ч��')
xlabel('x1')
ylabel('x2')
zlabel('F')
grid on 

