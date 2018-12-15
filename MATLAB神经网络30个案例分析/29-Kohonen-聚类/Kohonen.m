%% ��ջ�������
clc
clear

%% ���ݴ���
load data
input=datatrain(:,1:38);
output=datatrain(:,39)';
%���ݹ�һ��
[inputn,inputps]=mapminmax(input'); %inputn ������
inputn=inputn';
[nn,mm]=size(inputn);

%% ���繹��
%�����ڵ���
Inum=38; 

%Kohonen����
M=6;
N=6; 
K=M*N;%Kohonen�ܽڵ���

%Kohonen��ڵ�����
k=1;
for i=1:M
    for j=1:N
        jdpx(k,:)=[i,j];
        k=k+1;
    end
end

%ѧϰ��
rate1max=0.2;   
rate1min=0.05;
%ѧϰ�뾶
r1max=1.5;         
r1min=0.8;

%Ȩֵ��ʼ��
w1=rand(Inum,K);    %��һ��Ȩֵ

%% �������
maxgen=10000;
for i=1:maxgen
    
    %����Ӧѧϰ�ʺ���Ӧ�뾶
    rate1=rate1max-i/maxgen*(rate1max-rate1min);
    r=r1max-i/maxgen*(r1max-r1min);
    
    %�������������ȡ
    k=unidrnd(4000);   
    x=inputn(k,:);

    %�������Žڵ�
    [mindist,index]=min(dist(x,w1));
    
    %������Χ�ڵ�
    d1=ceil(index/6);
    d2=mod(index,6);
    nodeindex=find(dist([d1 d2],jdpx')<r);
    
    %Ȩֵ����
    for j=1:K
        %��������Ȩֵ
        if sum(nodeindex==j)
            w1(:,j)=w1(:,j)+rate1*(x'-w1(:,j));
        end
    end
end

%% ������
Index=[];
for i=1:4000
    [mindist,index]=min(dist(inputn(i,:),w1));
    Index=[Index,index];
end
