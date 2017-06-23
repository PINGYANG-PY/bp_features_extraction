function [ssfValue] = ssfInPPG(data)
%  ���ÿ�����ssf����ֵ
%  �����ź�
%  data = PPG 1*N
%  ����ź�
%  ssfValue  N*2���� �ֱ���λ�úͶ�Ӧ�ĺ���ֵ

len=length(data);
ssfValue = zeros(len,2);


for i=1:len
    if i<127
        ssfValue(i,1)=i;
        ssfValue(i,2)=0;
    else
        ssfValue(i,1)=i;
        sum=0;
        for j=i-125:i
            x=data(j)-data(j-1);
            if x<0
                x=0;
            end
            sum=sum+x;
            
        end
        ssfValue(i,2)=sum;
    end
end

% end
end


