clear
x=[0 0;0 1; 1 0;1 1];
y=[0;1;1;0];

hideNum=10;               %������Ԫ��Ŀ��Ҫ����������������
rho=rand(4,hideNum);       %�����������ֵ
py=rand(4,1);             %���ֵ
w=rand(1,hideNum);        %�����i����Ԫ�������Ԫ��Ȩֵ
beta=rand(1,hideNum);     %�������i����Ԫ�����ĵľ��������ϵ��
eta=0.5;                    %ѧϰ��

c=rand(hideNum,2);     %�����i����Ԫ������

kn=0;                 %�ۼƵ����Ĵ���
sn=0;                 %ͬ�����ۻ����ֵ�ۻ�����
previous_E=0;          %ǰһ�ε������ۻ����

while(1)
  kn=kn+1;
  E=0;
  %����ÿ�������ľ��������ֵ
  for i=1:4
    for j=1:hideNum
      p(i,j)=exp(-beta(j)*(x(i,:)-c(j,:))*(x(i,:)-c(j,:))');
     end
     py(i)=w*p(i,:)'; 
   end
   %�����ۻ����
   for i=1:4
     E=E+((py(i)-y(i))^2);    %����������
   end
     E=E/2;    %�ۻ����
   
   %����w��beta
   delta_w=zeros(1,hideNum);
   delta_beta=zeros(1,hideNum);
   for i=1:4
     for j=1:hideNum
       delta_w(j)=delta_w(j)+(py(i)-y(i))*p(i,j);
       delta_beta(j)= delta_beta(j)-(py(i)-y(i))*w(j)*(x(i,:)-c(j,:))*(x(i,:)-c(j,:))'*p(i,j);
      end
     end
     
    %����w��beta
    w=w-eta*delta_w/4;
    beta=beta-eta*delta_beta/4;
    
    %������ֹ������
    if(abs(previous_E-E)<0.0001)
       sn=sn+1;
       if(sn==50)
         break;
        end
     else
       previous_E=E;
       sn=0;
      end
      
 end
       
      
      