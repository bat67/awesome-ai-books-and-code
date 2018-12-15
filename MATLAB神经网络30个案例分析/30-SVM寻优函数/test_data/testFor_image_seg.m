%% testFor_image_seg
% for classificaton
clear;
clc;
%% ��������
load image_seg;
%% ��ȡ����
train_data;
train_data_labels = train_label;
test_data;
test_data_labels = test_label;
%% ԭʼ���ݿ��ӻ�
figure;
boxplot(train_data,'orientation','horizontal');
grid on;
title('Visualization for original data');
figure;
for i = 1:length(train_data(:,1))
    plot(train_data(i,1),train_data(i,2),'r*');
    hold on;
end
grid on;
title('Visualization for 1st dimension & 2nd dimension of original data');
%% ��һ��Ԥ����
% [-1,1]
[train_scale,test_scale] = scaleForSVM(train_data,test_data,-1,1);
% [0,1]
[train_scale,test_scale] = scaleForSVM(train_data,test_data,0,1);
%% ��һ������ӻ�
figure;
for i = 1:length(train_scale(:,1))
    plot(train_scale(i,1),train_scale(i,2),'r*');
    hold on;
end
grid on;
title('Visualization for 1st dimension & 2nd dimension of scale data');
%% ��άԤ����(pca)
[train_pca,test_pca] = pcaForSVM(train_scale,test_scale,90);
%% feature selection
% using GA,...,etc.
%% ica
[train_ica,test_ica] = fasticaForSVM(train_scale,test_scale);

%% ����c��gѰ��ѡ��
% for pca
[bestacc,bestc,bestg] = SVMcgForClass(train_data_labels,train_pca,-1,10,-2,5)
% 16 2

% for ica
[bestacc,bestc,bestg] = SVMcgForClass(train_data_labels,train_ica,0,14,-12,0)
% 512 0.0078

cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg)];

% cmd = ['-c 16 -g 2'];
%% predict after pca

model = svmtrain(train_data_labels, train_pca,cmd);
[ptrain_label, train_acc] = svmpredict(train_data_labels, train_pca, model);
[ptest_label, test_acc] = svmpredict(test_data_labels, test_pca, model);
%% predict after ica

model = svmtrain(train_data_labels, train_ica,cmd);
[ptrain_label, train_acc] = svmpredict(train_data_labels, train_ica, model);
[ptest_label, test_acc] = svmpredict(test_data_labels, test_ica, model);









