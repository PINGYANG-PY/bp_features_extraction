function [dataAligned] = alignBPToReferenceECG(src, ref, intervalLowerBound, intervalUpperBound)
% [dataAligned] = alignDataAccordingToReferenceData(src, ref)
% ������PPG��������ECG��������룬���ppg�Ĳ����λ��û�к�ecgR�����䣬��õ���Ϊ[0,0,0,0,0]
% ���룺
%   src��    N x 4  Ŀ������ PPG�źŵ�������λ�ã�src�ĵڶ���ΪPEAKλ��
%   ref��    N x 5  �ο����� ECG�źŵ�������λ�ã�ref�ĵ�����Ϊ R��λ��
%   intervalLowerBound��Ŀ�����ݺͲο����ݵ�ʱ����н�С��ֵ����������
%   intervalUpperBound��Ŀ�����ݺͲο����ݵ�ʱ����нϴ��ֵ����������
% ���ӣ�
%   [onsetsAligned] = alignDataAccordingToReferenceData(onsets, peaks, -300, -10)
%           onsets�ĺϷ�λ������peaks��ǰ300��ǰ10֮��
%   [dicNotchAligned] = alignDataAccordingToReferenceData(dicNotch, peaks, 100, 500)
%           onsets�ĺϷ�λ������peaks�ĺ�100����500֮��

lb = intervalLowerBound;
ub = intervalUpperBound;

%% ����1�������ʼ��
dataAligned = zeros(size(ref,1),2);

%% ����2��Ϊ�ο������е�ÿ����Ѱ�Ҷ�Ӧ��
j = 1;
lenRef = size(ref, 1);
lenSrc = size(src, 1);
for i = 1 : lenRef
    %% ��Ŀ���������ҵ���һ�����ܴ��ںϷ���Χ�ĵ�
    while j <= lenSrc && src(j, 2) < ref(i, 2) + lb
        j = j + 1;
    end % while
    %% Ŀ�������Ѿ���ȫ������ϣ�û���ҵ���Ӧ�ĵ�
    if j > lenSrc
        dataAligned(i, :) = [0, 0];
    else
        %% �ж���ǰĿ����Ƿ��ںϷ���Χ��
        if src(j, 2) < ref(i, 2) + ub;
            dataAligned(i, :) = src(j, :);
        else
            dataAligned(i, :) = [0, 0];
        end % if
    end % if
    
    
end % for


end % function