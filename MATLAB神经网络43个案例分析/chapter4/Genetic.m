
%% �ô���Ϊ�����������Ŵ��㷨��ϵͳ��ֵѰ��
%% ��ջ�������
clc
clear

%% ��ʼ���Ŵ��㷨����
%��ʼ������
maxgen=100;                         %��������������������
sizepop=20;                        %��Ⱥ��ģ
pcross=[0.4];                       %�������ѡ��0��1֮��
pmutation=[0.2];                    %�������ѡ��0��1֮��

lenchrom=[1 1];          %ÿ���������ִ����ȣ�����Ǹ���������򳤶ȶ�Ϊ1
bound=[-5 5;-5 5];  %���ݷ�Χ


individuals=struct('fitness',zeros(1,sizepop), 'chrom',[]);  %����Ⱥ��Ϣ����Ϊһ���ṹ��
avgfitness=[];                      %ÿһ����Ⱥ��ƽ����Ӧ��
bestfitness=[];                     %ÿһ����Ⱥ�������Ӧ��
bestchrom=[];                       %��Ӧ����õ�Ⱦɫ��

%% ��ʼ����Ⱥ������Ӧ��ֵ
% ��ʼ����Ⱥ
for i=1:sizepop
    %�������һ����Ⱥ
    individuals.chrom(i,:)=Code(lenchrom,bound);   
    x=individuals.chrom(i,:);
    %������Ӧ��
    individuals.fitness(i)=fun(x);   %Ⱦɫ�����Ӧ��
end
%����õ�Ⱦɫ��
[bestfitness bestindex]=min(individuals.fitness);
bestchrom=individuals.chrom(bestindex,:);  %��õ�Ⱦɫ��
avgfitness=sum(individuals.fitness)/sizepop; %Ⱦɫ���ƽ����Ӧ��
% ��¼ÿһ����������õ���Ӧ�Ⱥ�ƽ����Ӧ��
trace=[avgfitness bestfitness]; 

%% ����Ѱ��
% ������ʼ
for i=1:maxgen
    i
    % ѡ��
    individuals=Select(individuals,sizepop); 
    avgfitness=sum(individuals.fitness)/sizepop;
    %����
    individuals.chrom=Cross(pcross,lenchrom,individuals.chrom,sizepop,bound);
    % ����
    individuals.chrom=Mutation(pmutation,lenchrom,individuals.chrom,sizepop,[i maxgen],bound);
    
    % ������Ӧ�� 
    for j=1:sizepop
        x=individuals.chrom(j,:); %����
        individuals.fitness(j)=fun(x);   
    end
    
  %�ҵ���С�������Ӧ�ȵ�Ⱦɫ�弰��������Ⱥ�е�λ��
    [newbestfitness,newbestindex]=min(individuals.fitness);
    [worestfitness,worestindex]=max(individuals.fitness);
    % ������һ�ν�������õ�Ⱦɫ��
    if bestfitness>newbestfitness
        bestfitness=newbestfitness;
        bestchrom=individuals.chrom(newbestindex,:);
    end
    individuals.chrom(worestindex,:)=bestchrom;
    individuals.fitness(worestindex)=bestfitness;
    
    avgfitness=sum(individuals.fitness)/sizepop;
    
    trace=[trace;avgfitness bestfitness]; %��¼ÿһ����������õ���Ӧ�Ⱥ�ƽ����Ӧ��
end
%��������

%% �������
[r c]=size(trace);
plot([1:r]',trace(:,2),'r-');
title('��Ӧ������','fontsize',12);
xlabel('��������','fontsize',12);ylabel('��Ӧ��','fontsize',12);
axis([0,100,0,1])
disp('��Ӧ��                   ����');
x=bestchrom;
% ������ʾ
disp([bestfitness x]);

web browser www.matlabsky.com