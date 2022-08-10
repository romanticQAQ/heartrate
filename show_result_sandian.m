% 对比图Pic1跑图流程记录：
% 视频转ROI3通道数据：test_other_way_emd.m
% 手动输入真实值，并与本文方法结果相比较，并保存结果：show_result_4_4.m
% emd方法并保存结果：test_other_way_emd.m
% iva方法并保存结果：test_other_way_iva.m
% 各个方法的总体仿真对比图：show_result_pic1_method3.m
% 
% 散点图Pic2跑图流程记录：
% 1. 运行：show_result_pic2


clear all
close all
% 读取所有文件名
Path = '.\savedData_forDrawing_SanDian\';                   % 设置数据存放的文件夹路径
File = dir(fullfile(Path,'*.mat'));  % 显示文件夹下所有符合后缀名为.txt文件的完整信息
FileNames = {File.name}';            % 提取符合后缀名为.txt的所有文件的文件名，转换为n行1列
% 数据汇总
total_hr_true = [];
total_plotfreq = [];
total_name = [];
for i=8:18
    load([Path,FileNames{i}]);
    total_hr_true=[total_hr_true;hr_true];
    total_plotfreq=[total_plotfreq;plotfreq];
    total_name=[total_name;savedDataName(end-2:end)];
end

for i=1:7
    load([Path,FileNames{i}]);
    total_hr_true=[total_hr_true;hr_true];
    total_plotfreq=[total_plotfreq;plotfreq];
    total_name=[total_name;savedDataName(end-2:end)];
end

plot_true_hr=total_hr_true';
plot_true_hr=plot_true_hr(:);
plot_myMethod=total_plotfreq';
plot_myMethod=plot_myMethod(:);
xdata=[1:length(plot_true_hr)];

figure(222)
plot(xdata,plot_true_hr,'r*',xdata,plot_myMethod,'b*');
grid on;
ylim([30, 100]);
xlim([0, xdata(end)]);
% title(savedDataName)
xlabel('Video segment number');
ylabel('Heartbeats per minute');
set(gca,'xtick',[0:19:length(plot_true_hr)]) 
% RMSE = sqrt(mean((plotfreq-hr_true).^2));
legend('ground-truth','heart rate measurement')



