x = xlsread('E:\machine_learning\Machine-Learning-ZhouZhiHua\9.4\watermelon4.0.xlsx', 'Sheet1', 'A1:B30');
[m,n]=size(x);    %m��ʾ�С�n��ʾ��
k=4;%����kֵ,��Ҫ����ĸ���
u=x(randperm(m,k),:);  %�����ֵ
while 1
  c=zeros(k,30);    %�����༯�����
  nums=zeros(k,1);  
  %����������������ѡ������ļ���
  for i=1:m
    mind=100000;   %�����̵ľ���
    minl=0;        %x������
    for j=1:k 
      d=norm(x(i,:)-u(j,:));   %��������x������ֵ�����ľ���
      if(d<mind)
      mind=d;
      minl=j;
      end
     end
     nums(minl)=nums(minl)+1;   %��Ӧ��ľ������
     c(minl,nums(minl))=i;      %
   end
   %�������ξ�ֵ���죬�����¾�ֵ
   up=zeros(k,2);
   for i=1:k
     for j=1:nums(i)
       up(i,:)=up(i,:)+x(c(i,j),:);
      end
      up(i,:)=up(i,:)/nums(i);
   end
   %��������������
   delta_u=norm(up-u);
   if(delta_u<0.001)
      break;
    else
       u=up;
   end
end

%����ʹ�ò�ͬ�ķ��Ż���
ch='o*+.>';

for i=1:k
  %�������еĵ�
  plot(x(c(i,1:nums(i)),1),x(c(i,1:nums(i)),2),ch(i));
  hold on;
  tc=x(c(i,1:nums(i)),:);       %ͬ��������������
  %������͹��������
  chl=convhull(tc(:,1),tc(:,2));   %Octave��convhull(x,y)��������������
  %��Matlab��ʹ��
  %chl=convhull(tc);
  line(tc(chl,1),tc(chl,2))
  hold on;
end

xlabel('�ܶ�');
ylabel('������');
title('K-means'); 
      
     