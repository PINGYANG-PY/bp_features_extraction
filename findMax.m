function [locs,pks]=findMax(data,i,N)
%�ҳ�PPG�ź��е�I���źź�N�������е����ֵ
%�����ź�
% i PPG �ź��е�λ�� N ������ٸ���
%����ź�
% locs pks ��������ֵλ�õ�λ�ú�ֵ
max=data(i);
locs=i;
for m=1:N
   
    if data(i+m)>=max
        max=data(i+m);
        locs=i+m;
    end
end
pks=max;
end



