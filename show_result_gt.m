%% 使用TXT已跑出的视频数据为输入，对结果进行汇总对比
clear all
close all
%% 真实值保存并输入
    hr_true=[121.400000000000,116.166666666667,111.266666666667,107.300000000000,106.700000000000,102.400000000000,103.133333333333,103.966666666667,103.500000000000,101.133333333333,98.3000000000000,99.6333333333333,99.7000000000000,96.3333333333333,97.2666666666667,98.8333333333333,97.9333333333333,92.3000000000000,94.2000000000000];
%% 参数设置
% path_savedData_name='.\';
path_savedData_name='.\data_txt\';
savedDataName='data_20220307_1935'; %现有数据文件名:注意：变量名称需一致
XX=[path_savedData_name,savedDataName,'.mat'];
fs= 25; %读取已有数据时需要手动设置帧率
%% 滤波器选择
flag_bp = 125; % 带通滤波器频率选择
%% 信噪比定义选择
% flag_snr取1为最大幅值频率左右0.1范围为信号；取2为固定频率范围（f1,f2）(最好与带通滤波器通带范围一致)
flag_snr = 2;
    %若f_signal_range=2，需设置固定频率范围(最好与带通滤波器通带范围一致)
    f_signal_range = [1,2.5];
%% 读入数据
load (XX);

%% 经过所选择的巴特沃斯滤波器滤波,输出最大幅值及其对应频率值，以及信噪比
record_X_after_iva_v0 = record_X_after_iva;
[output_9max_fre,output_9max_fuzhi,output_snr] = f_filter_choice(record_X_after_iva_v0,flag_bp,fs,flag_snr,f_signal_range);
[xdata,plotfreq] = f_HR_curve(output_9max_fre,output_9max_fuzhi);
xdata=xdata./60;

figure(111)
plot(xdata,hr_true,'k',xdata,plotfreq,'b');
% ylim([30, 120]);
ylim([60, 200]);
xlim([0,xdata(end)]);
% title(savedDataName)
xlabel('时间/分钟');
ylabel('每分钟心跳次数');
%set(gca,'xtick',[0:1:xdata(end)]) 
set(gca,'xtick',[0:5:xdata(end)]) 
RMSE = sqrt(mean((plotfreq-hr_true).^2));
% title([savedDataName,'   RMSE=',num2str(RMSE)],'Interpreter','none');
legend('参考心率','测量心率')

save(['.\savedData_forDrawing\',savedDataName,'.mat'],'xdata','hr_true','plotfreq','savedDataName'); 

% 鸟叫，表示程序运行结束
load chirp
sound(y,Fs)
