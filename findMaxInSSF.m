function [locs,pks]=findMaxInSSF(data,i,N)
%�ҳ�SSF�ź��е�I���źź�N�������е����ֵ
%�����ź�
% i SSF �ź��е�λ�� N ������ٸ��� N*2
%����ź�
% locs pks ��������ֵλ�õ�λ�ú�ֵ
max=data(i,2);
locs=data(i,1);
for m=1:N
    
    if data(i+m,2)>=max
        max=data(i+m,2);
        locs=data(i+m,1);
    end
end
pks=max;
end