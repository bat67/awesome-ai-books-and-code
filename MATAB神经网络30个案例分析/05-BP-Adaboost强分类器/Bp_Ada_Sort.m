%% ��ջ�������
clc
clear

%% ��������
load data input_train output_train input_test output_test

%% Ȩ�س�ʼ��
[mm,nn]=size(input_train);
D(1,:)=ones(1,nn)/nn;

%% ������������
K=15;
for i=1:K
    
    %ѵ��������һ��
    [inputn,inputps]=mapminmax(input_train);
    [outputn,outputps]=mapminmax(output_train);
    error(i)=0;
    
    %BP�����繹��
    net=newff(inputn,outputn,6);
    net.trainParam.epochs=30;
    net.trainParam.lr=0.01;
    net.trainParam.goal=0.00004;
    net.trainParam.max_fail=10;
    
    %BP������ѵ��
    net=train(net,inputn,outputn);
    
    %ѵ������Ԥ��
    an1=sim(net,inputn);
    test_simu1(i,:)=mapminmax('reverse',an1,outputps);
    
    %��������Ԥ��
    inputn_test =mapminmax('apply',input_test,inputps);
    an=sim(net,inputn_test);
    test_simu(i,:)=mapminmax('reverse',an,outputps);
    
    %ͳ�����Ч��
    kk1=find(test_simu1(i,:)>0);
    kk2=find(test_simu1(i,:)<0);
    
    aa(kk1)=1;
    aa(kk2)=-1;
    
    %ͳ�ƴ���������
    for j=1:nn
        if aa(j)~=output_train(j);
            error(i)=error(i)+D(i,j);
        end
    end
    
    %��������iȨ��
    at(i)=0.5*log((1-error(i))/error(i));
    
    %����Dֵ
    for j=1:nn
        D(i+1,j)=D(i,j)*exp(-at(i)*aa(j)*test_simu1(i,j));
    end
    
    %Dֵ��һ��
    Dsum=sum(D(i+1,:));
    D(i+1,:)=D(i+1,:)/Dsum;
    
end

%% ǿ������������
output=sign(at*test_simu);

%% ������ͳ��
%ͳ��ǿ������ÿ�����������
kkk1=0;
kkk2=0;
for j=1:350
    if output(j)==1
        if output(j)~=output_test(j)
            kkk1=kkk1+1;
        end
    end
    if output(j)==-1
        if output(j)~=output_test(j)
            kkk2=kkk2+1;
        end
    end
end

kkk1;
kkk2;
disp('��һ�����  �ڶ������  �ܴ���');
% ������ʾ
disp([kkk1 kkk2  kkk1+kkk2]);

plot(output)
hold on
plot(output_test,'g')

%ͳ����������Ч��
for i=1:K
    error1(i)=0;
    kk1=find(test_simu(i,:)>0);
    kk2=find(test_simu(i,:)<0);
    
    aa(kk1)=1;
    aa(kk2)=-1;
    
    for j=1:350
        if aa(j)~=output_test(j);
            error1(i)=error1(i)+1;
        end
    end
end
disp('ͳ��������������Ч��');
error1

disp('ǿ���������������')
(kkk1+kkk2)/350

disp('�����������������')
(sum(error1)/(K*350))
