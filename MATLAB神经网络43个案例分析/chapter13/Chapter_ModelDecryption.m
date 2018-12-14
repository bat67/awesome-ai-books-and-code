function Chapter_ModelDecryption
%% Matlab������43����������

% LIBSVM����ʵ�����
% by ����(faruto)
% http://www.matlabsky.com
% Email:faruto@163.com
% http://weibo.com/faruto 
% http://blog.sina.com.cn/faruto
% 2013.01.01
%% A Little Clean Work
clear;
clc;
close all;
format compact;
%%
% ������������
load heart_scale;
data = heart_scale_inst;
label = heart_scale_label;
% ��������ģ��
model = svmtrain(label,data,'-s 0 -t 2 -c 1.2 -g 2.8');
% ���ý�����ģ�Ϳ�����ѵ�������ϵķ���Ч��
[PredictLabel,accuracy] = svmpredict(label,data,model);
accuracy

%% ����ģ��model����
model
Parameters = model.Parameters
Label = model.Label
nr_class = model.nr_class
totalSV = model.totalSV
nSV = model.nSV 

%%
plable = zeros(270,1);
for i = 1:270
    x = data(i,:);
    plabel(i,1) = DecisionFunction(x,model);
end

%% ��֤�Լ�ͨ�����ߺ���Ԥ��ı�ǩ��svmpredict�����ı�ǩ��ͬ
flag = sum(plabel == PredictLabel)

%% DecisionFunction
function plabel = DecisionFunction(x,model)

gamma = model.Parameters(4);
RBF = @(u,v)( exp(-gamma.*sum( (u-v).^2) ) );

len = length(model.sv_coef);
y = 0;

for i = 1:len
    u = model.SVs(i,:);
    y = y + model.sv_coef(i)*RBF(u,x);
end
b = -model.rho;
y = y + b;

if y >= 0
    plabel = 1;
else
    plabel = -1;
end