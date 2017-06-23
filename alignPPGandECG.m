function [ppg_locs_off,ecg_locs_off,bp_locs_off]=alignPPGandECG(ppg,ecg,peak,onset,dicNotch, dicPeak,ecg_Q,ecg_R,ecg_S,systolic,diastolic)
%����ECG�źŵ�R��λ��Ϊ��ʼ��Ѱ��������������֮��10~900����PPG�ź�peak����Ϊ���Ķ������ڵ��ź�
%����ɸѡ�����к���0λ�õĵ㣨���������㲻���ڵĵ㣩
%�����ź�
%����ź�
%ppg_locs_off PPG�źŵ���������PPG�ź��е�λ�ã���㡢���塢����Ͽ���ز���
%ecg_locs_off  ECG�źŵ���������ECG�ź��е�λ�ã�P Q R S T

ecg_locs(:,1)=ecg_Q(:,1);
ecg_locs(:,2)=ecg_R(:,1);
ecg_locs(:,3)=ecg_S(:,1);

% ��PPG�źŵ�������������
ppg_locs(:,1)=onset(:,1);
ppg_locs(:,2)=peak(:,1);
ppg_locs(:,3)=dicNotch(:,1);
ppg_locs(:,4)=dicPeak(:,1);
%��BP�źŵ�������������
bp_locs(:,1)=diastolic(:,1);
bp_locs(:,2)=systolic(:,1);

%����ECG�źŵ�R��λ��Ϊ��ʼ��Ѱ��������������֮��10~900����PPG�ź�peak����Ϊ���Ķ������ڵ��ź�
ppg_locs = alignPPGToReferenceECG(ppg_locs, ecg_locs, 10, 900); %Ѱ�Ҳ�����ECG�Ĳ������ڵ�PPG������ʱ��PPG�ź�Ϊ0
bp_locs=alignBPToReferenceECG(bp_locs,ecg_locs,10,900);
%�޳����к���0λ�ã�û�ҵ����ߺ�����ĵ㣩
% len=length(ppg_locs);
% k=1;
% ppg_locs_off=zeros(len,4);
% ecg_locs_off=zeros(len,5);
% for i=1:len
% if ppg_locs(i,2)~=0&&ppg_locs(i,3)~=0&&ecg_locs(i,5)~=0
%     ppg_locs_off(k,:)=ppg_locs(i,:);
%     ecg_locs_off(k,:)=ecg_locs(i,:);
%     k=k+1;
% end
ppg_locs_off=ppg_locs;
ecg_locs_off=ecg_locs;
bp_locs_off=bp_locs;
% %��ͼ 
% plot(ppg,'k');
% hold on
%  plot(ecg);
%  hold on
% %  len=length(ecg_locs_off);
%  for k=1:len
%      %      if ppg_locs_off(k,2)~=0
%      if ppg_locs(k,2)~=0&&ppg_locs(k,3)~=0&&ecg_locs(k,5)~=0
%          hold on
%          i1=ppg_locs_off(k,1);
%          i2=ppg_locs_off(k,2);
%          i3=ppg_locs_off(k,3);
%          i4=ppg_locs_off(k,4);
%          hold on
%          plot(i1,ppg(i1),'r*')
%          hold on
%          plot(i2,ppg(i2),'r*')
%          hold on
%          plot(i3,ppg(i3),'r*')
%          hold on
%          plot(i4,ppg(i4),'r*')
%          j1=ecg_locs_off(k,1);
%          j2=ecg_locs_off(k,2);
%          j3=ecg_locs_off(k,3);
%          j4=ecg_locs_off(k,4);
%          j5=ecg_locs_off(k,5);
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
%      end
%  end
end