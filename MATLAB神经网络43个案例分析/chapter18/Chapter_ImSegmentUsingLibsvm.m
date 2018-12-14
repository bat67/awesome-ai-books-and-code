%% Matlab������43����������

% ����SVM��ͼ��ָ�-���ɫͼ��ָ�
% by ����(faruto)
% http://www.matlabsky.com
% Email:faruto@163.com
% http://weibo.com/faruto 
% http://blog.sina.com.cn/faruto
% 2013.01.01
%% A Little Clean Work
tic;
close all;
clear;
clc;
format compact;
%% ��ȡͼ������

% ����ͼ�񣬷��ھ���pic
pic = imread('littleduck.jpg');
% �鿴����pic�Ĵ�С������
whos pic;

scrsz = get(0,'ScreenSize');
figure('Position',[scrsz(3)*1/4 scrsz(4)*1/6  scrsz(3)*4/5 scrsz(4)]*3/4);
imshow(pic);
%% ȷ��ѵ����

TrainData_background = zeros(20,3,'double');
TrainData_foreground = zeros(20,3,'double');

% % ��������ˮ������
% msgbox('Please get 20 background samples�����OK���ٰ������������', ...
%     'Background Samples','help');
% pause;
% for run = 1:20
%     [x,y] = ginput(1);
%     hold on;
%     plot(x,y,'r*');
%     x = uint8(x);
%     y = uint8(y);
%     TrainData_background(run,1) = pic(x,y,1);
%     TrainData_background(run,2) = pic(x,y,2);
%     TrainData_background(run,3) = pic(x,y,3);
% end 

% % ���ָ������ǰ����Ѽ�ӣ�����
% msgbox('Please get 20 foreground samples which is the part to be segmented�����OK���ٰ������������', ...
%     'Foreground Samples','help');
% pause;
% for run = 1:20
%     [x,y] = ginput(1);
%     hold on;
%     plot(x,y,'ro');
%     x = uint8(x);
%     y = uint8(y);
%     TrainData_foreground(run,1) = pic(x,y,1);
%     TrainData_foreground(run,2) = pic(x,y,2);
%     TrainData_foreground(run,3) = pic(x,y,3);
% end 

% % ��������ˮ��ѵ������ 10*3
TrainData_background = ...
    [52 74 87;
    76 117 150;
    19 48 62;
    35 64 82;
    46 58 36;
    50 57 23;
    110 127 135;
    156 173 189;
    246 242 232;
    166 174 151];

% % ǰ����Ѽ�ӣ�ѵ������ 8*3
TrainData_foreground = ...
    [211 192 107;
    202 193 164;
    32 25 0;
    213 201 151;
    115 75 16;
    101 70 0;
    169 131 22;
    150 133 87];

%% ����֧��������

% let background be 0 & foreground 1
% �� ���ڱ�������ˮ���ĵ�Ϊ0������ǰ����Ѽ�ӣ��ĵ�λ1 
TrainLabel = [zeros(length(TrainData_background),1); ...
    ones(length(TrainData_foreground),1)];

TrainData = [TrainData_background;TrainData_foreground];

model = svmtrain(TrainLabel, TrainData, '-t 1 -d 1');
%% ����Ԥ��i.e.����ͼ��ָ�
preTrainLabel = svmpredict(TrainLabel, TrainData, model);
% ����ά����pic������m������n��ҳ��k
[m,n,k] = size(pic)
% ����ά����picת��m*n�У�k�е�˫���ȶ�ά����
TestData = double(reshape(pic,m*n,k));
% �鿴����TestData�Ĵ�С������
whos TestData;
% Ԥ��ǰ����Ѽ�ӣ��ͱ�������ˮ���ı�ǩ
TestLabal = svmpredict(zeros(length(TestData),1), TestData, model);
%% չʾ�ָ���ͼ��

% ����Ԥ��õ���ǰ����Ѽ�ӣ��ͱ�������ˮ����ǩ������ͼ������ص���з��࣬�����ﵽͼ��ָ�Ŀ�ġ�
ind = reshape([TestLabal,TestLabal,TestLabal],m,n,k);
ind = logical(ind);
pic_seg = pic;
pic_seg(~ind) = 0;

% չʾ�ָ���ͼ��
scrsz = get(0,'ScreenSize');
figure('Position',[scrsz(3)*1/4 scrsz(4)*1/6  scrsz(3)*4/5 scrsz(4)]*3/4);
imshow(pic_seg);
% �ָ�ǰ�ͷָ��ͼ��ԱȲ鿴
scrsz = get(0,'ScreenSize');
figure('Position',[scrsz(3)*1/4 scrsz(4)*1/6  scrsz(3)*4/5 scrsz(4)]*3/4);
subplot(1,2,1);
imshow(pic);
subplot(1,2,2);
imshow(pic_seg);
%%
toc;