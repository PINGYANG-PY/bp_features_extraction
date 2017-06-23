function [peak,onset]=detectPeaksAndOnsetsInPPG(ppg)
%��PPG�źŵĲ���
%�����ź�
%ppg ������1000��1*N
%����ź�
%peak ����λ������ N*2 λ��+ֵ
%onset ��ʼ������ N*2 λ�ã�ֵ
data=ppg-mean(ppg);

% len=length(data);
% threshold = floor(1000*3/10); %�ź����ڴ�ŵĳ��ȣ�ƫС��
% maxLenRet = ceil(len / threshold);           % ��ֵ�Ĵ��¸���
% peak = zeros(maxLenRet,2);

%���źŶ�Ӧ��SSF���� N*2
ssf=ssfInPPG(data); %N*2�ľ���
 %Ѱ��ǰ����SSF�����ֵ��%70��Ϊ��ʼ��ֵ
 max=ssf(1000,2);
    for i=1000:3000
         if ssf(i,2)>=max
                max=ssf(i,2);
         end
         thres=max*0.7;
    end
    %��֮���SSF�������д���
    k=1;
for i=3000:length(data)-150
% for i=3000:10000
    
  
   
   
     %�ҳ��ź���ǰ��20���㵼�������㣬���Ҹպô�����ֵ�ĵ㣨�������ϳ�����ֵ�ĵ㣩
     if ssf(i,2)<=thres
         if ssf(i+1,2)>=thres
             if ssf(i+5,2)>ssf(i-5,2)%�պô�����ֵ�ĵ�
                 if k==1
                     
                     peaksofssf(k,1)=i;
                     [locs,pks]=findMaxInSSF(ssf,peaksofssf(k,1),150);
                     peaksofssf(k,2)=pks;
                     peaksofssf(k,3)=locs;
                     k=k+1;
                     
                 else
                     if i-peaksofssf(k-1,1)>150
                         
                         peaksofssf(k,1)=i;
                         [locs,pks]=findMaxInSSF(ssf,peaksofssf(k,1),150);
                         peaksofssf(k,2)=pks;
                         peaksofssf(k,3)=locs; %SSF����λ��
                         k=k+1;
                     end
                 end
                 
                 
                 
                 
                 if k>6
                     thres=(peaksofssf(k-5,2)+peaksofssf(k-4,2)+peaksofssf(k-3,2)+peaksofssf(k-2,2)+peaksofssf(k-1,2))/5*0.4;
                 end
                
                 
             end
         end
     end
end
for j=1:k-1
    i=peaksofssf(j,1);
    [locs,pks]=findMax(data,i,150);
    peak(j,1)=locs;
    peak(j,2)=ppg(locs);
    
end
for j=1:k-1
    i=peaksofssf(j,1);
    [locs,ons]=findMin(data,i,150);
    onset(j,1)=locs;
    onset(j,2)=ppg(locs);
    
end
end
