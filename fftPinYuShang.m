function [entropy] = fftPinYuShang(data)
% ��ʾ�ź�Ƶ��ͼ
%�����ź� 
%data Ĭ�ϲ�����Ϊ1000,1*N

fs=1000;
Ndata=length(data);
N=2^nextpow2(Ndata);
ffts=fft(data,N);
% mag=abs(y);
% f=(0:N-1)*fs/N;
% plot(f(1:N/2),mag(1:N/2));
%��ffts����һ��
normffts=(abs(ffts).*2)./(ones(1,length(ffts))*(sum(abs(ffts).^2)));
%����ֵ

    normffts = normffts.^2;
    normffts = normffts./(ones(1,length(normffts)) * sum(normffts));
    %from stackoverflow 22075285
    entropy = sum(- normffts.*log2(normffts));



end
