web browser http://www.ilovematlab.cn/thread-60357-1-1.html
%% ˫������BP������
%% ��ջ�������
clc
clear

%% ѵ������Ԥ��������ȡ����һ��
%���������������
load data input output

%��1��2000���������
k=rand(1,2000);
[m,n]=sort(k);

%�ҳ�ѵ�����ݺ�Ԥ������
input_train=input(n(1:1900),:)';
output_train=output(n(1:1900));
input_test=input(n(1901:2000),:)';
output_test=output(n(1901:2000));

%ѡ����������������ݹ�һ��
[inputn,inputps]=mapminmax(input_train);
[outputn,outputps]=mapminmax(output_train);

%% BP����ѵ��
% %��ʼ������ṹ
net=newff(inputn,outputn,[5 5]);

net.trainParam.epochs=100;
net.trainParam.lr=0.1;
net.trainParam.goal=0.00004;

%����ѵ��
net=train(net,inputn,outputn);

%% BP����Ԥ��
%Ԥ�����ݹ�һ��
inputn_test=mapminmax('apply',input_test,inputps);
 
%����Ԥ�����
an=sim(net,inputn_test);
 
%�����������һ��
BPoutput=mapminmax('reverse',an,outputps);

%% �������

figure(1)
plot(BPoutput,':og')
hold on
plot(output_test,'-*');
legend('Ԥ�����','�������')
title('BP����Ԥ�����','fontsize',12)
ylabel('�������','fontsize',12)
xlabel('����','fontsize',12)
%Ԥ�����
error=BPoutput-output_test;


figure(2)
plot(error,'-*')
title('BP����Ԥ�����','fontsize',12)
ylabel('���','fontsize',12)
xlabel('����','fontsize',12)

figure(3)
plot((output_test-BPoutput)./BPoutput,'-*');
title('������Ԥ�����ٷֱ�')

errorsum=sum(abs(error))
web browser http://www.ilovematlab.cn/thread-60357-1-1.html