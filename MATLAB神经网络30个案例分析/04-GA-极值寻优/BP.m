%% ��ջ�������
clc
clear

tic
%% ѵ������Ԥ��������ȡ����һ��
%���������������
load data input output

%��1��4000���������
k=rand(1,4000);
[m,n]=sort(k);

%�ҳ�ѵ�����ݺ�Ԥ������
input_train=input(n(1:3900),:)';
output_train=output(n(1:3900),:)';
input_test=input(n(3901:4000),:)';
output_test=output(n(3901:4000),:)';

%ѡ����������������ݹ�һ��
[inputn,inputps]=mapminmax(input_train);
[outputn,outputps]=mapminmax(output_train);

%% BP����ѵ��
% %��ʼ������ṹ
net=newff(inputn,outputn,5);

net.trainParam.epochs=800;
net.trainParam.lr=0.01;
net.trainParam.goal=0.0000001;

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
xlabel('����','fontsize',12)
ylabel('���','fontsize',12)
print -dtiff -r600 4-3
%Ԥ�����
error=BPoutput-output_test;

figure(2)
plot(error,'-*')
title('������Ԥ�����')

figure(3)
plot((output_test-BPoutput)./BPoutput,'-*');
title('������Ԥ�����ٷֱ�')

errorsum=sum(abs(error))

toc

save data net inputps outputps
