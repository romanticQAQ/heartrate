% 包含保存视频三通道数据功能
%% 请在matlab2019中视频转数据，在2015中提取心率
%每次改三个地方
clear all
close all
%% 参数设置汇总:开始
%% 读取视频部分
flag_read=1; %0或1，0为直接load现有数据，1为视频转数据
%flag为0时设置
XX='.\data_video_3ROI\data_20220629_2018_ROI.mat'; %现有数据文件名:注意：变量名称需一致
%flag为1时设置
path_name = '.\videos\'; % 路径名
video_name_pure = '20220629_2018'; % 设置读入视频名称
format_name = '.mp4'; %视频格式
video_name = [path_name,video_name_pure,format_name];
time = 30; %分段读取视频的间隔时长
%% 滤波器选择
flag_bp = 125; % 带通滤波器频率选择
%% 读取保存真实值的文件名
trueHr_name='.\savedData_forDrawing\data_20220629_2018.mat';

%% 参数设置汇总:结束

%% 数据分段读入
if flag_read==0
    load(XX); %读取保存数据
elseif flag_read==1
    video=VideoReader(video_name);
%     numFrames = video.NumFrames;
    numFrames = video.NumberofFrame;
    fs = round(video.FrameRate);
    %原始ROI有鼻子版
    for iter = 1:floor(numFrames/(fs*time))
        startFrame = (iter-1)*fs*time + 1;
        endFrame = iter*fs*time;
        % 人脸检测+KLT追踪（输入视频张量，输出选定ROI区域均值时域信号）
        % X_original为三个选定区域均值信号，3*帧数
        X_original = f_video2signal(video_name, startFrame, endFrame);
        % 信号预处理（标准化+去趋势+坐标延迟变换）
        % X_tensor为三个区域坐标延迟后的三个信号，共九个的集合
        X_tensor{iter} = f_pre_process(X_original);    
    end
    % 保存读取的数据，命名格式：“文件名_saved_after_iva.mat"
    txt_behind='_ROI.mat';
    save(['.\data_video_3ROI\data_',video_name_pure,txt_behind],'X_tensor','fs');    
end
    
for iter = 1: length(X_tensor)
    
temp=X_tensor{iter};
X_comp=(temp(1,:,1)+temp(1,:,2)+temp(1,:,3)/3);

%% 滤波
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

%% emd方法测心率
hr=X_after_filter;
frame_num=size(hr)
t=(1:1:frame_num(2));
imf=emd(hr);
% emd_visu(hr,t,imf);
singal=zeros(1, frame_num(2));
for i=2 %可以更改调整处
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
%%画图
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
xlabel('时间/分钟');
ylabel('每分钟心跳次数');
set(gca,'xtick',[0:1:xdata(end)]) 
RMSE = sqrt(mean((plot_fre_emd-hr_true).^2));
title([savedDataName,'   RMSE=',num2str(RMSE)],'Interpreter','none');
legend('参考心率','emd测量心率')

load (['.\savedData_forDrawing\',savedDataName,'.mat'],'xdata','hr_true','plotfreq','savedDataName')
save(['.\savedData_forDrawing\',savedDataName,'.mat'],'xdata','hr_true','plotfreq','savedDataName','plot_fre_emd'); 

% 鸟叫，表示程序运行结束
load chirp
sound(y,Fs)