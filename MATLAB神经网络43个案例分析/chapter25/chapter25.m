%% Matlab������43����������

% ���������ɸѡ������MIV�����������ɸѡ
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

% ����x3 x4��������
x=rand(1,301);
x3=(x-0.5)*1.5*2;
x4=(x-0.5)*1.5*2;

% ���պ����������Ӧ�ĺ���ֵ����Ϊ����������
F =20+x1.^2-10*cos(2*pi*x1)+x2.^2-10*cos(2*pi*x2);

%���������������ֵ
p=[x1;x2;x3;x4];
t=F;


%% ����ɸѡ MIV�㷨�ĳ���ʵ�֣����ӻ��߼����Ա�����

p=p';
[m,n]=size(p);
yy_temp=p;

% p_increaseΪ����10%�ľ��� p_decreaseΪ����10%�ľ���
for i=1:n
    p=yy_temp;
    pX=p(:,i);
    pa=pX*1.1;
    p(:,i)=pa;
    aa=['p_increase'  int2str(i) '=p;'];
    eval(aa);
end


for i=1:n
    p=yy_temp;
    pX=p(:,i);
    pa=pX*0.9;
    p(:,i)=pa;
    aa=['p_decrease' int2str(i) '=p;'];
    eval(aa);
end


%% ����ԭʼ����ѵ��һ����ȷ��������
nntwarn off;
p=yy_temp;
p=p';
% bp���罨��
net=newff(minmax(p),[8,1],{'tansig','purelin'},'traingdm');
% ��ʼ��bp����
net=init(net);
% ����ѵ����������
net.trainParam.show=50;
net.trainParam.lr=0.05;
net.trainParam.mc=0.9;
net.trainParam.epochs=2000;

% bp����ѵ��
net=train(net,p,t);


%% ����ɸѡ MIV�㷨�ĺ���ʵ�֣���ֵ���㣩

% ת�ú�sim

for i=1:n
    eval(['p_increase',num2str(i),'=transpose(p_increase',num2str(i),');'])
end

for i=1:n
    eval(['p_decrease',num2str(i),'=transpose(p_decrease',num2str(i),');'])
end


% result_inΪ����10%������ result_deΪ����10%������
for i=1:n
    eval(['result_in',num2str(i),'=sim(net,','p_increase',num2str(i),');'])
end

for i=1:n
    eval(['result_de',num2str(i),'=sim(net,','p_decrease',num2str(i),');'])
end

for i=1:n
    eval(['result_in',num2str(i),'=transpose(result_in',num2str(i),');'])
end

for i=1:n
    eval(['result_de',num2str(i),'=transpose(result_de',num2str(i),');'])
end

%% MIV��ֵΪ���������������MIVֵ MIV����Ϊ���������������۱�����ص����ָ��֮һ������Ŵ�����صķ��򣬾���ֵ��С����Ӱ��������Ҫ�ԡ�


for i=1:n
    IV= ['result_in',num2str(i), '-result_de',num2str(i)];
    eval(['MIV_',num2str(i) ,'=mean(',IV,')'])
    
end
