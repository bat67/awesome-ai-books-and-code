%% a_template_flow_usingSVM_classification
% for classificaton

%%
% by faruto
% Email:patrick.lee@foxmail.com QQ:516667408 http://blog.sina.com.cn/faruto
% last modified 2011.06.08

%% ��ת����ע����
% faruto and liyang , LIBSVM-farutoUltimateVersion 
% a toolbox with implements for support vector machines based on libsvm, 2011. 
% Software available at http://www.matlabsky.com
% 
% Chih-Chung Chang and Chih-Jen Lin, LIBSVM : a library for
% support vector machines, 2001. Software available at
% http://www.csie.ntu.edu.tw/~cjlin/libsvm

%% a little clean work
tic;
close all;
clear;
clc;
format compact;
%% ��������

load wine_test;

%% ��ȡ����
% ...
%% ԭʼ���ݿ��ӻ�
% figure;
% boxplot(train_data,'orientation','horizontal');
% grid on;
% title('Visualization for original data');
% figure;
% for i = 1:length(train_data(:,1))
%     plot(train_data(i,1),train_data(i,2),'r*');
%     hold on;
% end
% grid on;
% title('Visualization for 1st dimension & 2nd dimension of original data');
%% ��һ��Ԥ����
[train_final,test_final] = scaleForSVM(train_data,test_data,0,1);
%% ��һ������ӻ�
% figure;
% for i = 1:length(train_final(:,1))
%     plot(train_final(i,1),train_final(i,2),'r*');
%     hold on;
% end
% grid on;
% title('Visualization for 1st dimension & 2nd dimension of scale data');
%% ��άԤ����(pca)
[train_final,test_final] = pcaForSVM(train_final,test_final,97);
%% feature selection
% using GA,...,etc.
%% ����c��gѰ��ѡ��
% [bestCVaccuracy,bestc,bestg] = SVMcgForClass(train_data_labels,train_final)

% ga_option.maxgen = 100;
% ga_option.sizepop = 20; 
% ga_option.ggap = 0.9;
% ga_option.cbound = [0,100];
% ga_option.gbound = [0,100];
% ga_option.v = 5;
% [bestacc,bestc,bestg] = gaSVMcgForClass(train_data_labels,train_final,ga_option)

pso_option.c1 = 1.5;
pso_option.c2 = 1.7;
pso_option.maxgen = 100;
pso_option.sizepop = 20;
pso_option.k = 0.6;
pso_option.wV = 1;
pso_option.wP = 1;
pso_option.v = 3;
pso_option.popcmax = 100;
pso_option.popcmin = 0.1;
pso_option.popgmax = 100;
pso_option.popgmin = 0.1;
[bestacc,bestc,bestg] = psoSVMcgForClass(train_data_labels,train_final,pso_option)

cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
%% ����Ԥ��
model = svmtrain(train_data_labels, train_final,cmd);

[ptrain_label, train_accuracy] = svmpredict(train_data_labels, train_final, model);

[ptest_label, test_accuracy] = svmpredict(test_data_labels, test_final, model);

%% record time
toc;

