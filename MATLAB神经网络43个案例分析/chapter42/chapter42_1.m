%% Matlab������43����������

% ����������������-����CPU/GPU�Ĳ�������������
% by ��С��(@��С��_matlab)
% http://www.matlabsky.com
% Email:sina363@163.com
% http://weibo.com/hgsz2003
% ������Ϊʾ������ű������鲻Ҫ�������У�����ʱע�ⱸע��ʾ��


%% CPU����
%% ��׼���̵߳�������ѵ����������
[x,t]=house_dataset;
net1=feedforwardnet(10);
net2=train(net1,x,t);
y=sim(net2,x);

%% ��MATLAB workers
matlabpool open
% ���worker����
poolsize=matlabpool('size')

%% ����train��sim�����еĲ�����Useparallel��Ϊ��yes����
net2=train(net1,x,t,'Useparallel','yes')
y=sim(net2,x,'Useparallel','yes')

%% ʹ�á�showResources��ѡ��֤ʵ����������ȷʵ�ڸ���worker�����С�
net2=train(net1,x,t,'useParallel','yes','showResources','yes');
y=sim(net2,x,'useParallel','yes','showResources','yes');

%% ��һ�����ݼ�����������֣�ͬʱ���浽��ͬ���ļ�
for i=1:matlabpool('size')
x=rand(2,1000);
save(['inputs' num2str(i)],'x')
t=x(1,:).*x(2,:)+2*(x(1,:)+x(2,:)) ;
save(['target' num2str(i)],'t');
clear x t
end

%% ʵ�ֲ�������������ݼ���
for i=1:matlabpool('size')
    data=load(['inputs' num2str(i)],'x')
    xc{i}=data.x
    data=load(['target' num2str(i)],'t')
    tc{i}=data.t;
    clear data
end
net2=configure(net2,xc{1},tc{1});
net2=train(net2,xc,tc);
yc=sim(net2,xc)

%% �õ�����worker���ص�Composite���
for i=1:matlabpool('size')
    yi=yc{i}
end

%% GPU����
count=gpuDeviceCount
gpu1=gpuDevice(1)
gpuCores1=gpu1.MultiprocessorCount*gpu1.SIMDWidth
net2=train(net1,x,t,'useGPU','yes')
y=sim(net,x,'useGPU','yes')
net1.trainFcn='trainscg';
net2=train(net1,x,t,'useGPU','yes','showResources','yes');
 y=sim(net2,x, 'useGPU','yes','showResources','yes');
