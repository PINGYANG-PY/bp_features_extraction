function [dicNotch, dicPeak, zeroPassPointsNum ] = detectDicNotchAndDicPeakInDescendingEdgeUseWavelet( descendingEdge,range )
%DETECTDICNOTCHANDDICPEAKINDESCENDINGEDGEUSEWAVELET ִ�����¼������� �ز��� ->
%�����źŵ�С���任 -> �ҵ��ض��������Ϊ����Ͽ ->���ݽ���Ͽ��λ��ʹ�þ��뷨�����ز���
%   ʹ��С�������½�֧�м���ز����ͽ���Ͽ
%   ����
%   descendingEdge [N*1]���� �������½�֧
%   range ʹ��˥����������ĵ�ǰ���뷨������Χ
%   ���
%   zeroPassPointsNum ���Ķ������ڹ���������

%%���������Ԥ����
resampleInterval = 10;%����������
dicNotch = -1;
dicPeak = -1;
zeroPassPointsNum = 0;
flag = 0;
pos=1;
%% ����1���źŶμ��������һ�� 
data = descendingEdge;
dataPart = downsample(data,resampleInterval);
dataPart = dataPart/max(abs(dataPart));



%% ����2����С���任

wlp = waveletMethodB(dataPart);
% 
% figure;
% plot(dataPart,'r');
% hold on;
% plot(0.5*wlp);

%% ����3������Ͽλ��
%   3-1 ͨ������������½��غ�С���任����ź����Ƚϣ�ȷ������Ͽ����λ�ã����²���4�ַ��������ȼ����ν���
%����һ��Ѱ��dataPartǰ��εļ�Сֵ�㣬����ҵ�������Ϊ�ǽ���Ͽ
if(floor(length(dataPart)/2)>=24)
    if(isempty(findpeaks(-1*dataPart(11:floor(length(dataPart)/2))))==0)
        [~,pos] = findpeaks(-1*dataPart(11:floor(length(dataPart)/2)));
        pos = pos(1)+10;
        flag = 0;
    elseif(min(dataPart)<max(0.5*wlp))%������������һʧ�ܣ�û���ҵ���Сֵ����Ѱ��dataPart��wlp�Ľ�����Ϊ����Ͽλ�ã����滹���жϣ�
        for i = 1:length(dataPart)
            if(0.5*wlp(i)>=dataPart(i))
                pos = i-1;
                flag = 1;
                break;
            end
        end
    else
        pos=1;
        flag=1;
    end
else
%     fprintf('���û�취��'); %�źų��ȷǳ��̣�����Ѱ����û������
    dicNotch = 0;
    dicPeak = 0;
    return
end


[~,peak] = findpeaks(wlp);
[~,valley] = findpeaks(-1*wlp);
%���������жϷ������ҵ��ĵ��Ƿ�λ�ú��ʣ����ͷ���Ǻ��Σ����������������wlp�ĵ��ĸ��������Ϊ����Ͽ
%if(flag)
if((pos>floor(length(wlp)/2) || pos<floor(length(wlp)/10) || pos<peak(1))  && flag)
%if((pos>floor(length(wlp)/2) || pos<floor(length(wlp)/10) || pos<=peak(1)) && flag)
    pos = findPassZeroPointPos(wlp(1:floor(end/2))) ; 
    zeroPassPointsNum = length(pos);
    if zeroPassPointsNum<4  %�����ģ����wlpǰ��εĹ����������4������÷����ģ�Ѱ��wlp�ڶ������Ⱥ͵ڶ�������֮��Ĺ������Ϊ����Ͽ
        if(peak(2)>valley(2))
            pos_zero = findPassZeroPointPos(wlp(valley(2):peak(2)));
            if(isempty(pos_zero)==0)
                pos = valley(2)+pos_zero(1);
            else
%                 fprintf('���û�취��');  %������岨��֮�仹�Ҳ�������㣬����-1
                dicNotch = 0;
                dicPeak = 0;
                return 
            end
        else
            pos_zero = findPassZeroPointPos(wlp(valley(1):peak(2)));
            if(isempty(pos_zero)==0)
                pos = valley(1)+pos_zero(1);
            else
                fprintf('���û�취��');  %������岨��֮���Ҳ�������㣬����-1
                dicNotch = 0;
                dicPeak = 0;
                return
            end
        end
    else
        pos =  pos(4);
    end
end

% ���Ի�ͼ����
% figure;
% plot(dataPart,'r');
% hold on;
% plot(0.6*wlp);
% hold on;
% plot(pos, dataPart(pos), 'ko', 'MarkerFaceColor', 'y', 'MarkerSize', 7);



%   3-2 ������Ͽλ��������������[-resampleInterval,resampleInterval]��Ѱ�Ҷ��׵����ֵ�㣬��Ϊ����Ͽԭʼ����λ��
pos = pos*resampleInterval;
resampleInterval = 10;
if pos + resampleInterval<=length(data) && pos - resampleInterval>0
        [~,shift] = min(abs(diff(data(pos- resampleInterval:pos + resampleInterval),1)));
        pos = pos + shift - resampleInterval-1; 
end

if pos >= length(data)
    return
end
dicNotch = pos;
%% ����4����[pos+1:pos+range-1]��Χ��Ѱ�ҵ�����[pos,data(pos)]��[pos+range,data(pos+range)]�������ֱ��
%       �ľ�������Ҵ���ֱ���Ϸ��ĵ㣬Ȼ������㵽���֮���Ҳ��塣����ҵ��˲��壬����λ����Ϊ�ز���λ�ã�����ʹ���յ�λ��
if pos+range > length(data)
    range = length(data) - pos;
end
tmp = data(pos+1:pos+range-1);
[~,maxpos,~] = poinToLineDistance([pos+1:pos+range-1;tmp(:)']',...
    [pos,data(pos)],[pos+range,data(pos+range)],1);
tmp = findPeakShiftInData(data(pos:pos+maxpos));
if tmp~=-1
    dicPeak = pos+tmp-1;
else
    dicPeak = pos+maxpos;
end
end

