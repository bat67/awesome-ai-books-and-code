%% Matlab������43����������

% �������Ч��̼���-����MATLAB R2012b�°汾���Ե�̽��
% by ��С��(@��С��_matlab)
% http://www.matlabsky.com
% Email:sina363@163.com
% http://weibo.com/hgsz2003
% ע�����Ϊ��ʾ�ű�������ݱ�ע�ֿ�����

%% ���͵�ǰ��������
[x,t]=house_dataset;
net1=feedforwardnet(10);
net2=train(net1,x,t);
y=net2(x);

%% ����reduction
net=train(net1,x,t,'reduction',10);
y=net(x,'reduction',10)

%% �����粢������
% CPU����
matlabpool open
numWorkers = matlabpool('size')

[x,t]=house_dataset;
net=feedforwardnet(10);
net=train(net,x,t,'useparallel','yes')
y=sim(net,x,'useparallel','yes')

% GPU����
net=train(net,x,t,'useGPU','yes')
y=sim(net,x,'useGPU','yes')

%% Elliot S������ʹ��
n=-10:0.01:10;
a1=elliotsig(n);
a2=tansig(n);
h=plot(n,a1,n,a2);
legend(h,'ELLIOTSIG','TANSIG','location','NorthWest')


n = rand(1000,1000);
tic, for i=1:100, a = elliotsig(n); end, elliotsigTime = toc
tic, for i=1:100, a = tansig(n); end, tansigTime = toc
speedup = tansigTime / elliotsigTime

%% �����縺�ؾ���
[x,t] = house_dataset;
Xc = Composite;
Tc = Composite;
Xc{1} = x(:, 1:100); % First 100 samples of x
Tc{1} = t(:, 1:100); % First 100 samples of t
Xc{2} = x(:, 101:506); % Rest samples of x
Tc{2} = t(:, 101:506); % Rest samples of t

%% ������֯����
help nnprocess
help nnweight
help nntransfer
help nnnetinput
help nnperformance
help nndistance
  
