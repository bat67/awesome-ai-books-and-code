%% �ô���Ϊ����FCM-GRNN�ľ����㷨
%
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">�ð�������������</font></b></td>	</tr>	<tr><td><span class="comment"><font size="2">1�����˳���פ���ڴ�<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html"><font color="#0000FF">���</font></a>��Ըð������ʣ��������ʱش𡣱����鼮�ٷ���վΪ��<a href="http://video.ourmatlab.com">video.ourmatlab.com</a></font></span></td></tr><tr>		<td><font size="2">2�����<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">�ӵ���Ԥ������</a>��<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">��Matlab������30������������</a>��</td></tr><tr>	<td><p class="comment"></font><font size="2">3</font><font size="2">���˰��������׵Ľ�ѧ��Ƶ����Ƶ���ط�ʽ<a href="http://video.ourmatlab.com/vbuy.html">video.ourmatlab.com/vbuy.html</a></font><font size="2">�� </font></p></td>	</tr>			<tr>		<td><span class="comment"><font size="2">		4���˰���Ϊԭ��������ת����ע����������Matlab������30����������������</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		5�����˰��������������о��й��������ǻ�ӭ���������Ҫ��ȣ����ǿ��Ǻ���Լ��ڰ����</font></span></td>	</tr>		</table>
% </html>
%% ��ջ����ļ�
clear all;
clc;

%% ��ȡ��������

%������������
load netattack;
P1=netattack;
T1=P1(:,39)';
P1(:,39)=[];

%���ݴ�С
[R1,C1]=size(P1);
csum=20;  %��ȡѵ�����ݶ���

%% ģ������
data=P1;
[center,U,obj_fcn] = fcm(data,5);    
for i=1:R1
    [value,idx]=max(U(:,i));
    a1(i)=idx;
end

%% ģ������������
Confusion_Matrix_FCM=zeros(6,6);
Confusion_Matrix_FCM(1,:)=[0:5];
Confusion_Matrix_FCM(:,1)=[0:5]';
for nf=1:5
    for nc=1:5
        Confusion_Matrix_FCM(nf+1,nc+1)=length(find(a1(find(T1==nf))==nc));
    end
end

%% ����ѵ��������ȡ
cent1=P1(find(a1==1),:);cent1=mean(cent1);
cent2=P1(find(a1==2),:);cent2=mean(cent2);
cent3=P1(find(a1==3),:);cent3=mean(cent3);
cent4=P1(find(a1==4),:);cent4=mean(cent4);
cent5=P1(find(a1==5),:);cent5=mean(cent5);

%��ȡ������СΪѵ������
for n=1:R1;
    ecent1(n)=norm(P1(n,:)-cent1);
    ecent2(n)=norm(P1(n,:)-cent2);
    ecent3(n)=norm(P1(n,:)-cent3);
    ecent4(n)=norm(P1(n,:)-cent4);
    ecent5(n)=norm(P1(n,:)-cent5);
end
for n=1:csum
    [va me1]=min(ecent1);
    [va me2]=min(ecent2);
    [va me3]=min(ecent3);
    [va me4]=min(ecent4);
    [va me5]=min(ecent5);
    ecnt1(n,:)=P1(me1(1),:);ecent1(me1(1))=[];tcl(n)=1;
    ecnt2(n,:)=P1(me2(1),:);ecent2(me2(1))=[];tc2(n)=2;
    ecnt3(n,:)=P1(me3(1),:);ecent3(me3(1))=[];tc3(n)=3;
    ecnt4(n,:)=P1(me4(1),:);ecent4(me4(1))=[];tc4(n)=4;
    ecnt5(n,:)=P1(me5(1),:);ecent5(me5(1))=[];tc5(n)=5;
end
P2=[ecnt1;ecnt2;ecnt3;ecnt4;ecnt5];T2=[tcl,tc2,tc3,tc4,tc5];
k=0;

%% ��������
for nit=1:10%��ʼ����
    
    %% �������������
    net = newgrnn(P2',T2,50);   %ѵ����������
    
    a2=sim(net,P1') ;  %Ԥ����
    %�����׼����������������ࣩ
    a2(find(a2<=1.5))=1;
    a2(find(a2>1.5&a2<=2.5))=2;
    a2(find(a2>2.5&a2<=3.5))=3;
    a2(find(a2>3.5&a2<=4.5))=4;
    a2(find(a2>4.5))=5;
    
    %% ����ѵ�������ٴ���ȡ
    cent1=P1(find(a2==1),:);cent1=mean(cent1);
    cent2=P1(find(a2==2),:);cent2=mean(cent2);
    cent3=P1(find(a2==3),:);cent3=mean(cent3);
    cent4=P1(find(a2==4),:);cent4=mean(cent4);
    cent5=P1(find(a2==5),:);cent5=mean(cent5);
    
    for n=1:R1%�����������������ĵľ���
        ecent1(n)=norm(P1(n,:)-cent1);
        ecent2(n)=norm(P1(n,:)-cent2);
        ecent3(n)=norm(P1(n,:)-cent3);
        ecent4(n)=norm(P1(n,:)-cent4);
        ecent5(n)=norm(P1(n,:)-cent5);
    end
    
    %ѡ����ÿ�����������csum������
    for n=1:csum
        [va me1]=min(ecent1);
        [va me2]=min(ecent2);
        [va me3]=min(ecent3);
        [va me4]=min(ecent4);
        [va me5]=min(ecent5);
        ecnt1(n,:)=P1(me1(1),:);ecent1(me1(1))=[];tc1(n)=1;
        ecnt2(n,:)=P1(me2(1),:);ecent2(me2(1))=[];tc2(n)=2;
        ecnt3(n,:)=P1(me3(1),:);ecent3(me3(1))=[];tc3(n)=3;
        ecnt4(n,:)=P1(me4(1),:);ecent4(me4(1))=[];tc4(n)=4;
        ecnt5(n,:)=P1(me5(1),:);ecent5(me5(1))=[];tc5(n)=5;
    end
    
    p2=[ecnt1;ecnt2;ecnt3;ecnt4;ecnt5];T2=[tc1,tc2,tc3,tc4,tc5];

    %ͳ�Ʒ�����
    Confusion_Matrix_GRNN=zeros(6,6);
    Confusion_Matrix_GRNN(1,:)=[0:5];
    Confusion_Matrix_GRNN(:,1)=[0:5]';
    for nf=1:5
        for nc=1:5
            Confusion_Matrix_GRNN(nf+1,nc+1)=length(find(a2(find(T1==nf))==nc));
        end
    end
    
    pre2=0;
    
    for n=2:6;
        pre2=pre2+max(Confusion_Matrix_GRNN(n,:));
    end
    
    pre2=pre2/R1*100;

end

%% �����ʾ
Confusion_Matrix_FCM

Confusion_Matrix_GRNN

web browser www.matlabsky.com
%%
% <html>
% <table width="656" align="left" >	<tr><td align="center"><p><font size="2"><a href="http://video.ourmatlab.com/">Matlab������30����������</a></font></p><p align="left"><font size="2">�����̳��</font></p><p align="left"><font size="2">��Matlab������30�������������ٷ���վ��<a href="http://video.ourmatlab.com">video.ourmatlab.com</a></font></p><p align="left"><font size="2">Matlab������̳��<a href="http://www.matlabsky.com">www.matlabsky.com</a></font></p><p align="left"><font size="2">M</font><font size="2">atlab�����ٿƣ�<a href="http://www.mfun.la">www.mfun.la</a></font></p><p align="left"><font size="2">Matlab������̳��<a href="http://www.ilovematlab.com">www.ilovematlab.com</a></font></p></td>	</tr></table>
% </html>