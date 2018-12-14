function [w1,w2] = lvq2_train(P,Tc,Num_Compet,lr,maxiter,w1,w2)
%% ��������
n = size(P,2);
for k = 1:maxiter
    for i = 1:n
        % ���������������Ԫ�뵱ǰ���������ľ���
        d = zeros(Num_Compet,1);
        for j = 1:Num_Compet
            d(j) = sqrt(sse(w1(j,:)'-P(:,i)));
        end
        % Ѱ���뵱ǰ��������������С�ľ�������Ԫ��ţ���Ϊindex1
        [min_d1,index1] = min(d);
        % ������index1�����ӵ������Ԫ��Ӧ�����
        a1_1 = compet(-1*d);
        n2_1 = purelin(w2*a1_1);
        a2_1 = vec2ind(n2_1);
        % Ѱ���뵱ǰ�������������С�ľ�������Ԫ��ţ���Ϊindex2
        d(index1) = inf;
        [min_d2,index2] = min(d);
        % ������index2�����ӵ������Ԫ��Ӧ�����
        a1_2 = compet(-1*d);
        n2_2 = purelin(w2*a1_2);
        a2_2 = vec2ind(n2_2);
        % �ж�������������Ԫ��Ӧ������Ƿ����
        flag1 = isequal(a2_1,a2_2);
        flag2 = min_d1/min_d2 > 0.6;
        if ~flag1 && flag2
            if isequal(Tc(i),a2_1)
                w1(index1,:) = w1(index1,:) + lr*(P(:,i)'-w1(index1,:));
                w1(index2,:) = w1(index2,:) - lr*(P(:,i)'-w1(index2,:));
            else
                w1(index1,:) = w1(index1,:) - lr*(P(:,i)'-w1(index1,:));
                w1(index2,:) = w1(index2,:) + lr*(P(:,i)'-w1(index2,:));
            end 
        else
            w1(index1,:) = w1(index1,:) + lr*(P(:,i)'-w1(index1,:));
        end
    end
end