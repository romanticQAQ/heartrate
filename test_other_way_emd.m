% ����������Ƶ��ͨ�����ݹ���
%% ����matlab2019����Ƶת���ݣ���2015����ȡ����
%ÿ�θ������ط�
clear all
close all
%% �������û���:��ʼ
%% ��ȡ��Ƶ����
flag_read=1; %0��1��0Ϊֱ��load�������ݣ�1Ϊ��Ƶת����
%flagΪ0ʱ����
XX='.\data_video_3ROI\data_20220629_2018_ROI.mat'; %���������ļ���:ע�⣺����������һ��
%flagΪ1ʱ����
path_name = '.\videos\'; % ·����
video_name_pure = '20220629_2018'; % ���ö�����Ƶ����
format_name = '.mp4'; %��Ƶ��ʽ
video_name = [path_name,video_name_pure,format_name];
time = 30; %�ֶζ�ȡ��Ƶ�ļ��ʱ��
%% �˲���ѡ��
flag_bp = 125; % ��ͨ�˲���Ƶ��ѡ��
%% ��ȡ������ʵֵ���ļ���
trueHr_name='.\savedData_forDrawing\data_20220629_2018.mat';

%% �������û���:����

%% ���ݷֶζ���
if flag_read==0
    load(XX); %��ȡ��������
elseif flag_read==1
    video=VideoReader(video_name);
%     numFrames = video.NumFrames;
    numFrames = video.NumberofFrame;
    fs = round(video.FrameRate);
    %ԭʼROI�б��Ӱ�
    for iter = 1:floor(numFrames/(fs*time))
        startFrame = (iter-1)*fs*time + 1;
        endFrame = iter*fs*time;
        % �������+KLT׷�٣�������Ƶ���������ѡ��ROI�����ֵʱ���źţ�
        % X_originalΪ����ѡ�������ֵ�źţ�3*֡��
        X_original = f_video2signal(video_name, startFrame, endFrame);
        % �ź�Ԥ������׼��+ȥ����+�����ӳٱ任��
        % X_tensorΪ�������������ӳٺ�������źţ����Ÿ��ļ���
        X_tensor{iter} = f_pre_process(X_original);    
    end
    % �����ȡ�����ݣ�������ʽ�����ļ���_saved_after_iva.mat"
    txt_behind='_ROI.mat';
    save(['.\data_video_3ROI\data_',video_name_pure,txt_behind],'X_tensor','fs');    
end
    
for iter = 1: length(X_tensor)
    
temp=X_tensor{iter};
X_comp=(temp(1,:,1)+temp(1,:,2)+temp(1,:,3)/3);

%% �˲�
if flag_bp==12
    X_after_filter=filter(filter_BP_1_2(fs),X_comp);
elseif flag_bp==13
    X_after_filter=filter(filter_BP_1_3(fs),X_comp);
elseif flag_bp==125
    X_after_filter=filter(filter_BP_1_25(fs),X_comp);
elseif flag_bp==62
    X_after_filter=filter(filter_BP_06_2(fs),X_comp);
elseif flag_bp==72
    X_after_filter=filter(filter_BP_07_2(fs),X_comp);
end

%% emd����������
hr=X_after_filter;
frame_num=size(hr)
t=(1:1:frame_num(2));
imf=emd(hr);
% emd_visu(hr,t,imf);
singal=zeros(1, frame_num(2));
for i=2 %���Ը��ĵ�����
    x=imf(i,:);
    singal=x+singal;
end
% plot(t, singal)

L=frame_num(2);
f = fs*(0:(L/2))/L;
Y = fft(singal);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
%%��ͼ
% figure;plot(f,P1) 
% xlabel('f (Hz)')
% ylabel('|P1(f)|')

[~,pos]=max(P1);
plot_fre_emd(iter)=f(pos)*60;

end
load(trueHr_name, 'hr_true','savedDataName');

xdata=[1:length(plot_fre_emd)]/2;

figure(22)
plot(xdata,hr_true,'k',xdata,plot_fre_emd,'r');
ylim([60, 200]);
% ylim([30, 120]);
xlim([0,xdata(end)]);
% title(savedDataName)
xlabel('ʱ��/����');
ylabel('ÿ������������');
set(gca,'xtick',[0:1:xdata(end)]) 
RMSE = sqrt(mean((plot_fre_emd-hr_true).^2));
title([savedDataName,'   RMSE=',num2str(RMSE)],'Interpreter','none');
legend('�ο�����','emd��������')

load (['.\savedData_forDrawing\',savedDataName,'.mat'],'xdata','hr_true','plotfreq','savedDataName')
save(['.\savedData_forDrawing\',savedDataName,'.mat'],'xdata','hr_true','plotfreq','savedDataName','plot_fre_emd'); 

% ��У���ʾ�������н���
load chirp
sound(y,Fs)