%% ��ջ�������
clc
clear

%% �����������
load traffic_flux input output input_test output_test

M=size(input,2); %����ڵ����
N=size(output,2); %����ڵ����

n=15; %���νڵ����
lr1=0.01; %ѧϰ����
lr2=0.001; %ѧϰ����
maxgen=200; %��������

%Ȩֵ��ʼ��
Wjk=randn(n,M);Wjk_1=Wjk;Wjk_2=Wjk_1;
Wij=randn(N,n);Wij_1=Wij;Wij_2=Wij_1;
a=randn(1,n);a_1=a;a_2=a_1;
b=randn(1,n);b_1=b;b_2=b_1;

%�ڵ��ʼ��
y=zeros(1,N);
net=zeros(1,n);
net_ab=zeros(1,n);

%Ȩֵѧϰ������ʼ��
d_Wjk=zeros(n,M);
d_Wij=zeros(N,n);
d_a=zeros(1,n);
d_b=zeros(1,n);

%% ����������ݹ�һ��
[inputn,inputps]=mapminmax(input');
[outputn,outputps]=mapminmax(output'); 
inputn=inputn';
outputn=outputn';

%% ����ѵ��
for i=1:maxgen
    
    %����ۼ�
    error(i)=0;
    
    % ѭ��ѵ��
    for kk=1:size(input,1)
        x=inputn(kk,:);
        yqw=outputn(kk,:);
   
        for j=1:n
            for k=1:M
                net(j)=net(j)+Wjk(j,k)*x(k);
                net_ab(j)=(net(j)-b(j))/a(j);
            end
            temp=mymorlet(net_ab(j));
            for k=1:N
                y=y+Wij(k,j)*temp;   %С������
            end
        end
        
        %��������
        error(i)=error(i)+sum(abs(yqw-y));
        
        %Ȩֵ����
        for j=1:n
            %����d_Wij
            temp=mymorlet(net_ab(j));
            for k=1:N
                d_Wij(k,j)=d_Wij(k,j)-(yqw(k)-y(k))*temp;
            end
            %����d_Wjk
            temp=d_mymorlet(net_ab(j));
            for k=1:M
                for l=1:N
                    d_Wjk(j,k)=d_Wjk(j,k)+(yqw(l)-y(l))*Wij(l,j) ;
                end
                d_Wjk(j,k)=-d_Wjk(j,k)*temp*x(k)/a(j);
            end
            %����d_b
            for k=1:N
                d_b(j)=d_b(j)+(yqw(k)-y(k))*Wij(k,j);
            end
            d_b(j)=d_b(j)*temp/a(j);
            %����d_a
            for k=1:N
                d_a(j)=d_a(j)+(yqw(k)-y(k))*Wij(k,j);
            end
            d_a(j)=d_a(j)*temp*((net(j)-b(j))/b(j))/a(j);
        end
        
        %Ȩֵ��������      
        Wij=Wij-lr1*d_Wij;
        Wjk=Wjk-lr1*d_Wjk;
        b=b-lr2*d_b;
        a=a-lr2*d_a;
    
        d_Wjk=zeros(n,M);
        d_Wij=zeros(N,n);
        d_a=zeros(1,n);
        d_b=zeros(1,n);

        y=zeros(1,N);
        net=zeros(1,n);
        net_ab=zeros(1,n);
        
        Wjk_1=Wjk;Wjk_2=Wjk_1;
        Wij_1=Wij;Wij_2=Wij_1;
        a_1=a;a_2=a_1;
        b_1=b;b_2=b_1;
    end
end

%% ����Ԥ��
%Ԥ�������һ��
x=mapminmax('apply',input_test',inputps);
x=x';

%����Ԥ��
for i=1:92
    x_test=x(i,:);

    for j=1:1:n
        for k=1:1:M
            net(j)=net(j)+Wjk(j,k)*x_test(k);
            net_ab(j)=(net(j)-b(j))/a(j);
        end
        temp=mymorlet(net_ab(j));
        for k=1:N
            y(k)=y(k)+Wij(k,j)*temp ; 
        end
    end

    yuce(i)=y(k);
    y=zeros(1,N);
    net=zeros(1,n);
    net_ab=zeros(1,n);
end
%Ԥ���������һ��
ynn=mapminmax('reverse',yuce,outputps);

%% �������
figure(1)
plot(ynn,'r*:')
hold on
plot(output_test,'bo--')
title('Ԥ�⽻ͨ����','fontsize',12)
legend('Ԥ�⽻ͨ����','ʵ�ʽ�ͨ����')
xlabel('ʱ���')
ylabel('��ͨ����')

figure(2)
stem(ynn'-output_test,'b*')
title('Ԥ�⽻ͨ�������','fontsize',12)
xlabel('ʱ���')
ylabel('���')

errsum=sum(abs(ynn'-output_test))
errrate=errsum/sum(abs(output_test))
