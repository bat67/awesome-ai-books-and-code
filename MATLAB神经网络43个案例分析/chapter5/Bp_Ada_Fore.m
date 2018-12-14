%% �ô���Ϊ����BP_Adaboost��ǿԤ����Ԥ��
%
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">�ð�������������</font></b></td>	</tr>	<tr><td><span class="comment"><font size="2">1�����˳���פ���ڴ�<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html"><font color="#0000FF">���</font></a>��Ըð������ʣ��������ʱش𡣱����鼮�ٷ���վΪ��<a href="http://video.ourmatlab.com">video.ourmatlab.com</a></font></span></td></tr><tr>		<td><font size="2">2�����<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">�ӵ���Ԥ������</a>��<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">��Matlab������30������������</a>��</td></tr><tr>	<td><p class="comment"></font><font size="2">3</font><font size="2">���˰��������׵Ľ�ѧ��Ƶ����Ƶ���ط�ʽ<a href="http://video.ourmatlab.com/vbuy.html">video.ourmatlab.com/vbuy.html</a></font><font size="2">�� </font></p></td>	</tr>			<tr>		<td><span class="comment"><font size="2">		4���˰���Ϊԭ��������ת����ע����������Matlab������30����������������</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		5�����˰��������������о��й��������ǻ�ӭ���������Ҫ��ȣ����ǿ��Ǻ���Լ��ڰ����</font></span></td>	</tr>		</table>
% </html>
%% ��ջ�������
clc
clear

%% ��������
load data1 input output

%% Ȩ�س�ʼ��
k=rand(1,2000);
[m,n]=sort(k);

%ѵ������
input_train=input(n(1:1900),:)';
output_train=output(n(1:1900),:)';

%��������
input_test=input(n(1901:2000),:)';
output_test=output(n(1901:2000),:)';

%����Ȩ��
[mm,nn]=size(input_train);
D(1,:)=ones(1,nn)/nn;

%ѵ��������һ��
[inputn,inputps]=mapminmax(input_train);
[outputn,outputps]=mapminmax(output_train);

K=10;
for i=1:K
    
    %��Ԥ����ѵ��
    net=newff(inputn,outputn,5);
    net.trainParam.epochs=20;
    net.trainParam.lr=0.1;
    net=train(net,inputn,outputn);
    
    %��Ԥ����Ԥ��
    an1=sim(net,inputn);
    BPoutput=mapminmax('reverse',an1,outputps);
    
    %Ԥ�����
    erroryc(i,:)=output_train-BPoutput;
    
    %��������Ԥ��
    inputn1=mapminmax('apply',input_test,inputps);
    an2=sim(net,inputn1);
    test_simu(i,:)=mapminmax('reverse',an2,outputps);
    
    %����Dֵ
    Error(i)=0;
    for j=1:nn
        if abs(erroryc(i,j))>0.2  %�ϴ����
            Error(i)=Error(i)+D(i,j);
            D(i+1,j)=D(i,j)*1.1;
        else
            D(i+1,j)=D(i,j);
        end
    end
    
    %������Ԥ����Ȩ��
    at(i)=0.5/exp(abs(Error(i)));
    
    %Dֵ��һ��
    D(i+1,:)=D(i+1,:)/sum(D(i+1,:));
    
end

%% ǿԤ����Ԥ��
at=at/sum(at);

%% ���ͳ��
%ǿ������Ч��
output=at*test_simu;
error=output_test-output;
plot(abs(error),'-*')
hold on
for i=1:8
error1(i,:)=test_simu(i,:)-output;
end
plot(mean(abs(error1)),'-or')

title('ǿԤ����Ԥ��������ֵ','fontsize',12)
xlabel('Ԥ������','fontsize',12)
ylabel('������ֵ','fontsize',12)
legend('ǿԤ����Ԥ��','��Ԥ����Ԥ��')
web browser www.matlabsky.com

%%
% <html>
% <table width="656" align="left" >	<tr><td align="center"><p><font size="2"><a href="http://video.ourmatlab.com/">Matlab������30����������</a></font></p><p align="left"><font size="2">�����̳��</font></p><p align="left"><font size="2">��Matlab������30�������������ٷ���վ��<a href="http://video.ourmatlab.com">video.ourmatlab.com</a></font></p><p align="left"><font size="2">Matlab������̳��<a href="http://www.matlabsky.com">www.matlabsky.com</a></font></p><p align="left"><font size="2">M</font><font size="2">atlab�����ٿƣ�<a href="http://www.mfun.la">www.mfun.la</a></font></p><p align="left"><font size="2">Matlab������̳��<a href="http://www.ilovematlab.com">www.ilovematlab.com</a></font></p></td>	</tr></table>
% </html>