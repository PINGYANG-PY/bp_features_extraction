function [dicNotch,dicPeak]=detectDicNotchAndDicPeak(ppg,peak,onset)
%���ҳ�ppg�ź���ÿһ���½��أ�������N*1��ʾ
%�����ź�
% ppgpce:������PPG�ź� 1*N
% peak:PPG�źŵĲ���λ�ú�ֵ N*2
% onset:PPG�źŵ���ʼ�� N*2
%����ź�
% descendEngeofPPG:PPG�źŵ��½��� N*1

%% ���ҵ�PPG�źŵ��½��ص�λ�ã�����ÿ�������ķ�ֵ�㵽��һ����������ʼ��
lenppg=length(ppg);
lenpeak=size(peak,1);
dicNotch=zeros(lenpeak,2);
dicPeak=zeros(lenpeak,2);
ppgpce_off=ppg-mean(ppg);
% plot(ppgpce_off);
for k=1:lenpeak-1
    for i=1:lenppg
        if i==peak(k,1)
            if onset(k+1,1)-peak(k,1)<1200&&onset(k+1,1)-peak(k,1)>200
                descendingEdgeofPPG=ppgpce_off(peak(k,1):onset(k+1,1));
                descendingEdgeofPPG=descendingEdgeofPPG';
                
                [dicNotch1, dicPeak1, zeroPassPointsNum ] = detectDicNotchAndDicPeakInDescendingEdgeUseWavelet( descendingEdgeofPPG,100 );
               
                
                dicNotch(k,1)=dicNotch1+i;
                dicNotch(k,2)=ppg(dicNotch1+i);
                dicPeak(k,1)= dicPeak1+i;
                dicPeak(k,2)=ppg(dicPeak1+i);
            else
                dicNotch(k,1)=0;
                dicNotch(k,2)=0;
                dicPeak(k,1)= 0;
                dicPeak(k,2)=0;
            end
        end
    end
end

%��ͼ
plot(ppg);
hold on
plot(dicNotch(:,1),dicNotch(:,2),'kx','LineWidth', 2, 'MarkerSize', 7);
hold on
plot(dicPeak(:,1),dicPeak(:,2),'ko', 'MarkerFaceColor', 'r', 'MarkerSize', 7);

end

