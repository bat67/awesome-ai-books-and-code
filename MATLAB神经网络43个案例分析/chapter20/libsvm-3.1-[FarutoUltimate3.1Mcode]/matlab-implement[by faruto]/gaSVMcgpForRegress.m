function [BestMSE,Bestc,Bestg,Bestp,ga_option] = gaSVMcgpForRegress(train_label,train_data,ga_option)
% gaSVMcgForClass
%
% by faruto
%Email:patrick.lee@foxmail.com QQ:516667408 http://blog.sina.com.cn/faruto
%last modified 2011.06.08
% ��ת����ע����
% faruto and liyang , LIBSVM-farutoUltimateVersion 
% a toolbox with implements for support vector machines based on libsvm, 2011. 
% Software available at http://www.matlabsky.com
% 
% Chih-Chung Chang and Chih-Jen Lin, LIBSVM : a library for
% support vector machines, 2001. Software available at
% http://www.csie.ntu.edu.tw/~cjlin/libsvm
%% ������ʼ��
if nargin == 2
    ga_option = struct('maxgen',200,'sizepop',20,'ggap',0.9,...
        'cbound',[0,100],'gbound',[0,1000],'pbound',[0.01,1],'v',5);
end
% maxgen:���Ľ�������,Ĭ��Ϊ200,һ��ȡֵ��ΧΪ[100,500]
% sizepop:��Ⱥ�������,Ĭ��Ϊ20,һ��ȡֵ��ΧΪ[20,100]
% cbound = [cmin,cmax],����c�ı仯��Χ,Ĭ��Ϊ(0,100]
% gbound = [gmin,gmax],����g�ı仯��Χ,Ĭ��Ϊ[0,1000]
% pbound = [pmin,pmax],����p�ı仯��Χ,Ĭ��Ϊ[0,1]
% v:SVM Cross Validation����,Ĭ��Ϊ5

%%
MAXGEN = ga_option.maxgen;
NIND = ga_option.sizepop;
NVAR = 3;
PRECI = 20;
GGAP = ga_option.ggap;
trace = zeros(MAXGEN,2);

FieldID = ...
[rep([PRECI],[1,NVAR]); ...
[ga_option.cbound(1),ga_option.gbound(1),ga_option.pbound(1);ga_option.cbound(2),ga_option.gbound(2),ga_option.pbound(2);];...
[1,1,1;0,0,0;0,1,1;1,1,1]];

Chrom = crtbp(NIND,NVAR*PRECI);

gen = 1;
v = ga_option.v;
BestMSE = inf;
Bestc = 0;
Bestg = 0;
Bestp = 0;
%%
cg = bs2rv(Chrom,FieldID);

for nind = 1:NIND
    cmd = ['-v ',num2str(v),' -c ',num2str(cg(nind,1)),' -g ',num2str(cg(nind,2)),' -p ',num2str(cg(nind,3)),' -s 3'];
    ObjV(nind,1) = svmtrain(train_label,train_data,cmd);
end
[BestMSE,I] = min(ObjV);
Bestc = cg(I,1);
Bestg = cg(I,2);
Bestp = cg(I,3);

%%
while 1  
    FitnV = ranking(ObjV);
    
    SelCh = select('sus',Chrom,FitnV,GGAP);
    SelCh = recombin('xovsp',SelCh,0.7);
    SelCh = mut(SelCh);
    
    cg = bs2rv(SelCh,FieldID);
    for nind = 1:size(SelCh,1)
        cmd = ['-v ',num2str(v),' -c ',num2str(cg(nind,1)),' -g ',num2str(cg(nind,2)),' -p ',num2str(cg(nind,3)),' -s 3'];
        ObjVSel(nind,1) = svmtrain(train_label,train_data,cmd);
    end
    
    [Chrom,ObjV] = reins(Chrom,SelCh,1,1,ObjV,ObjVSel);   
    
    [NewBestCVaccuracy,I] = min(ObjV);
    cg_temp = bs2rv(Chrom,FieldID);
    temp_NewBestCVaccuracy = NewBestCVaccuracy;
    
    if NewBestCVaccuracy < BestMSE
       BestMSE = NewBestCVaccuracy;
       Bestc = cg_temp(I,1);
       Bestg = cg_temp(I,2);
       Bestp = cg_temp(I,3);
    end
    
    if abs( NewBestCVaccuracy-BestMSE ) <= 10^(-4) && ...
        cg_temp(I,1) < Bestc
       BestMSE = NewBestCVaccuracy;
       Bestc = cg_temp(I,1);
       Bestg = cg_temp(I,2);
       Bestp = cg_temp(I,3);
    end    
    
    trace(gen,1) = min(ObjV);
    trace(gen,2) = sum(ObjV)/length(ObjV);
    
%     if gen >= MAXGEN/2 && ...
%        ( temp_NewBestCVaccuracy-BestMSE ) <= 10^(-4)
%         break;
%     end
    if gen == MAXGEN
        break;
    end
    gen = gen + 1;
end

%%
figure;
hold on;
trace = round(trace*10000)/10000;
plot(trace(1:gen,1),'r*-','LineWidth',1.5);
plot(trace(1:gen,2),'o-','LineWidth',1.5);
legend('�����Ӧ��','ƽ����Ӧ��');
xlabel('��������','FontSize',12);
ylabel('��Ӧ��','FontSize',12);
grid on;
axis auto;

line1 = '��Ӧ������MSE[GAmethod]';
line2 = ['��ֹ����=', ...
    num2str(gen),',��Ⱥ����pop=', ...
    num2str(NIND),')'];
line3 = ['Best c=',num2str(Bestc),' g=',num2str(Bestg),' p=',num2str(Bestp), ...
    ' MSE=',num2str(BestMSE)];
title({line1;line2;line3},'FontSize',12);
