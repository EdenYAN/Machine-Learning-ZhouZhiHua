%{
��Ϣ����ѡ��
    curset:��ǰ��������
    pf����ǰ���Եı��
    pu����ǰ����������������ɢ��0-��ɢ 1-����
���
    n����������
    threshold:�������Է��ط�ֵ
%}
function [n, threshold] = entropy_paraselect(curset,pf,pu)
global x y; 
    %ͨ��������������Ի�ȡ��ǰ��Ҫ������
    curx = x(pf,curset);
    cury = y(curset);
    pn = size(pf);  %ʣ��������
    all = size(cury);   %��ǰ��������
    max_ent = -100;     %Ϊent���ֵ��Ҫ���ֵ��������Ϊһ����С����
    minn=0;             %��¼���ŵ����Ա��
    threshold = 0;  
    for i=1:pn(2)
        if(pu(i) == 1)%�����Ա���   %���巽��������
            con_max_ent =  -100;
            con_threshold = 0;
            xlist = sort(curx(i,:),2);
            %����n-1����ֵ
            for j=all(2):-1:2
               xlist(j) = (xlist(j)+xlist(j-1))/2;
            end
            %��n-1����ֵ��ѡ����    (ѭ��������ent�ȵݼ������ ��ʵֻҪ�����ent��ǰ��Ĵ�Ϳ���ֹͣѭ��)
            for j=2:all(2)
               cur_ent = 0; 
               %���������������
               nums = zeros(2,2);
               for k=1:all(2)
                    nums((curx(i,k)>=xlist(j))+1,cury(k)) = nums((curx(i,k)>=xlist(j))+1,cury(k)) + 1;
               end
               %����ent  ��������ֻ���������
               for k=1:2
                   if(nums(k,1)+nums(k,2) > 0)
                p=nums(k,1)/(nums(k,1)+nums(k,2));
                cur_ent = cur_ent + (p*log2(p+0.00001)+(1-p)*log2(1-p+0.00001))*(nums(k,1)+nums(k,2))/all(2);
                   end
               end
               %��¼�÷�������ȡֵ
               if(cur_ent>con_max_ent)
                   con_max_ent = cur_ent;
                   con_threshold = xlist(j);
               end
            end
            %���������ȡֵ�ȵ�ǰ�ܵ����Ż�Ҫ�ţ���¼
            if(con_max_ent > max_ent)
                max_ent=con_max_ent;
                minn = i;
                threshold = con_threshold;
            end
        else
            %��ɢ��
            %���˷��������� ����һ��
            cur_ent = 0; 
            set_data=unique(curx(i,:));
            setn=size(set_data);
            nums = zeros(10,2);
            for j=1:all(2)
               nums(curx(i,j),cury(j))=nums(curx(i,j),cury(j))+1;
            end
            for j=1:setn(2)
                if((nums(set_data(j),1)+nums(set_data(j),2))>0)
                 p=nums(set_data(j),1)/(nums(set_data(j),1)+nums(set_data(j),2));
                 cur_ent = cur_ent +(p*log2(p+0.00001)+(1-p)*log2(1-p+0.00001))*(nums(set_data(j),1)+nums(set_data(j),2))/all(2);
                end
            end
            if(cur_ent > max_ent)
                minn = i;
                max_ent = cur_ent;
            end
        end
    end
    n = minn;
    threshold = threshold * pu(n);

end