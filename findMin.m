function [locs,ons]=findMin(data,i,N)
%Ѱ��PPG�ź������ڸ���λ��ǰN�����Сֵ

%�����ź�
% i PPG �ź��е�λ�� N ������ٸ���
%����ź�
% locs ons ��������ֵλ�õ�λ�ú�ֵ
%data 
k=i-N;
min=data(k);
locs=k;
for m=1:N
   
    if data(k+m)<=min
        min=data(k+m);
        locs=k+m;
    end
end
ons=min;
end