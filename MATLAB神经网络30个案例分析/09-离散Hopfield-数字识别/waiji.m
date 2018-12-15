%% Hopfield�������������䡪������ʶ��

%% �����������
clear
clc 
%% �������ģʽ
load data2.mat
T=array_two;
%% ���������Ȩϵ������
[m,n]=size(T);
w=zeros(m);
for i=1:n
    w=w+T(:,i)*T(:,i)'-eye(m);
end
%% ���������ģʽ
noisy_array=T;
for i=1:100
    a=rand;
    if a<0.1
       noisy_array(i)=-T(i);
    end
end
%% ��������
v0=noisy_array;
v=zeros(m,n);
for k=1:5
    for i=1:m
        v(i,:)=sign(w(i,:)*v0);
    end
    v0=v;
end
%% ��ͼ
subplot(3,1,1)
t=imresize(T,20);
imshow(t)
title('��׼')
subplot(3,1,2)
Noisy_array=imresize(noisy_array,20);
imshow(Noisy_array)
title('����')
subplot(3,1,3)
V=imresize(v,20);
imshow(V)
title('ʶ��')
