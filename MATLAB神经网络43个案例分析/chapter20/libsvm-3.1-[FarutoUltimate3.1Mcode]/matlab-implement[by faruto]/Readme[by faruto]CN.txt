SVM faruto version
by faruto
Email:farutoliyang@gmail.com
2009.11.05
==================================
Content:

scaleForSVM:��һ��
�����ӿ�:
[train_scale,test_scale,ps] = scaleForSVM(train_data,test_data,ymin,ymax)
====================================
pcaForSVM:pca��άԤ����
�����ӿ�:
[train_pca,test_pca] = pcaForSVM(train,test,threshold)
====================================
fasticaForSVM:ica��άԤ����
�����ӿ�:
[train_ica,test_ica] = fasticaForSVM(train,test)
====================================
SVMcgForClass:�����������Ѱ��[grid search based on CV]
�����ӿ�:
[bestacc,bestc,bestg] = SVMcgForClass(train_label,train,cmin,cmax,gmin,gmax,v,cstep,gstep,accstep)

SVMcgForRegress:�ع��������Ѱ��[grid search based on CV]
�����ӿ�:
[mse,bestc,bestg] = SVMcgForRegress(train_label,train,cmin,cmax,gmin,gmax,v,cstep,gstep,msestep)
======================================
psoSVMcgForClass:�����������Ѱ��[pso based on CV]
�����ӿ�:
[bestCVaccuracy,bestc,bestg,pso_option] = psoSVMcgForClass(train_label,train,pso_option)

psoSVMcgForRegress:�ع��������Ѱ��[pso based on CV]
�����ӿ�:
[bestCVmse,bestc,bestg,pso_option] = psoSVMcgForRegress(train_label,train,pso_option)
=======================================
gaSVMcgForClass:�����������Ѱ��[ga based on CV]
�����ӿ�:
[bestCVaccuracy,bestc,bestg,ga_option] = gaSVMcgForClass(train_label,train,ga_option)

gaSVMcgForRegress:�ع��������Ѱ��[ga based on CV]
�����ӿ�:
[bestCVmse,bestc,bestg,ga_option] = gaSVMcgForRegress(train_label,train,ga_option)
======================================








