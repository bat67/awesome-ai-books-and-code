%% ����Hopfield��������Ż��������������Ż�����
% function main �������������
%% ��ջ�������������ȫ�ֱ���
clear 
clc
global A D
%% �������λ��
load cities
%% �����໥���м����
distance=dist(cities,cities');
%% ��ʼ������
N=size(cities,1);
A=200;
D=100;
U0=0.1;
step=0.0001;            %����
delta=2*rand(N,N)-1;
U=U0*log(N-1)+delta;
V=(1+tansig(U/U0))/2;
iter_num=15000;         %��������
E=zeros(1,iter_num);
%% Ѱ�ŵ���
for k=1:iter_num  
    % ��̬���̼���
    dU=diff_u(V,distance);
    % ������Ԫ״̬����
    U=U+dU*step;
    % �����Ԫ״̬����
    V=(1+tansig(U/U0))/2;
    % ������������
    e=energy(V,distance);
    E(k)=e;  
end
 %% �ж�·����Ч��
[rows,cols]=size(V);
V1=zeros(rows,cols);
[V_max,V_ind]=max(V);
for j=1:cols
    V1(V_ind(j),j)=1;
end
C=sum(V1,1);
R=sum(V1,2);
flag=isequal(C,ones(1,N)) & isequal(R',ones(1,N));
%% �����ʾ
if flag==1
   % �����ʼ·������
   sort_rand=randperm(N);
   cities_rand=cities(sort_rand,:);
   Length_init=dist(cities_rand(1,:),cities_rand(end,:)');
   for i=2:size(cities_rand,1)
       Length_init=Length_init+dist(cities_rand(i-1,:),cities_rand(i,:)');
   end
   % ���Ƴ�ʼ·��
%    figure(1)
%    plot([cities_rand(:,1);cities_rand(1,1)],[cities_rand(:,2);cities_rand(1,2)],'o-')
%    for i=1:length(cities)
%        text(cities(i,1),cities(i,2),['   ' num2str(i)])
%    end
%    text(cities_rand(1,1),cities_rand(1,2),['       ���' ])
%    text(cities_rand(end,1),cities_rand(end,2),['       �յ�' ])
%    title(['�Ż�ǰ·��(���ȣ�' num2str(Length_init) ')'])
%    axis([0 1 0 1])
%    grid on
%    xlabel('����λ�ú�����')
%    ylabel('����λ��������')
%    % ��������·������
   [V1_max,V1_ind]=max(V1);
   cities_end=cities(V1_ind,:);
   Length_end=dist(cities_end(1,:),cities_end(end,:)');
   for i=2:size(cities_end,1)
       Length_end=Length_end+dist(cities_end(i-1,:),cities_end(i,:)');
   end
%    disp('����·������');V1_ind
%    % ��������·��
%    figure(2)
%    plot([cities_end(:,1);cities_end(1,1)],...
%        [cities_end(:,2);cities_end(1,2)],'o-')
%    for i=1:length(cities)
%        text(cities(i,1),cities(i,2),['  ' num2str(i)])
%    end
%    text(cities_end(1,1),cities_end(1,2),['       ���' ])
%    text(cities_end(end,1),cities_end(end,2),['       �յ�' ])
%    title(['�Ż���·��(���ȣ�' num2str(Length_end) ')'])
%    axis([0 1 0 1])
%    grid on
%    xlabel('����λ�ú�����')
%    ylabel('����λ��������')
%    % �������������仯����
%    figure(3)
%    plot(1:iter_num,E);
%    ylim([0 2000])
%    title(['���������仯����(����������' num2str(E(end)) ')']);
%    xlabel('��������');
%    ylabel('��������');
    Length_end
    load best bestl
    if Length_end<bestl
        disp('  ����Сֵ��')
        bestl=Length_end;
        save best bestl iter_num
        figure
        plot([cities_end(:,1);cities_end(1,1)],...
           [cities_end(:,2);cities_end(1,2)],'o-')
        for i=1:length(cities)
           text(cities(i,1),cities(i,2),['  ' num2str(i)])
        end
        text(cities_end(1,1),cities_end(1,2),['       ���' ])
        text(cities_end(end,1),cities_end(end,2),['       �յ�' ])
        title(['�Ż���·��(���ȣ�' num2str(Length_end) ')'])
        axis([0 1 0 1])
        grid on
        xlabel('����λ�ú�����')
        ylabel('����λ��������')
    else
        main
    end
else
   main
end


% %===========================================
% function du=diff_u(V,d)
% global A D
% n=size(V,1);
% sum_x=repmat(sum(V,2)-1,1,n);
% sum_i=repmat(sum(V,1)-1,n,1);
% V_temp=V(:,2:n);
% V_temp=[V_temp V(:,1)];
% sum_d=d*V_temp;
% du=-A*sum_x-A*sum_i-D*sum_d;
% %==========================================
% function E=energy(V,d)
% global A D
% n=size(V,1);
% sum_x=sumsqr(sum(V,2)-1);
% sum_i=sumsqr(sum(V,1)-1);
% V_temp=V(:,2:n);
% V_temp=[V_temp V(:,1)];
% sum_d=d*V_temp;
% sum_d=sum(sum(V.*sum_d));
% E=0.5*(A*sum_x+A*sum_i+D*sum_d);
