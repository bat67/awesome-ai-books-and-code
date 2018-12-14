%% Matlab������43����������

% ��ʶSVM������ع�
% by ����(faruto)
% http://www.matlabsky.com
% Email:faruto@163.com
% http://weibo.com/faruto 
% http://blog.sina.com.cn/faruto
% 2013.01.01
%% A Little Clean Work
tic;
clear;
clc;
close all;
format compact;
%% ʹ��Libsvm���з����С����
%{
һ���༶��������������������1������2��������Ů����Ů��1��Ů��2��������
����1 ��ߣ�176cm ���أ�70kg��
����2 ��ߣ�180cm ���أ�80kg��

Ů��1 ��ߣ�161cm ���أ�45kg��
Ů��2 ��ߣ�163cm ���أ�47kg��
������ǽ���������Ϊ1��Ů������Ϊ-1��������������ݷ������data��,
����label�д�����Ů������ǩ��1��-1��
%}
data = [176 70;
        180 80;
        161 45;
        163 47];
label = [1;1;-1;-1];
%{
���������data�������һ�����Ծ�������4������4������������2��ʾ������������
label���Ǳ�ǩ��1��-1��ʾ���������������Ů������
%}

% ����libsvm��������ģ��
model = svmtrain(label,data);

%{
��ʱ�ð༶��ת��һ����ѧ������
���190cm������85kg
������������ǩ����֪��������[1]����Ů[-1]��
�������ǩ���ǲ�֪�������Ǽ������ǩΪ-1��Ҳ���Լ���Ϊ1�� 
%}
testdata = [190 85];
testdatalabel = -1;

[predictlabel,accuracy] = svmpredict(testdatalabel,testdata,model);
predictlabel
if 1 == predictlabel
    disp('==����Ϊ����');
end
if -1 == predictlabel
    disp('==����ΪŮ��');
end

% % ������ʹ��libsvm�����䱾����Ĳ�������heart_scale������һ�²���
% ������������
load heart_scale;
data = heart_scale_inst;
label = heart_scale_label;

% ѡȡǰ200��������Ϊѵ�����ϣ���70��������Ϊ���Լ���
ind = 200;
traindata = data(1:ind,:);
trainlabel = label(1:ind,:);
testdata = data(ind+1:end,:);
testlabel = label(ind+1:end,:);

% ����ѵ�����Ͻ�������ģ��
model = svmtrain(trainlabel,traindata,'-s 0 -t 2 -c 1.2 -g 2.8');

% ���ý�����ģ�Ϳ�����ѵ�������ϵķ���Ч��
[ptrain,acctrain] = svmpredict(trainlabel,traindata,model);

% Ԥ����Լ��ϱ�ǩ
[ptest,acctest] = svmpredict(testlabel,testdata,model);
%% ʹ��Libsvm���лع��С����
% ���ɴ��ع������
x = (-1:0.1:1)';
y = -x.^2;

% ��ģ�ع�ģ��
model = svmtrain(y,x,'-s 3 -t 2 -c 2.2 -g 2.8 -p 0.01');

% ���ý�����ģ�Ϳ�����ѵ�������ϵĻع�Ч��
[py,mse] = svmpredict(y,x,model);

scrsz = get(0,'ScreenSize');
figure('Position',[scrsz(3)*1/4 scrsz(4)*1/6  scrsz(3)*4/5 scrsz(4)]*3/4);
plot(x,y,'o');
hold on;
plot(x,py,'r*');
legend('ԭʼ����','�ع�����');
grid on;

% ����Ԥ��
testx = 1.1;
display('��ʵ����')
testy = -testx.^2

[ptesty,tmse] = svmpredict(testy,testx,model);
display('Ԥ������');
ptesty

%% Record Time
toc;