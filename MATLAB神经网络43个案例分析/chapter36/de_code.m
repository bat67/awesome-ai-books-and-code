function Val = de_code(x)
% ȫ�ֱ�������
global S P_train T_train P_test T_test mint maxt 
global p t r s s1 s2
% ������ȡ
x = x(:,1:S);
[m,n] = find(x == 1);
p_train = zeros(size(n,2),size(T_train,2));
p_test = zeros(size(n,2),size(T_test,2));
for i = 1:length(n)
    p_train(i,:) = P_train(n(i),:);
    p_test(i,:) = P_test(n(i),:);
end
t_train = T_train;
p = p_train;
t = t_train;
% �Ŵ��㷨�Ż�BP����Ȩֵ����ֵ
r = size(p,1);
s2 = size(t,1);
s = r*s1 + s1*s2 + s1 + s2;
aa = ones(s,1)*[-1,1];
popu = 20;  % ��Ⱥ��ģ
initPpp = initializega(popu,aa,'gabpEval');  % ��ʼ����Ⱥ
gen = 100;  % �Ŵ�����
% ����GAOT�����䣬����Ŀ�꺯������ΪgabpEval
x = ga(aa,'gabpEval',[],initPpp,[1e-6 1 0],'maxGenTerm',gen,...
'normGeomSelect',0.09,'arithXover',2,'nonUnifMutation',[2 gen 3]);
% ����BP����
net = newff(minmax(p_train),[s1,1],{'tansig','purelin'},'trainlm');
% ���Ż��õ���Ȩֵ����ֵ��ֵ��BP����
[W1,B1,W2,B2] = gadecod(x);
net.IW{1,1} = W1;
net.LW{2,1} = W2;
net.b{1} = B1;
net.b{2} = B2;
% ����ѵ������
net.trainParam.epochs = 1000;
net.trainParam.show = 10;
net.trainParam.goal = 0.1;
net.trainParam.lr = 0.1;
net.trainParam.showwindow = 0;
% ѵ������
net = train(net,p_train,t_train);
% �������
tn_sim = sim(net,p_test);
% ����һ��
t_sim = postmnmx(tn_sim,mint,maxt);
% ����������
SE = sse(t_sim - T_test);
% ������Ӧ�Ⱥ���ֵ
Val = 1/SE;
end
