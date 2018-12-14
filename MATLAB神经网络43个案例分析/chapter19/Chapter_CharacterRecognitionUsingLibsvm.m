function Chapter_CharacterRecognitionUsingLibsvm
%% Matlab������43����������

% ����SVM����д����ʶ��
% by ����(faruto)
% http://www.matlabsky.com
% Email:faruto@163.com
% http://weibo.com/faruto 
% http://blog.sina.com.cn/faruto
% 2013.01.01
%% A Little Clean Work
close all;
clear;
clc;
format compact;
%% ����ѵ������

% ����uigetfile��������ʽѡȡѵ������
[FileName,PathName,FilterIndex] = uigetfile( ...
    {'*.jpg';'*.bmp'},'�뵼��ѵ��ͼƬ','*.jpg','MultiSelect','on');
if ~FilterIndex
    return;
end
num_train = length(FileName);
TrainData = zeros(num_train,16*16);
TrainLabel = zeros(num_train,1);
for k = 1:num_train
    pic = imread([PathName,FileName{k}]);
    pic = pic_preprocess(pic);
    
    % ����׼��ͼ��������һ��������ת�ã�����50*256��ѵ����������
    TrainData(k,:) = double(pic(:)');
    % ������ǩΪ��������Ӧ������
    TrainLabel(k) = str2double(FileName{k}(4));
end
%% ����֧��������
% [bestCVaccuracy,bestc,bestg] = ...
%     SVMcgForClass(TrainLabel,TrainData,-8,8,-8,8,10,0.8,0.8,4.5)

% ����GA��ز���
    ga_option.maxgen = 100;
    ga_option.sizepop = 20;
    ga_option.cbound = [0,100];
    ga_option.gbound = [0,100];
    ga_option.v = 10;
    ga_option.ggap = 0.9;
    [bestCVaccuracy,bestc,bestg] = ...
    gaSVMcgForClass(TrainLabel,TrainData,ga_option)

% ѵ��
cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
model = svmtrain(TrainLabel, TrainData, cmd);
% ��ѵ�����ϲ鿴ʶ������
preTrainLabel = svmpredict(TrainLabel, TrainData, model);
%% �����������
[FileName,PathName,FilterIndex] = uigetfile( ...
    {'*.jpg';'*.bmp'},'�뵼�����ͼƬ','*.bmp','MultiSelect','on');
if ~FilterIndex
    return;
end
num_train = length(FileName);
TestData = zeros(num_train,16*16);
TestLabel = zeros(num_train,1);
for k = 1:num_train
    pic = imread([PathName,FileName{k}]);
    pic = pic_preprocess(pic);
    
    TestData(k,:) = double(pic(:)');
    TestLabel(k) = str2double(FileName{k}(4));
end
%% �Բ����������з���
preTestLabel = svmpredict(TestLabel, TestData, model);
assignin('base','TestLabel',TestLabel);
assignin('base','preTestLabel',preTestLabel);
TestLabel'
preTestLabel'
%% sub function of pre-processing pic
function pic_preprocess = pic_preprocess(pic)
% ͼƬԤ�����Ӻ���
% ͼ��ɫ����
pic = 255-pic;
% �趨��ֵ������ɫͼ��ת�ɶ�ֵͼ��
pic = im2bw(pic,0.4);
% �����������������ص���б�y���б�x
[y,x] = find(pic == 1);
% ��ȡ�����������ֵ���С����
pic_preprocess = pic(min(y):max(y), min(x):max(x));
% ����ȡ�İ����������ֵ���С����ͼ��ת��16*16�ı�׼��ͼ��
pic_preprocess = imresize(pic_preprocess,[16,16]);


