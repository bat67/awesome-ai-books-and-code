%% SOM����������ݷ���--���ͻ��������
% 
% 
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">�ð�������������</font></b></td>	</tr>	<tr>		<td><span class="comment"><font size="2">1�����˳���פ���ڴ�<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html"><font color="#0000FF">���</font></a>���<a target="_blank" href="http://www.ilovematlab.cn/thread-48362-1-1.html"><font color="#0000FF">�ð���</font></a>���ʣ��������ʱش�</font></span></td></tr><tr>	<td><span class="comment"><font size="2">2���˰��������׵Ľ�ѧ��Ƶ�����׵�����������Matlab����</font></span></td>	</tr>	<tr>		<td><span class="comment"><font size="2">		3����������Ϊ�ð����Ĳ������ݣ�Լռ�ð����������ݵ�1/10����</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		4���˰���Ϊԭ��������ת����ע��������<a target="_blank" href="http://www.ilovematlab.cn/">Matlab������̳</a>��<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html">��Matlab������30������������</a>����</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		5�����˰��������������о��й��������ǻ�ӭ���������Ҫ��ȣ����ǿ��Ǻ���Լ��ڰ����</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		6������������������Ϊ���壬�鼮��ʵ�����ݿ�����������룬���鼮ʵ�ʷ�������Ϊ׼��</font></span></td>	</tr><tr>		<td><span class="comment"><font size="2">		7�����������������⡢Ԥ����ʽ�ȣ�<a target="_blank" href="http://www.ilovematlab.cn/thread-47939-1-1.html">��������</a>��</font></span></td>	</tr></table>
% </html>
% 


%% SOM�ṹ����

%%
plotsom(pos)

%% �ṹ
% �����ṹ����
pos = gridtop(2,3)

pos = gridtop(3,2)

pos = gridtop(8,10);


% ���ǽṹ����
pos = hextop(2,3)

pos = hextop(8,10);

% �����ṹ����
pos = randtop(2,3)

pos = randtop(8,10);

%% �� ��
% boxdist()

% Box���롣�ڸ���������ĳ����Ԫ��λ�ú󣬿������øú���������Ԫ֮��ľ��롣�ú���ͨ�����ڽṹ������gridtop��������㡣
pos=gridtop(2,2)
plotsom(pos)
boxdist(pos)

% dist ŷʽ���뺯��
dist(pos)

% linkdist ���� ���Ӿ��뺯����
linkdist(pos)

% mandist ���� Manhattan����Ȩ����
mandist(pos) 


web browser http://www.ilovematlab.cn/viewthread.php?tid=65106


%%
% 
% <html>
% <table align="center" >	<tr>		<td align="center"><font size="2">��Ȩ���У�</font><a
% href="http://www.ilovematlab.cn/">Matlab������̳</a>&nbsp;&nbsp; <script
% src="http://s3.cnzz.com/stat.php?id=971931&web_id=971931&show=pic" language="JavaScript" ></script>&nbsp;</td>	</tr></table>
% </html>
% 



