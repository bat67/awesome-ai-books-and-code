% by faruto
% Email:faruto@163.com
% 2010.06.21

%% 
clear;
clc;
%% 
load heart_scale.mat

%�ѱ�ǩ��Ϊ1,0,�����������
heart_scale_label(heart_scale_label>0) = 1;
heart_scale_label(heart_scale_label<0) = 0;

%ѵ����Ԥ�⣬һ�����ϲ���'-b 1', ���ڹ��Ƹ�������������ǹ��Ʊ�ǩ����Ϊ
%plotroc�����������������Ϊ���Ƹ���
model = svmtrain(heart_scale_label, heart_scale_inst, '-c 0.001 -g 1 -b 1');
[predict_label, accuracy, dec_values] = svmpredict(heart_scale_label, heart_scale_inst,model,'-b 1');

%����,����Ϊʲô�������μ�plotroc�Ĳ���˵��
heart_scale_label = [heart_scale_label, 1 - heart_scale_label];
% plotconfusion(heart_scale_label',dec_values');
targets = heart_scale_label';
outputs = dec_values';
[tpr,fpr,thresholds] = roc(targets,outputs);

%��ROC,ע�������ά��,����ת�ã�
plotroc2009b(targets,outputs);

% plotSVMroc(heart_scale_label,dec_values);
% 
% [X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = ...
% perfcurve(heart_scale_label,dec_values(:,1),'1');
% AUC