function fitness = fun(x)
% �������ܣ�����ø����Ӧ��Ӧ��ֵ
% x           input     ����
% fitness     output    ������Ӧ��ֵ

%
load data net inputps outputps

%���ݹ�һ��
x=x';
inputn_test=mapminmax('apply',x,inputps);
 
%����Ԥ�����
an=sim(net,inputn_test);
 
%�����������һ��
fitness=mapminmax('reverse',an,outputps);

