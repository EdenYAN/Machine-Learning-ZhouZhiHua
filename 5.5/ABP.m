clear

x = xlsread('E:\machine_learning\BP\watermelon3.0.xlsx', 'Sheet1', 'A1:Q8');
y = xlsread('E:\machine_learning\BP\watermelon3.0.xlsx', 'Sheet1', 'A9:Q9');
x=x';     %x����ת�� 
y=y';     %y����ת��
%��y����Ϊ0,1����
y=y-1;
%��ȡ����������������������
[m,d]=size(x);    %m��x�������������ʾ�ܹ��ж��ٸ�ѵ������d�Ǿ������������ʾѵ���������롣

OutputLayerNum=1;  %�������Ԫ

v=rand(d,d+1);                      %������������Ȩֵ,v��һ��d��d+1�о���
w=rand(d+1,OutputLayerNum);         %������������Ȩֵ,w��һ��d+1��1�о���
gamma=rand(d+1);                    %������ֵ,gamma��d+1��1�о���
theta=rand(OutputLayerNum);         %�������ֵ,theta��1��1�о���
py=zeros(m,OutputLayerNum);         %��������
b=zeros(d+1);                       %�������
g=zeros(OutputLayerNum);            %��������w,gamma�󵼵Ĳ���
e=zeros(d+1);                       %��������v,theta�󵼵Ĳ���

eta=1;                               %ѧϰ��

kn=0;        %�����Ĵ���
sn=0;        %ͬ���ľ������ֵ�ۻ�����
previous_E=0; %ǰһ�ε������ۼ����
while(1)
    kn=kn+1;
    E=0;      %��ǰ�����ľ������
    %����ȫ��������������
    for i=1:m
      %������������
      for j=1:d+1
        alpha=0;
        for k=1:d
          alpha=alpha+v(k,j)*x(i,k);
        end
        b(i,j)=1/(1+exp(-alpha+gamma(j)));
       end
       %������������
       for j=1:OutputLayerNum
         beta=0;
         for k=1:d+1
           beta=beta+w(k,j)*b(i,k);
          end
          py(i,j)=1/(1+exp(-beta+theta(j)));
         end
        end
       %�����洢�ۻ������ĸ��������½�����
       delta_v=zeros(d,d+1);
       delta_w=zeros(d+1,OutputLayerNum);
       delta_gamma=zeros(d+1);
       delta_theta=zeros(OutputLayerNum);
       %�����ۻ����
       for i=1:m
         for j=1:OutputLayerNum
           E=E+((y(i)-py(i,j))^2)/2;
          end
          %����w��theta��������
          for j=1:OutputLayerNum
            g(j)=py(i,j)*(1-py(i,j))*(y(i)-py(i,j));
          end
          %����v��gamma��������
          for j=1:d+1
            teh=0;
            for k=1:OutputLayerNum
              teh=teh+w(j,k)*g(k);
            end
              e(j)=teh*b(i,j)*(1-b(i,j));
          end
          %����w��theta����
          for j=1:OutputLayerNum
            delta_theta=delta_theta+(-1)*eta*g(j);
            for k=1:d+1
              delta_w(k,j)=delta_w(k,j)+eta*g(j)*b(i,k);
            end
          end
          %����v��gamma����
          for j=1:d+1
            gamma(j)= gamma(j)+(-1)*eta*e(j);
            for k=1:d
              delta_v(k,j)=delta_v(k,j)+eta*e(j)*x(i,k);
            end
           end
          end
          %���²���
          v=v+delta_v;
          w=w+delta_w;
         gamma=gamma+delta_gamma;
         theta=theta+delta_theta;
         %������ֹ����
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