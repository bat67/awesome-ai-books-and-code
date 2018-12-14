%% �ô���Ϊ����BP-Adaboost��ǿ����������
%
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">�ð�������������</font></b></td>	</tr>	<tr><td><span class="comment"><font size="2">1�����˳���פ���ڴ�<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html"><font color="#0000FF">���</font></a>��Ըð������ʣ��������ʱش𡣱����鼮�ٷ���վΪ��<a href="http://video.ourmatlab.com">video.ourmatlab.com</a></font></span></td></tr><tr>		<td><font size="2">2�����<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">�ӵ���Ԥ������</a>��<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">��Matlab������30������������</a>��</td></tr><tr>	<td><p class="comment"></font><font size="2">3</font><font size="2">���˰��������׵Ľ�ѧ��Ƶ����Ƶ���ط�ʽ<a href="http://video.ourmatlab.com/vbuy.html">video.ourmatlab.com/vbuy.html</a></font><font size="2">�� </font></p></td>	</tr>			<tr>		<td><span class="comment"><font size="2">		4���˰���Ϊԭ��������ת����ע����������Matlab������30����������������</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		5�����˰��������������о��й��������ǻ�ӭ���������Ҫ��ȣ����ǿ��Ǻ���Լ��ڰ����</font></span></td>	</tr>		</table>
% </html>
%% ��ջ�������
clc
clear

%% ��������
load data input_train output_train input_test output_test

%% Ȩ�س�ʼ��
[mm,nn]=size(input_train);
D(1,:)=ones(1,nn)/nn;

%% ������������
K=10;
for i=1:K
    
    %ѵ��������һ��
    [inputn,inputps]=mapminmax(input_train);
    [outputn,outputps]=mapminmax(output_train);
    error(i)=0;
    
    %BP�����繹��
    net=newff(inputn,outputn,6);
    net.trainParam.epochs=5;
    net.trainParam.lr=0.1;
    net.trainParam.goal=0.00004;
    
    %BP������ѵ��
    net=train(net,inputn,outputn);
    
    %ѵ������Ԥ��
    an1=sim(net,inputn);
    test_simu1(i,:)=mapminmax('reverse',an1,outputps);
    
    %��������Ԥ��
    inputn_test =mapminmax('apply',input_test,inputps);
    an=sim(net,inputn_test);
    test_simu(i,:)=mapminmax('reverse',an,outputps);
    
    %ͳ�����Ч��
    kk1=find(test_simu1(i,:)>0);
    kk2=find(test_simu1(i,:)<0);
    
    aa(kk1)=1;
    aa(kk2)=-1;
    
    %ͳ�ƴ���������
    for j=1:nn
        if aa(j)~=output_train(j);
            error(i)=error(i)+D(i,j);
        end
    end
    
    %��������iȨ��
    at(i)=0.5*log((1-error(i))/error(i));
    
    %����Dֵ
    for j=1:nn
        D(i+1,j)=D(i,j)*exp(-at(i)*aa(j)*test_simu1(i,j));
    end
    
    %Dֵ��һ��
    Dsum=sum(D(i+1,:));
    D(i+1,:)=D(i+1,:)/Dsum;
    
end

%% ǿ������������
output=sign(at*test_simu);

%% ������ͳ��
%ͳ��ǿ������ÿ�����������
kkk1=0;
kkk2=0;
for j=1:350
    if output(j)==1
        if output(j)~=output_test(j)
            kkk1=kkk1+1;
        end
    end
    if output(j)==-1
        if output(j)~=output_test(j)
            kkk2=kkk2+1;
        end
    end
end

kkk1
kkk2
disp('��һ��������  �ڶ���������  �ܴ���');
% ������ʾ
disp([kkk1 kkk2 kkk1+kkk2]);

plot(output)
hold on
plot(output_test,'g')

%ͳ����������Ч��
for i=1:K
    error1(i)=0;
    kk1=find(test_simu(i,:)>0);
    kk2=find(test_simu(i,:)<0);
    
    aa(kk1)=1;
    aa(kk2)=-1;
    
    for j=1:350
        if aa(j)~=output_test(j);
            error1(i)=error1(i)+1;
        end
    end
end
disp('ͳ��������������Ч��');
error1

disp('ǿ���������������')
(kkk1+kkk2)/350

disp('�����������������')
(sum(error1)/(K*350))
web browser www.matlabsky.com
%%
% <html>
% <table width="656" align="left" >	<tr><td align="center"><p><font size="2"><a href="http://video.ourmatlab.com/">Matlab������30����������</a></font></p><p align="left"><font size="2">�����̳��</font></p><p align="left"><font size="2">��Matlab������30�������������ٷ���վ��<a href="http://video.ourmatlab.com">video.ourmatlab.com</a></font></p><p align="left"><font size="2">Matlab������̳��<a href="http://www.matlabsky.com">www.matlabsky.com</a></font></p><p align="left"><font size="2">M</font><font size="2">atlab�����ٿƣ�<a href="http://www.mfun.la">www.mfun.la</a></font></p><p align="left"><font size="2">Matlab������̳��<a href="http://www.ilovematlab.com">www.ilovematlab.com</a></font></p></td>	</tr></table>
% </html>