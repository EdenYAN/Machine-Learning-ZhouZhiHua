%{
    parent:���ڵ���
    curset:��ǰ��������ż���
    pf:��ǰ�����Ա�ż���
    pu������������������ɢ�� 0-��ɢ 1-����
    pt�����Զ�Ӧ�ķ����������������ò���(������Ϊ0)
%}
function TreeGenerate(parent,curset,pf,pu,pt)
global x y xigua fenlei1 fenlei; 
global tree treeleaf treeres ptr;
       %����һ���ڵ㣬����¼���ĸ��ڵ�
       ptr=ptr+1;
       tree(ptr)=parent;
       cur = ptr;

       %�ݹ鷵�����1:��ǰ������������ͬһ��
       n = size(curset); 
       n = n(2);

       %���㵱ǰy��ȡֵ���༰���ж��ٸ�  ���ֻ��һ���ʾ����ͬһ��
       cury=y(curset);  %ͨ����ǰ������Ŵ�����������ѡ����ǰ����
       y_data=unique(cury); %����ȥ��
       y_nums=histc(cury,y_data);   %ͳ�Ƹ���ȡֵ�����ٸ�

       if(y_nums(1)==n)
            treeres{1,ptr} = xigua{y_data};
            treeleaf(cur) = 1;
            return;
       end

       %�ݹ鷵�����2:
       %�����Ѿ�ȫ�����ֻ��в�ͬ���������������������������һ�µ��Ƿ��಻ͬ(��ʱ�����д��������)
       pfn=size(pf);    %��¼��ǰ���Ը���

       tmp_para = x(pf,curset(1));
       f = 1;
       classy = y(curset(1));
       sum=zeros(1,2);
       for i=1:n
            if isequal(tmp_para , x(pf,curset(i)))
                t = (classy == y(curset(i)));
                sum(t) = sum(t)+1;
            else
                f=0;
                break;
            end
       end
       if(f == 1 || pfn(2) == 0) 
            treeres{1,cur} = xigua{(sum(2)>=sum(1))+1};
            treeleaf(cur) = 1;
            return;
       end

       %���ݹ�
       %ʵ����4����������ѡ�񷽷�,ʹ������ͬ�Ĳ��������:��Ϣ���棬�����ʣ�����ָ�������ʻع�
       %����������ܼ亯������ʵ��
       %��Ϊ����ͬ�Ĳ����������ֱ�Ӹú��������ܻ�����
       [k, threshold] = entropy_paraselect(curset,pf,pu);
       curx = x(pf,:);  %ͨ�����Ա�Ŵ�����������ѡȡ����(�Ѿ��������ɢ���Բ�����Ҫ)
       p_num=pf(k);       %��¼��ǰ���Եľ�����
       treeres{1,cur} = fenlei1{p_num};%��¼��ǰ�ڵ�ķ�������

       %��ɢ���������Էֱ���
       if(pu(k))    %��������
           %��������ֻ���Ϊ���� ���ڷ�ֵһ�� С�ڷ�ֵһ�� ���������ݹ�
             num = [1 1];
             tmp_set = zeros(2,100);
             for i=1:n
                if(curx(k,curset(i))>=threshold)
                    tmp_set(1,num(1))=curset(i);
                    num(1) = num(1)+1;
                else
                    tmp_set(2,num(2))=curset(i);
                    num(2) = num(2)+1;
                end
             end
             for i=1:2
                    %������������ţ�����0���ڣ��������ֿ����뵱ǰ�������󽻼�  ��0ȥ��
                    ttmp_set = intersect(tmp_set(i,:),curset);  

                    treeres{2,ptr+1} = fenlei{i,p_num};               %��¼�����������
                    treeres{3,ptr+1} = threshold;       %��¼��ֵ
                    TreeGenerate(cur,ttmp_set,pf,pu,pt);
             end
       else
            %��ɢ�ͷ���Ҫ��ÿ��ȡֵ�֣�����ĳ��ȡֵ������Ϊ0��ҲҪ���Ϊ��ǰ����������һ������
            tpt=pt(k);  %�����Զ�Ӧ�������

            pf(:,k)=[]; %��ɢ����ֻ��һ�Σ�����ʹӼ�����ȥ��
            pu(:,k)=[];
            pt(:,k)=[];
            %��¼ÿ������ȡֵ�¶�Ӧ�����������Ƕ���
            num = ones(1,tpt);
            tmp_set = zeros(tpt,100);
            n=size(curset);
            for i=1:n(2)             
               tmp_set(curx(k,curset(i)),num(curx(k,curset(i))))=curset(i);
               num(curx(k,curset(i))) = num(curx(k,curset(i)))+1;
            end
            %Ȼ��ÿ��ȡֵ�ݹ�
            for i=1:tpt
                   ttmp_set = intersect(tmp_set(i,:),curset);
                   n = size(ttmp_set);
                   %�����ȡֵ��û�������������еݹ飬���Ϊ��ǰ����������һ������
                   if(n(2)==0)
                       ptr=ptr+1;
                       tree(ptr)=cur;
                       treeres{1,ptr} = xigua{(y_nums(2)>y_nums(1))+1};
                       treeres{2,ptr} = fenlei{i,p_num};
                   else
                    treeres{2,ptr+1} = fenlei{i,p_num};    %��¼�����������
                    TreeGenerate(cur,ttmp_set,pf,pu,pt);
                   end
            end
       end

end