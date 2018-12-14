%% �ô���Ϊ����ģ���������ˮ�����۴���
%
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">�ð�������������</font></b></td>	</tr>	<tr><td><span class="comment"><font size="2">1�����˳���פ���ڴ�<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html"><font color="#0000FF">���</font></a>��Ըð������ʣ��������ʱش𡣱����鼮�ٷ���վΪ��<a href="http://video.ourmatlab.com">video.ourmatlab.com</a></font></span></td></tr><tr>		<td><font size="2">2�����<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">�ӵ���Ԥ������</a>��<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">��Matlab������30������������</a>��</td></tr><tr>	<td><p class="comment"></font><font size="2">3</font><font size="2">���˰��������׵Ľ�ѧ��Ƶ����Ƶ���ط�ʽ<a href="http://video.ourmatlab.com/vbuy.html">video.ourmatlab.com/vbuy.html</a></font><font size="2">�� </font></p></td>	</tr>			<tr>		<td><span class="comment"><font size="2">		4���˰���Ϊԭ��������ת����ע����������Matlab������30����������������</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		5�����˰��������������о��й��������ǻ�ӭ���������Ҫ��ȣ����ǿ��Ǻ���Լ��ڰ����</font></span></td>	</tr>		</table>
% </html>
%% ��ջ�������
clc
clear

%% ������ʼ��
xite=0.001;
alfa=0.05;

%����ڵ�
I=6;   %����ڵ���
M=12;  %�����ڵ���
O=1;   %����ڵ���

%ϵ����ʼ��
p0=0.3*ones(M,1);p0_1=p0;p0_2=p0_1;
p1=0.3*ones(M,1);p1_1=p1;p1_2=p1_1;
p2=0.3*ones(M,1);p2_1=p2;p2_2=p2_1;
p3=0.3*ones(M,1);p3_1=p3;p3_2=p3_1;
p4=0.3*ones(M,1);p4_1=p4;p4_2=p4_1;
p5=0.3*ones(M,1);p5_1=p5;p5_2=p5_1;
p6=0.3*ones(M,1);p6_1=p6;p6_2=p6_1;

%������ʼ��
c=1+rands(M,I);c_1=c;c_2=c_1;
b=1+rands(M,I);b_1=b;b_2=b_1;

maxgen=100; %��������

%����������ݣ��������ݹ�һ��
load data1 input_train output_train input_test output_test

%ѡ����������������ݹ�һ��
[inputn,inputps]=mapminmax(input_train);
[outputn,outputps]=mapminmax(output_train);
[n,m]=size(input_train);

%% ����ѵ��
%ѭ����ʼ����������
for iii=1:maxgen
    iii;
    for k=1:m        
        x=inputn(:,k);
        
        %��������
        for i=1:I
            for j=1:M
                u(i,j)=exp(-(x(i)-c(j,i))^2/b(j,i));
            end
        end
        
        %ģ���������
        for i=1:M
            w(i)=u(1,i)*u(2,i)*u(3,i)*u(4,i)*u(5,i)*u(6,i);
        end    
        addw=sum(w);
        
        for i=1:M
            yi(i)=p0_1(i)+p1_1(i)*x(1)+p2_1(i)*x(2)+p3_1(i)*x(3)+p4_1(i)*x(4)+p5_1(i)*x(5)+p6_1(i)*x(6);
        end
        
        addyw=yi*w';
        %����Ԥ�����
        yn(k)=addyw/addw;
        e(k)=outputn(k)-yn(k);
        
        %����p�ı仯ֵ
        d_p=zeros(M,1);
        d_p=xite*e(k)*w./addw;
        d_p=d_p';
        
        %����b�仯ֵ
        d_b=0*b_1;
        for i=1:M
            for j=1:I
                d_b(i,j)=xite*e(k)*(yi(i)*addw-addyw)*(x(j)-c(i,j))^2*w(i)/(b(i,j)^2*addw^2);
            end
        end  
        
        %����c�仯ֵ
        for i=1:M
            for j=1:I
                d_c(i,j)=xite*e(k)*(yi(i)*addw-addyw)*2*(x(j)-c(i,j))*w(i)/(b(i,j)*addw^2);
            end
        end
        
        p0=p0_1+ d_p+alfa*(p0_1-p0_2);
        p1=p1_1+ d_p*x(1)+alfa*(p1_1-p1_2);
        p2=p2_1+ d_p*x(2)+alfa*(p2_1-p2_2);
        p3=p3_1+ d_p*x(3)+alfa*(p3_1-p3_2);
        p4=p4_1+ d_p*x(4)+alfa*(p4_1-p4_2);
        p5=p5_1+ d_p*x(5)+alfa*(p5_1-p5_2);
        p6=p6_1+ d_p*x(6)+alfa*(p6_1-p6_2);
            
        b=b_1+d_b+alfa*(b_1-b_2);      
        c=c_1+d_c+alfa*(c_1-c_2);
   
        p0_2=p0_1;p0_1=p0;
        p1_2=p1_1;p1_1=p1;
        p2_2=p2_1;p2_1=p2;
        p3_2=p3_1;p3_1=p3;
        p4_2=p4_1;p4_1=p4;
        p5_2=p5_1;p5_1=p5;
        p6_2=p6_1;p6_1=p6;

        c_2=c_1;c_1=c;   
        b_2=b_1;b_1=b;
        
    end   
    E(iii)=sum(abs(e));

end

figure(1);
plot(outputn,'r')
hold on
plot(yn,'b')
hold on
plot(outputn-yn,'g');
legend('ʵ�����','Ԥ�����','���','fontsize',12)
title('ѵ������Ԥ��','fontsize',12)
xlabel('�������','fontsize',12)
ylabel('ˮ�ʵȼ�','fontsize',12)

%% ����Ԥ��
%���ݹ�һ��
inputn_test=mapminmax('apply',input_test,inputps);
[n,m]=size(inputn_test)
for k=1:m
    x=inputn_test(:,k);
         
     %��������м��
     for i=1:I
         for j=1:M
             u(i,j)=exp(-(x(i)-c(j,i))^2/b(j,i));
         end
     end
     
     for i=1:M
         w(i)=u(1,i)*u(2,i)*u(3,i)*u(4,i)*u(5,i)*u(6,i);
     end
                 
     addw=0;
     for i=1:M  
         addw=addw+w(i);
     end
         
     for i=1:M  
         yi(i)=p0_1(i)+p1_1(i)*x(1)+p2_1(i)*x(2)+p3_1(i)*x(3)+p4_1(i)*x(4)+p5_1(i)*x(5)+p6_1(i)*x(6);        
     end
         
     addyw=0;        
     for i=1:M    
         addyw=addyw+yi(i)*w(i);        
     end
         
     %�������
     yc(k)=addyw/addw;
end

%Ԥ��������һ��
test_simu=mapminmax('reverse',yc,outputps);
%��ͼ
figure(2)
plot(output_test,'r')
hold on
plot(test_simu,'b')
hold on
plot(test_simu-output_test,'g')
legend('ʵ�����','Ԥ�����','���','fontsize',12)
title('��������Ԥ��','fontsize',12)
xlabel('�������','fontsize',12)
ylabel('ˮ�ʵȼ�','fontsize',12)

%% ���꽭ʵ��ˮ��Ԥ��
load  data2 hgsc gjhy dxg
%-----------------------------------�칤ˮ��-----------------------------------
zssz=hgsc;
%���ݹ�һ��
inputn_test =mapminmax('apply',zssz,inputps);
[n,m]=size(zssz);

for k=1:1:m
    x=inputn_test(:,k);
        
    %��������м��
    for i=1:I
        for j=1:M
            u(i,j)=exp(-(x(i)-c(j,i))^2/b(j,i));
        end
    end
    
    for i=1:M
        w(i)=u(1,i)*u(2,i)*u(3,i)*u(4,i)*u(5,i)*u(6,i);
    end
                
    addw=0;
        
    for i=1:M   
        addw=addw+w(i);
    end
        
    for i=1:M   
        yi(i)=p0_1(i)+p1_1(i)*x(1)+p2_1(i)*x(2)+p3_1(i)*x(3)+p4_1(i)*x(4)+p5_1(i)*x(5)+p6_1(i)*x(6);        
    end
        
    addyw=0;        
    for i=1:M    
        addyw=addyw+yi(i)*w(i);        
    end
        
    %�������
    szzb(k)=addyw/addw;
end
szzbz1=mapminmax('reverse',szzb,outputps);

for i=1:m
    if szzbz1(i)<=1.5
        szpj1(i)=1;
    elseif szzbz1(i)>1.5&&szzbz1(i)<=2.5
        szpj1(i)=2;
    elseif szzbz1(i)>2.5&&szzbz1(i)<=3.5
        szpj1(i)=3;
    elseif szzbz1(i)>3.5&&szzbz1(i)<=4.5
        szpj1(i)=4;
    else
        szpj1(i)=5;
    end
end
% %-----------------------------------�߼һ�԰-----------------------------------
zssz=gjhy;
inputn_test =mapminmax('apply',zssz,inputps);
[n,m]=size(zssz);

for k=1:1:m
    x=inputn_test(:,k);
        
    %��������м��
    for i=1:I
        for j=1:M
            u(i,j)=exp(-(x(i)-c(j,i))^2/b(j,i));
        end
    end
    
    for i=1:M
        w(i)=u(1,i)*u(2,i)*u(3,i)*u(4,i)*u(5,i)*u(6,i);
    end
                
    addw=0;
        
    for i=1:M   
        addw=addw+w(i);
    end
        
    for i=1:M   
        yi(i)=p0_1(i)+p1_1(i)*x(1)+p2_1(i)*x(2)+p3_1(i)*x(3)+p4_1(i)*x(4)+p5_1(i)*x(5)+p6_1(i)*x(6);        
    end
        
    addyw=0;        
    for i=1:M    
        addyw=addyw+yi(i)*w(i);        
    end
        
    %�������
    szzb(k)=addyw/addw;
end
szzbz2=mapminmax('reverse',szzb,outputps);

for i=1:m
    if szzbz2(i)<=1.5
        szpj2(i)=1;
    elseif szzbz2(i)>1.5&&szzbz2(i)<=2.5
        szpj2(i)=2;
    elseif szzbz2(i)>2.5&&szzbz2(i)<=3.5
        szpj2(i)=3;
    elseif szzbz2(i)>3.5&&szzbz2(i)<=4.5
        szpj2(i)=4;
    else
        szpj2(i)=5;
    end
end
% %-----------------------------------��Ϫ��ˮ��-----------------------------------
zssz=dxg;
inputn_test =mapminmax('apply',zssz,inputps);
[n,m]=size(zssz);

for k=1:1:m
    x=inputn_test(:,k);
        
    %��������м��
    for i=1:I
        for j=1:M
            u(i,j)=exp(-(x(i)-c(j,i))^2/b(j,i));
        end
    end
    
    for i=1:M
        w(i)=u(1,i)*u(2,i)*u(3,i)*u(4,i)*u(5,i)*u(6,i);
    end
                
    addw=0;
        
    for i=1:M   
        addw=addw+w(i);
    end
        
    for i=1:M   
        yi(i)=p0_1(i)+p1_1(i)*x(1)+p2_1(i)*x(2)+p3_1(i)*x(3)+p4_1(i)*x(4)+p5_1(i)*x(5)+p6_1(i)*x(6);        
    end
        
    addyw=0;        
    for i=1:M    
        addyw=addyw+yi(i)*w(i);        
    end
        
    %�������
    szzb(k)=addyw/addw;
end
szzbz3=mapminmax('reverse',szzb,outputps);

for i=1:m
    if szzbz3(i)<=1.5
        szpj3(i)=1;
    elseif szzbz3(i)>1.5&&szzbz3(i)<=2.5
        szpj3(i)=2;
    elseif szzbz3(i)>2.5&&szzbz3(i)<=3.5
        szpj3(i)=3;
    elseif szzbz3(i)>3.5&&szzbz3(i)<=4.5
        szpj3(i)=4;
    else
        szpj3(i)=5;
    end
end

figure(3)
plot(szzbz1,'o-r')
hold on
plot(szzbz2,'*-g')
hold on
plot(szzbz3,'*:b')
xlabel('ʱ��','fontsize',12)
ylabel('Ԥ��ˮ��','fontsize',12)
legend('�칤ˮ��','�߼һ�԰ˮ��','��Ϫ��ˮ��','fontsize',12)

web browser www.matlabsky.com
%%
% <html>
% <table width="656" align="left" >	<tr><td align="center"><p><font size="2"><a href="http://video.ourmatlab.com/">Matlab������30����������</a></font></p><p align="left"><font size="2">�����̳��</font></p><p align="left"><font size="2">��Matlab������30�������������ٷ���վ��<a href="http://video.ourmatlab.com">video.ourmatlab.com</a></font></p><p align="left"><font size="2">Matlab������̳��<a href="http://www.matlabsky.com">www.matlabsky.com</a></font></p><p align="left"><font size="2">M</font><font size="2">atlab�����ٿƣ�<a href="http://www.mfun.la">www.mfun.la</a></font></p><p align="left"><font size="2">Matlab������̳��<a href="http://www.ilovematlab.com">www.ilovematlab.com</a></font></p></td>	</tr></table>
% </html>