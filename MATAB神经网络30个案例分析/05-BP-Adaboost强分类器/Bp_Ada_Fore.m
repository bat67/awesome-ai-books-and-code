%% ��ջ�������
clc
clear

%% ��������
load data1 input output

%% Ȩ�س�ʼ��
k=rand(1,2000);
[m,n]=sort(k);

%ѵ������
input_train=input(n(1:1900),:)';
output_train=output(n(1:1900),:)';

%��������
input_test=input(n(1901:2000),:)';
output_test=output(n(1901:2000),:)';

%����Ȩ��
[mm,nn]=size(input_train);
D(1,:)=ones(1,nn)/nn;

%ѵ��������һ��
[inputn,inputps]=mapminmax(input_train);
[outputn,outputps]=mapminmax(output_train);

K=15;
for i=1:K
    
    %��Ԥ����ѵ��
    net=newff(inputn,outputn,5);   %���������ݵĵ���
    net.trainParam.epochs=150;
    net.trainParam.lr=0.1;
    net.trainParam.goal=0.00001;
    net=train(net,inputn,outputn);
    
    %��Ԥ����Ԥ��
    an1=sim(net,inputn);
    BPoutput=mapminmax('reverse',an1,outputps);
    
    %Ԥ�����
    erroryc(i,:)=output_train-BPoutput;
    
    %��������Ԥ��
    inputn1=mapminmax('apply',input_test,inputps);
    an2=sim(net,inputn1);
    test_simu(i,:)=mapminmax('reverse',an2,outputps);
    
    %����Dֵ
    Error(i)=0;
    for j=1:nn
        if abs(erroryc(i,j))>0.1  %�ϴ����  %������޵ĵ���
            Error(i)=Error(i)+D(i,j);
            D(i+1,j)=D(i,j)*1.1;
        else
            D(i+1,j)=D(i,j);
        end
    end
    
    %������Ԥ����Ȩ��
    at(i)=0.5/exp(abs(Error(i)));
    
    %Dֵ��һ��
    D(i+1,:)=D(i+1,:)/sum(D(i+1,:));
    
end

%% ǿԤ����Ԥ��
at=at/sum(at);

%% ���ͳ��
%ǿԤ����Ч��
output=at*test_simu;
error=output_test-output;
plot(abs(error),'-*')
hold on
for i=1:K
error1(i,:)=test_simu(i,:)-output;
end
plot(mean(abs(error1)),'-or')

title('ǿԤ����Ԥ��������ֵ','fontsize',12)
xlabel('Ԥ������','fontsize',12)
ylabel('������ֵ','fontsize',12)
legend('ǿԤ����Ԥ��','��Ԥ����Ԥ��')

err1=sum(mean(abs(error1)))
err2=sum(abs(error))
