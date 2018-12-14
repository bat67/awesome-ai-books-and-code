%% �ô���Ϊ�����е�ʦ�ල��Kohonen����ķ����㷨
%
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">�ð�������������</font></b></td>	</tr>	<tr><td><span class="comment"><font size="2">1�����˳���פ���ڴ�<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html"><font color="#0000FF">���</font></a>��Ըð������ʣ��������ʱش𡣱����鼮�ٷ���վΪ��<a href="http://video.ourmatlab.com">video.ourmatlab.com</a></font></span></td></tr><tr>		<td><font size="2">2�����<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">�ӵ���Ԥ������</a>��<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">��Matlab������30������������</a>��</td></tr><tr>	<td><p class="comment"></font><font size="2">3</font><font size="2">���˰��������׵Ľ�ѧ��Ƶ����Ƶ���ط�ʽ<a href="http://video.ourmatlab.com/vbuy.html">video.ourmatlab.com/vbuy.html</a></font><font size="2">�� </font></p></td>	</tr>			<tr>		<td><span class="comment"><font size="2">		4���˰���Ϊԭ��������ת����ע����������Matlab������30����������������</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		5�����˰��������������о��й��������ǻ�ӭ���������Ҫ��ȣ����ǿ��Ǻ���Լ��ڰ����</font></span></td>	</tr>		</table>
% </html>
%% ��ջ�������
clc
clear

%% ���ݴ���
load data
input=datatrain(:,1:38);
attackkind=datatrain(:,39);

%���ݹ�һ��
inputn=input;
[nn,mm]=size(inputn);
[b,c]=sort(rand(1,nn));

%�����������
for i=1:nn
    switch attackkind(i)
        case 1 
            output(i,:)=[1 0 0 0 0];
        case 2
            output(i,:)=[0 1 0 0 0];
        case 3
            output(i,:)=[0 0 1 0 0];
        case 4
            output(i,:)=[0 0 0 1 0];
        case 5
            output(i,:)=[0 0 0 0 1];
    end
end

%ѵ������
input_train=inputn(c(1:4000),:);
output_train=output(c(1:4000),:);

%% ���繹��
%�����ڵ���
Inum=38; 

%Kohonen����
M=6;
N=6; 
K=M*N;%Kohonen�ܽڵ���
g=5; %�����ڵ���

%Kohonen��ڵ�����
k=1;
for i=1:M
    for j=1:N
        jdpx(k,:)=[i,j];
        k=k+1;
    end
end

%ѧϰ��
rate1max=0.1;   
rate1min=0.01;
rate2max=1;   
rate2min=0.5;
%ѧϰ�뾶
r1max=1.5;         
r1min=0.4;

%Ȩֵ��ʼ��
w1=rand(Inum,K);    %��һ��Ȩֵ
w2=zeros(K,g);   %�ڶ���Ȩֵ

%% �������
maxgen=10000;
for i=1:maxgen
    
    %����Ӧѧϰ�ʺ���Ӧ�뾶
    rate1=rate1max-i/maxgen*(rate1max-rate1min);
    rate2=rate2min+i/maxgen*(rate2max-rate2min);
    r=r1max-i/maxgen*(r1max-r1min);
        
    %�������������ȡ
    k=unidrnd(4000);   
    x=input_train(k,:);
    y=output_train(k,:);

    %�������Žڵ�
    [mindist,index]=min(dist(x,w1));
    
    %������Χ�ڵ�
    d1=ceil(index/6);
    d2=mod(index,6);
    nodeindex=find(dist([d1 d2],jdpx')<=r);
    
    %Ȩֵ����
    for j=1:length(nodeindex)
        w1(:,nodeindex(j))=w1(:,nodeindex(j))+rate1*(x'-w1(:,nodeindex(j)));
        w2(nodeindex(j),:)=w2(nodeindex(j),:)+rate2*(y-w2(nodeindex(j),:));
    end
end

%% ������
Index=[];
for i=1:4000
    [mindist,index]=min(dist(inputn(i,:),w1));
    Index=[Index,index];
end

inputn_test=datatest(:,1:38);

%������֤
for i=1:500
    x=inputn_test(i,:);
    %������С����ڵ�
    [mindist,index]=min(dist(x,w1));
    [a,b]=max(w2(index,:));
    outputfore(i)=b;
end

length(find((datatest(:,39)-outputfore')==0))

plot(outputfore,'linewidth',1.5)
hold on
plot(datatest(:,39),':r','linewidth',1.5)
title('�������','fontsize',12)
xlabel('��������','fontsize',12)
ylabel('�������','fontsize',12)
legend('Ԥ�����','�������')
web browser www.matlabsky.com
%%
% <html>
% <table width="656" align="left" >	<tr><td align="center"><p><font size="2"><a href="http://video.ourmatlab.com/">Matlab������30����������</a></font></p><p align="left"><font size="2">�����̳��</font></p><p align="left"><font size="2">��Matlab������30�������������ٷ���վ��<a href="http://video.ourmatlab.com">video.ourmatlab.com</a></font></p><p align="left"><font size="2">Matlab������̳��<a href="http://www.matlabsky.com">www.matlabsky.com</a></font></p><p align="left"><font size="2">M</font><font size="2">atlab�����ٿƣ�<a href="http://www.mfun.la">www.mfun.la</a></font></p><p align="left"><font size="2">Matlab������̳��<a href="http://www.ilovematlab.com">www.ilovematlab.com</a></font></p></td>	</tr></table>
% </html>