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
    for i=1:m
      %�����������
      for j=1:d+1
        alpha=0;   %��ǰһ������ڵ���Ԫ������
        for k=1:d
          alpha=alpha+v(k,j)*x(i,k);
         end
         b(j)=1/(1+exp(alpha-gamma(j)));  %����ĳ������ڵ�����
       end
       %������������
       for j=1:OutputLayerNum
         beta=0;
         for k=1:d+1
           beta=beta+w(k,j)*b(k);
         end
         py(i,j)=1/(1+exp(beta-theta));
        end
        %���㵱ǰһ��ѵ�����ݵľ������
        for j=1:OutputLayerNum
          E=E+((py(i,j)-y(i))^2)/2;
        end
        %����w,beta��������
        for j=1:OutputLayerNum
          g(j)=py(i,j)*(1-py(i,j))*(y(i)-py(i,j));
        end
        %����v,gamma��������
        for j=1:d+1
          teh=0;
          for k=1:OutputLayerNum
            teh=teh+w(j,k)*g(k);
          end
          e(j)=teh*b(j)*(1-b(j));
         end
         %����v,gamma
         for j=1:d+1
           gamma(j)=gamma(j)+(-eta)*e(j);
           for k=1:d
             v(k,j)=v(k,j)+eta*e(j)*x(i,k);
            end
           end
          %����w,theta
          for j=1:OutputLayerNum
            theta(j)=theta(j)+(-eta)*g(j);
            for k=1:d+1
              w(k,j)=w(k,j)+eta*g(j)*b(k);
             end
           end
         end
         %������ֹ�ж�
         if(abs(previous_E-E)<0.0001)
            sn=sn+1;
            if(sn==100)
               break;
             end
          else
             previous_E=E;
             sn=0;
         end
 end
          
          
        
          
         
           
          
      