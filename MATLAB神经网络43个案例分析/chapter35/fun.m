function y = fun(x)
%�������ڼ���������Ӧ��ֵ
%x           input           �������� 
%y           output          ������Ӧ��ֵ 

y=-20*exp(-0.2*sqrt((x(1)^2+x(2)^2)/2))-exp((cos(2*pi*x(1))+cos(2*pi*x(2)))/2)+20+exp(1);

%y=x(1)^2-10*cos(2*pi*x(1))+10+x(2)^2-10*cos(2*pi*x(2))+10;

