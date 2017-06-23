function [ppg_locs_end,ecg_locs_end,bp_locs_end]=deleteInefficientFeatureInPPGandECG(bp,ppg,ecg,ppg_locs_off,ecg_locs_off,bp_locs_off1)
%����1 ECGû�ҵ�T�� 2�����ڶ�Ӧ��PPG 3�������ز��������
%���ȼ��ecg�ź�T���Ƿ����
%֮������ECG�źŶ�Ӧ��peak�Ƿ����
%֮���ټ��disNotchshi�Ƿ����
%������ڼ��onset��k+1��-peak(k)<1000�Ƿ���ϣ����������onset��k+1����ΪPPG_end������ΪPPG������
%�����źţ�
%ppg_locs_off, N*4  
%ecg_locs_off, N*5
%�Ѿ���ʱ���Ͻ�������û�м������Ե���������
%����ź�
%ppg_locs_end N*5  �ڴ˴�����һ������ ����PPG_end ������
%ecg_locs_oss  N*5
%���ȶ�BP�źŽ���У׼ ����ѹת�Ƶ�����
len1=size(bp_locs_off1,1);
for i=1:len1-1
    bp_locs_off(i,1)=bp_locs_off1(i,2);
    bp_locs_off(i,2)=bp_locs_off1(i+1,1);
end
    

len=size(ppg_locs_off,1);
i=1;

for k=1:len-1
    if ecg_locs_off(k,1)~=0&& ecg_locs_off(k,3)~=0&&ppg_locs_off(k,2)~=0&&ppg_locs_off(k,3)~=0&&bp_locs_off(k,1)~=0&&ppg_locs_off(k,1)~=0&&bp_locs_off(k,2)~=0
        if ppg_locs_off(k+1,1)-ppg_locs_off(k,2)<1000&&ppg_locs_off(k+1,1)~=0
            ecg_locs_end(i,:)=ecg_locs_off(k,:);
            bp_locs_end(i,:)=bp_locs_off(k,:);
            ppg_locs_end(i,1)=ppg_locs_off(k,1);
            ppg_locs_end(i,2)=ppg_locs_off(k,2);
            ppg_locs_end(i,3)=ppg_locs_off(k,3);
            ppg_locs_end(i,4)=ppg_locs_off(k,4);
            ppg_locs_end(i,5)=ppg_locs_off(k+1,1);
            i=i+1;
        end
    end
end
%��ͼ
% bp1=bp*10^(-3);
% plot(ppg,'k');
% hold on
% plot(ecg);
% hold on
% plot(bp1,'y');
% len=length(ecg_locs_end);
%  for k=1:len
%      
%          
%          i1=ppg_locs_end(k,1);
%          i2=ppg_locs_end(k,2);
%          i3=ppg_locs_end(k,3);
%          i4=ppg_locs_end(k,4);
%          i5=ppg_locs_end(k,5);
%          hold on
%          plot(i1,ppg(i1),'r*')
%          hold on
%          plot(i2,ppg(i2),'r*')
%          hold on
%          plot(i3,ppg(i3),'r*')
%          hold on
%          plot(i4,ppg(i4),'r*')
%          hold on
%          plot(i5,ppg(i5),'r*')
%          j1=ecg_locs_end(k,1);
%          j2=ecg_locs_end(k,2);
%          j3=ecg_locs_end(k,3);
%          j4=ecg_locs_end(k,4);
%          j5=ecg_locs_end(k,5);
%          hold on
%          plot(j1,ecg(j1),'ro');
%          hold on
%          plot(j2,ecg(j2),'ro');
%          hold on
%          plot(j3,ecg(j3),'ro');
%          hold on
%          plot(j4,ecg(j4),'ro');
%          hold on
%          plot(j5,ecg(j5),'ro');
%          m1=bp_locs_end(k,1);
%          m2=bp_locs_end(k,2);
%          hold on
%          plot(m1,bp1(m1),'rH');
%          hold on
%          plot(m2,bp1(m2),'rH');
%          
%  end

end

