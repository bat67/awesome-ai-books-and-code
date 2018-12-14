%% ˼ά�����㷨Ӧ�����Ż�BP������ĳ�ʼȨֵ����ֵ

%% ��ջ�������
clear all
clc
warning off

%% ��������
load data.mat
% �������ѵ���������Լ�
k = randperm(size(input,1));
N = 1900;
% ѵ��������1900������
P_train=input(k(1:N),:)';
T_train=output(k(1:N));
% ���Լ�����100������
P_test=input(k(N+1:end),:)';
T_test=output(k(N+1:end));

%% ��һ��
% ѵ����
[Pn_train,inputps] = mapminmax(P_train);
Pn_test = mapminmax('apply',P_test,inputps);
% ���Լ�
[Tn_train,outputps] = mapminmax(T_train);
Tn_test = mapminmax('apply',T_test,outputps);

%% ��������
popsize = 200;                      % ��Ⱥ��С
bestsize = 5;                       % ��ʤ����Ⱥ����
tempsize = 5;                       % ��ʱ����Ⱥ����
SG = popsize / (bestsize+tempsize); % ��Ⱥ���С
S1 = size(Pn_train,1);              % �������Ԫ����
S2 = 5;                            % ��������Ԫ����
S3 = size(Tn_train,1);              % �������Ԫ����
iter = 10;                          % ��������

%% ���������ʼ��Ⱥ
initpop = initpop_generate(popsize,S1,S2,S3,Pn_train,Tn_train);

%% ������ʤ��Ⱥ�����ʱ��Ⱥ��
% �÷�����
[sort_val,index_val] = sort(initpop(:,end),'descend');
% ������ʤ����Ⱥ����ʱ����Ⱥ������
bestcenter = initpop(index_val(1:bestsize),:);
tempcenter = initpop(index_val(bestsize+1:bestsize+tempsize),:);
% ������ʤ����Ⱥ
bestpop = cell(bestsize,1);
for i = 1:bestsize
    center = bestcenter(i,:);
    bestpop{i} = subpop_generate(center,SG,S1,S2,S3,Pn_train,Tn_train);
end
% ������ʱ����Ⱥ
temppop = cell(tempsize,1);
for i = 1:tempsize
    center = tempcenter(i,:);
    temppop{i} = subpop_generate(center,SG,S1,S2,S3,Pn_train,Tn_train);
end

while iter > 0
    %% ��ʤ��Ⱥ����ͬ�������������Ⱥ��÷�
    best_score = zeros(1,bestsize);
    best_mature = cell(bestsize,1);
    for i = 1:bestsize
        best_mature{i} = bestpop{i}(1,:);
        best_flag = 0;                % ��ʤ��Ⱥ������־(1��ʾ���죬0��ʾδ����)
        while best_flag == 0
            % �ж���ʤ��Ⱥ���Ƿ����
            [best_flag,best_index] = ismature(bestpop{i});
            % ����ʤ��Ⱥ����δ���죬�����µ����Ĳ�������Ⱥ
            if best_flag == 0
                best_newcenter = bestpop{i}(best_index,:);
                best_mature{i} = [best_mature{i};best_newcenter];
                bestpop{i} = subpop_generate(best_newcenter,SG,S1,S2,S3,Pn_train,Tn_train);
            end
        end
        % ���������ʤ��Ⱥ��ĵ÷�
        best_score(i) = max(bestpop{i}(:,end));
    end
    % ��ͼ(��ʤ��Ⱥ����ͬ����)
    figure
    temp_x = 1:length(best_mature{1}(:,end))+5;
    temp_y = [best_mature{1}(:,end);repmat(best_mature{1}(end),5,1)];
    plot(temp_x,temp_y,'b-o')
    hold on
    temp_x = 1:length(best_mature{2}(:,end))+5;
    temp_y = [best_mature{2}(:,end);repmat(best_mature{2}(end),5,1)];
    plot(temp_x,temp_y,'r-^')
    hold on
    temp_x = 1:length(best_mature{3}(:,end))+5;
    temp_y = [best_mature{3}(:,end);repmat(best_mature{3}(end),5,1)];
    plot(temp_x,temp_y,'k-s')
    hold on
    temp_x = 1:length(best_mature{4}(:,end))+5;
    temp_y = [best_mature{4}(:,end);repmat(best_mature{4}(end),5,1)];
    plot(temp_x,temp_y,'g-d')
    hold on
    temp_x = 1:length(best_mature{5}(:,end))+5;
    temp_y = [best_mature{5}(:,end);repmat(best_mature{5}(end),5,1)];
    plot(temp_x,temp_y,'m-*')
    legend('����Ⱥ1','����Ⱥ2','����Ⱥ3','����Ⱥ4','����Ⱥ5')
    xlim([1 10])
    xlabel('��ͬ����')
    ylabel('�÷�')
    title('��ʤ����Ⱥ��ͬ����')
    
    %% ��ʱ��Ⱥ����ͬ�������������Ⱥ��÷�
    temp_score = zeros(1,tempsize);
    temp_mature = cell(tempsize,1);
    for i = 1:tempsize
        temp_mature{i} = temppop{i}(1,:);
        temp_flag = 0;                % ��ʱ��Ⱥ������־(1��ʾ���죬0��ʾδ����)
        while temp_flag == 0
            % �ж���ʱ��Ⱥ���Ƿ����
            [temp_flag,temp_index] = ismature(temppop{i});
            % ����ʱ��Ⱥ����δ���죬�����µ����Ĳ�������Ⱥ
            if temp_flag == 0
                temp_newcenter = temppop{i}(temp_index,:);
                temp_mature{i} = [temp_mature{i};temp_newcenter];
                temppop{i} = subpop_generate(temp_newcenter,SG,S1,S2,S3,Pn_train,Tn_train);
            end
        end
        % ���������ʱ��Ⱥ��ĵ÷�
        temp_score(i) = max(temppop{i}(:,end));
    end
     % ��ͼ(��ʱ��Ⱥ����ͬ����)
    figure
    temp_x = 1:length(temp_mature{1}(:,end))+5;
    temp_y = [temp_mature{1}(:,end);repmat(temp_mature{1}(end),5,1)];
    plot(temp_x,temp_y,'b-o')
    hold on
    temp_x = 1:length(temp_mature{2}(:,end))+5;
    temp_y = [temp_mature{2}(:,end);repmat(temp_mature{2}(end),5,1)];
    plot(temp_x,temp_y,'r-^')
    hold on
    temp_x = 1:length(temp_mature{3}(:,end))+5;
    temp_y = [temp_mature{3}(:,end);repmat(temp_mature{3}(end),5,1)];
    plot(temp_x,temp_y,'k-s')
    hold on
    temp_x = 1:length(temp_mature{4}(:,end))+5;
    temp_y = [temp_mature{4}(:,end);repmat(temp_mature{4}(end),5,1)];
    plot(temp_x,temp_y,'g-d')
    hold on
    temp_x = 1:length(temp_mature{5}(:,end))+5;
    temp_y = [temp_mature{5}(:,end);repmat(temp_mature{5}(end),5,1)];
    plot(temp_x,temp_y,'m-*')
    legend('����Ⱥ1','����Ⱥ2','����Ⱥ3','����Ⱥ4','����Ⱥ5')
    xlim([1 10])
    xlabel('��ͬ����')
    ylabel('�÷�')
    title('��ʱ����Ⱥ��ͬ����')
    
    %% �컯����
    [score_all,index] = sort([best_score temp_score],'descend');
    % Ѱ����ʱ��Ⱥ��÷ָ�����ʤ��Ⱥ��ı��
    rep_temp = index(find(index(1:bestsize) > bestsize)) - bestsize;
    % Ѱ����ʤ��Ⱥ��÷ֵ�����ʱ��Ⱥ��ı��
    rep_best = index(find(index(bestsize+1:end) < bestsize+1) + bestsize);
    
    % �������滻����
    if ~isempty(rep_temp)
        % �÷ָߵ���ʱ��Ⱥ���滻��ʤ��Ⱥ��
        for i = 1:length(rep_best)
            bestpop{rep_best(i)} = temppop{rep_temp(i)};
        end
        % ������ʱ��Ⱥ�壬�Ա�֤��ʱ��Ⱥ��ĸ�������
        for i = 1:length(rep_temp)
            temppop{rep_temp(i)} = initpop_generate(SG,S1,S2,S3,Pn_train,Tn_train);
        end
    else
        break;
    end
    
    %% �����ǰ������õ���Ѹ��弰��÷�
    if index(1) < 6
        best_individual = bestpop{index(1)}(1,:);
    else
        best_individual = temppop{index(1) - 5}(1,:);
    end

    iter = iter - 1;
    
end

%% �������Ÿ���
x = best_individual;

% ǰS1*S2������ΪW1
temp = x(1:S1*S2);
W1 = reshape(temp,S2,S1);

% ���ŵ�S2*S3������ΪW2
temp = x(S1*S2+1:S1*S2+S2*S3);
W2 = reshape(temp,S3,S2);

% ���ŵ�S2������ΪB1
temp = x(S1*S2+S2*S3+1:S1*S2+S2*S3+S2);
B1 = reshape(temp,S2,1);

%���ŵ�S3������B2
temp = x(S1*S2+S2*S3+S2+1:end-1);
B2 = reshape(temp,S3,1);

% E_optimized = zeros(1,100);
% for i = 1:100
%% ����/ѵ��BP������
net_optimized = newff(Pn_train,Tn_train,S2);
% ����ѵ������
net_optimized.trainParam.epochs = 100;
net_optimized.trainParam.show = 10;
net_optimized.trainParam.goal = 1e-4;
net_optimized.trainParam.lr = 0.1;
% ���������ʼȨֵ����ֵ
net_optimized.IW{1,1} = W1;
net_optimized.LW{2,1} = W2;
net_optimized.b{1} = B1;
net_optimized.b{2} = B2;
% �����µ�Ȩֵ����ֵ����ѵ��
net_optimized = train(net_optimized,Pn_train,Tn_train);

%% �������
Tn_sim_optimized = sim(net_optimized,Pn_test);     
% ����һ��
T_sim_optimized = mapminmax('reverse',Tn_sim_optimized,outputps);

%% ����Ա�
result_optimized = [T_test' T_sim_optimized'];
% �������
E_optimized = mse(T_sim_optimized - T_test)
% end
%% δ�Ż���BP������
% E = zeros(1,100);
% for i = 1:100
net = newff(Pn_train,Tn_train,S2);
% ����ѵ������
net.trainParam.epochs = 100;
net.trainParam.show = 10;
net.trainParam.goal = 1e-4;
net.trainParam.lr = 0.1;
% �����µ�Ȩֵ����ֵ����ѵ��
net = train(net,Pn_train,Tn_train);

%% �������
Tn_sim = sim(net,Pn_test);    
% ����һ��
T_sim = mapminmax('reverse',Tn_sim,outputps);

%% ����Ա�
result = [T_test' T_sim'];
% �������
E = mse(T_sim - T_test)

% end

