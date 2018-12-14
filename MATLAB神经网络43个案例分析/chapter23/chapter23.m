%% Matlab������43����������

% ����Elman������ĵ�������Ԥ��ģ���о�
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
a=data;

%% ѡȡѵ�����ݺͲ�������

for i=1:6
    p(i,:)=[a(i,:),a(i+1,:),a(i+2,:)];
end
% ѵ����������
p_train=p(1:5,:);
% ѵ���������
t_train=a(4:8,:);
% ������������
p_test=p(6,:);
% �����������
t_test=a(9,:);

% Ϊ��Ӧ����ṹ ��ת��

p_train=p_train';
t_train=t_train';
p_test=p_test';


%% ����Ľ�����ѵ��
% ����ѭ�������ò�ͬ�����ز���Ԫ����
nn=[7 11 14 18];
for i=1:4
    threshold=[0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1];
    % ����Elman������ ���ز�Ϊnn(i)����Ԫ
    net=newelm(threshold,[nn(i),3],{'tansig','purelin'});
    % ��������ѵ������
    net.trainparam.epochs=1000;
    net.trainparam.show=20;
    % ��ʼ������
    net=init(net);
    % Elman����ѵ��
    net=train(net,p_train,t_train);
    % Ԥ������
    y=sim(net,p_test);
    % �������
    error(i,:)=y'-t_test;
end

%% ͨ����ͼ �۲첻ͬ���ز���Ԫ����ʱ�������Ԥ��Ч��

plot(1:1:3,error(1,:),'-ro','linewidth',2);
hold on;
plot(1:1:3,error(2,:),'b:x','linewidth',2);
hold on;
plot(1:1:3,error(3,:),'k-.s','linewidth',2);
hold on;
plot(1:1:3,error(4,:),'c--d','linewidth',2);
title('ElmanԤ�����ͼ')
set(gca,'Xtick',[1:3])
legend('7','11','14','18','location','best')
xlabel('ʱ���')
ylabel('���')
hold off;
