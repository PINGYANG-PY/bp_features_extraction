function [peaks] = detetectPeaksInSSF(data)
% ������PPG�ź��󲨷�
% �����ź�
% data = PPG
% ����ź�
% ���� peaks N*2

len=length(data);
threshold = floor(getSampleRate(1)*3/10); %�ź����ڴ�ŵĳ��ȣ�ƫС��
maxLenRet = ceil(len / threshold);           % ��ֵ�Ĵ��¸���
peaks = zeros(maxLenRet, 2);


ssf=ssfInPPG(data); %N*2�ľ���
for i=1:len
    if i<3000
        thres=
    end
end
    
    
    
