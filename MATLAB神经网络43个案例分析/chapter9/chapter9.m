%% Hopfield�������������䡪������ʶ��

%% ��ջ�������
clear all
clc

%% ���ݵ���
load data1 array_one
load data2 array_two

%% ѵ��������Ŀ��������
 T = [array_one;array_two]';
 
%% ��������
 net = newhop(T);
 
%% ����1��2�Ĵ��������ֵ��󣨹̶�����
load data1_noisy noisy_array_one
load data2_noisy noisy_array_two

%% ����1��2�Ĵ��������ֵ����������

% noisy_array_one=array_one;
% noisy_array_two=array_two;
% for i = 1:100
%     a = rand;
%     if a < 0.3
%        noisy_array_one(i) = -array_one(i);
%        noisy_array_two(i) = -array_two(i);
%     end
% end

%% ����ʶ��

% �������桪��TS = 1(������ʽ)
% identify_one = sim(net,10,[],noisy_array_one');  
% �ಽ���桪��Ԫ��������ʽ
noisy_one = {(noisy_array_one)'};                    
identify_one = sim(net,{10,10},{},noisy_one);
identify_one{10}';
noisy_two = {(noisy_array_two)'};
identify_two = sim(net,{10,10},{},noisy_two);
identify_two{10}';

%% �����ʾ
Array_one = imresize(array_one,20);
subplot(3,2,1)
imshow(Array_one)
title('��׼(����1)') 
Array_two = imresize(array_two,20);
subplot(3,2,2)
imshow(Array_two)
title('��׼(����2)') 
subplot(3,2,3)
Noisy_array_one = imresize(noisy_array_one,20);
imshow(Noisy_array_one)
title('����(����1)') 
subplot(3,2,4)
Noisy_array_two = imresize(noisy_array_two,20);
imshow(Noisy_array_two)
title('����(����2)')
subplot(3,2,5)
imshow(imresize(identify_one{10}',20))
title('ʶ��(����1)')
subplot(3,2,6)
imshow(imresize(identify_two{10}',20))
title('ʶ��(����2)')
