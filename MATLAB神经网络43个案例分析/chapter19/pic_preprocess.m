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