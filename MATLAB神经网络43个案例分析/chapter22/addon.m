%% Matlab������43����������

% ���㾺������������ݷ��ࡪ���߰�֢����Ԥ��
% by ��С��(@��С��_matlab)
% http://www.matlabsky.com
% Email:sina363@163.com
% http://weibo.com/hgsz2003

%% SOM�ṹ����

%% plotsom(pos)

%% �ṹ
% �����ṹ����
pos = gridtop(2,3)

pos = gridtop(3,2)

pos = gridtop(8,10);


% ���ǽṹ����
pos = hextop(2,3)

pos = hextop(8,10);

% �����ṹ����
pos = randtop(2,3)

pos = randtop(8,10);

%% �� ��
% boxdist()

% Box���롣�ڸ���������ĳ����Ԫ��λ�ú󣬿������øú���������Ԫ֮��ľ��롣�ú���ͨ�����ڽṹ������gridtop��������㡣
pos=gridtop(2,2)
plotsom(pos)
boxdist(pos)

% dist ŷʽ���뺯��
dist(pos)

% linkdist ���� ���Ӿ��뺯����
linkdist(pos)

% mandist ���� Manhattan����Ȩ����
mandist(pos) 
