%% �ô���Ϊ���ڻ�ɫ�������Ԥ���㷨
%
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">�ð�������������</font></b></td>	</tr>	<tr><td><span class="comment"><font size="2">1�����˳���פ���ڴ�<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html"><font color="#0000FF">���</font></a>��Ըð������ʣ��������ʱش𡣱����鼮�ٷ���վΪ��<a href="http://video.ourmatlab.com">video.ourmatlab.com</a></font></span></td></tr><tr>		<td><font size="2">2�����<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">�ӵ���Ԥ������</a>��<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">��Matlab������30������������</a>��</td></tr><tr>	<td><p class="comment"></font><font size="2">3</font><font size="2">���˰��������׵Ľ�ѧ��Ƶ����Ƶ���ط�ʽ<a href="http://video.ourmatlab.com/vbuy.html">video.ourmatlab.com/vbuy.html</a></font><font size="2">�� </font></p></td>	</tr>			<tr>		<td><span class="comment"><font size="2">		4���˰���Ϊԭ��������ת����ע����������Matlab������30����������������</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		5�����˰��������������о��й��������ǻ�ӭ���������Ҫ��ȣ����ǿ��Ǻ���Լ��ڰ����</font></span></td>	</tr>		</table>
% </html>
%% ��ջ�������
clc
clear

load data

%% �����ۼ���Ϊ��������
[n,m]=size(X);
for i=1:n
    y(i,1)=sum(X(1:i,1));
    y(i,2)=sum(X(1:i,2));
    y(i,3)=sum(X(1:i,3));
    y(i,4)=sum(X(1:i,4));
    y(i,5)=sum(X(1:i,5));
    y(i,6)=sum(X(1:i,6));
end

%% ���������ʼ��
a=0.3+rand(1)/4;
b1=0.3+rand(1)/4;
b2=0.3+rand(1)/4;
b3=0.3+rand(1)/4;
b4=0.3+rand(1)/4;
b5=0.3+rand(1)/4;

%% ѧϰ���ʳ�ʼ��
u1=0.0015;
u2=0.0015;
u3=0.0015;
u4=0.0015;
u5=0.0015;

%% Ȩֵ��ֵ��ʼ��
t=1;
w11=a;
w21=-y(1,1);
w22=2*b1/a;
w23=2*b2/a;
w24=2*b3/a;
w25=2*b4/a;
w26=2*b5/a;
w31=1+exp(-a*t);
w32=1+exp(-a*t);
w33=1+exp(-a*t);
w34=1+exp(-a*t);
w35=1+exp(-a*t);
w36=1+exp(-a*t);
theta=(1+exp(-a*t))*(b1*y(1,2)/a+b2*y(1,3)/a+b3*y(1,4)/a+b4*y(1,5)/a+b5*y(1,6)/a-y(1,1));

kk=1;

%% ѭ������
for j=1:10
%ѭ������
E(j)=0;
for i=1:30
    
    %% �����������
    t=i;
    LB_b=1/(1+exp(-w11*t));   %LB�����
    LC_c1=LB_b*w21;           %LC�����
    LC_c2=y(i,2)*LB_b*w22;    %LC�����
    LC_c3=y(i,3)*LB_b*w23;    %LC�����
    LC_c4=y(i,4)*LB_b*w24;    %LC�����
    LC_c5=y(i,5)*LB_b*w25;    %LC�����
    LC_c6=y(i,6)*LB_b*w26;    %LC����� 
    LD_d=w31*LC_c1+w32*LC_c2+w33*LC_c3+w34*LC_c4+w35*LC_c5+w36*LC_c6;    %LD�����
    theta=(1+exp(-w11*t))*(w22*y(i,2)/2+w23*y(i,3)/2+w24*y(i,4)/2+w25*y(i,5)/2+w26*y(i,6)/2-y(1,1));   %��ֵ
    ym=LD_d-theta;   %�������ֵ
    yc(i)=ym;
    
    %% Ȩֵ����
    error=ym-y(i,1);      %�������
    E(j)=E(j)+abs(error);    %������       
    error1=error*(1+exp(-w11*t));     %�������
    error2=error*(1+exp(-w11*t));     %�������
    error3=error*(1+exp(-w11*t));
    error4=error*(1+exp(-w11*t));
    error5=error*(1+exp(-w11*t));
    error6=error*(1+exp(-w11*t));
    error7=(1/(1+exp(-w11*t)))*(1-1/(1+exp(-w11*t)))*(w21*error1+w22*error2+w23*error3+w24*error4+w25*error5+w26*error6);
    
    %�޸�Ȩֵ
    w22=w22-u1*error2*LB_b;
    w23=w23-u2*error3*LB_b;
    w24=w24-u3*error4*LB_b;
    w25=w25-u4*error5*LB_b;
    w26=w26-u5*error6*LB_b;
    w11=w11+a*t*error7;
end
end  

%���������������仯����
figure(1)
plot(E)
title('ѵ�����','fontsize',12);
xlabel('��������','fontsize',12);
ylabel('���','fontsize',12);
%print -dtiff -r600 28-3

%����ѵ���Ļ�ɫ���������Ԥ��
for i=31:36
    t=i;
    LB_b=1/(1+exp(-w11*t));   %LB�����
    LC_c1=LB_b*w21;           %LC�����
    LC_c2=y(i,2)*LB_b*w22;    %LC�����
    LC_c3=y(i,3)*LB_b*w23;    %LC�����
    LC_c4=y(i,4)*LB_b*w24;    %LC�����
    LC_c5=y(i,5)*LB_b*w25;
    LC_c6=y(i,6)*LB_b*w26;
    LD_d=w31*LC_c1+w32*LC_c2+w33*LC_c3+w34*LC_c4+w35*LC_c5+w36*LC_c6;    %LD�����
    theta=(1+exp(-w11*t))*(w22*y(i,2)/2+w23*y(i,3)/2+w24*y(i,4)/2+w25*y(i,5)/2+w26*y(i,6)/2-y(1,1));   %��ֵ
    ym=LD_d-theta;   %�������ֵ
    yc(i)=ym;
end
yc=yc*100000;
y(:,1)=y(:,1)*10000;

%����Ԥ���ÿ��������
for j=36:-1:2
    ys(j)=(yc(j)-yc(j-1))/10;
end

figure(2)
plot(ys(31:36),'-*');
hold on
plot(X(31:36,1)*10000,'r:o');
legend('��ɫ������','ʵ�ʶ�����')
title('��ɫϵͳԤ��','fontsize',12)
xlabel('�·�','fontsize',12)
ylabel('����','fontsize',12)
web browser www.matlabsky.com
%%
% <html>
% <table width="656" align="left" >	<tr><td align="center"><p><font size="2"><a href="http://video.ourmatlab.com/">Matlab������30����������</a></font></p><p align="left"><font size="2">�����̳��</font></p><p align="left"><font size="2">��Matlab������30�������������ٷ���վ��<a href="http://video.ourmatlab.com">video.ourmatlab.com</a></font></p><p align="left"><font size="2">Matlab������̳��<a href="http://www.matlabsky.com">www.matlabsky.com</a></font></p><p align="left"><font size="2">M</font><font size="2">atlab�����ٿƣ�<a href="http://www.mfun.la">www.mfun.la</a></font></p><p align="left"><font size="2">Matlab������̳��<a href="http://www.ilovematlab.com">www.ilovematlab.com</a></font></p></td>	</tr></table>
% </html>