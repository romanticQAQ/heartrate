clear all
close all
%注：需先运行test_other_way_ica.m,确保三个方法数据都有
%%
% 对比图Pic1跑图流程记录：
% 视频转ROI3通道数据：test_other_way_emd.m
% 手动输入真实值，并与本文方法结果相比较，并保存结果：show_result_4_4.m
% emd方法并保存结果：test_other_way_emd.m
% iva方法并保存结果：test_other_way_iva.m
% 各个方法的总体仿真对比图：show_result_pic1_method3.m
% 
% 散点图Pic2跑图流程记录：
% 1. 运行：show_result_pic2
% '[data_20220307_1749_k,data_20220307_1935,data_20220319_1958,data_20220302_2120,data_20220319_1944_0,data_20220319_2104,data_20220414_2114,data_20220414_2132,data_20220414_2147]';

load (['.\savedData_forDrawing\data_3_3.mat'])
figure(1)

plot(xdata,hr_true,'k.-',xdata,plot_fre_emd,'b+-',xdata,plot_fre_ica,'gs-');
% plot(xdata,hr_true,'k.-',xdata,plot_fre_emd,'b+-',xdata,plot_fre_ica,'gs-',xdata,plotfreq,'rp-');
ylim([30, 120]);
% ylim([60, 200]);
xlim([0,xdata(end)]);
% title(savedDataName)
xlabel('time/minutes');
% xlabel('时间/分钟');
ylabel('heartbeats per minute');
% ylabel('每分钟心跳次数');
set(gca,'xtick',[0:1:xdata(end)]) 
RMSE = sqrt(mean((plotfreq-hr_true).^2));
RMSE1 = sqrt(mean((plot_fre_emd-hr_true).^2));
RMSE2 = sqrt(mean((plot_fre_ica-hr_true).^2));
 title([savedDataName,'   RMSE=',num2str(RMSE1),',',num2str(RMSE2),',',num2str(RMSE)],'Interpreter','none');

% title('Video 3-2 on DROZY dataset');
% title('Video 3-3 on DROZY dataset');
% title('Video 9-2 on DROZY dataset');
% title('Video 9-3 on DROZY dataset');
% title('Video 10-1 on DROZY dataset');
% title('Video 14-3 on DROZY dataset');
% title('Video 3-1 on DROZY dataset');
% title('Video 14-1 on DROZY dataset');
% title('Video 14-2 on DROZY dataset');
title('DROZY 3-3');

legend('ground-truth','EMD','ICA','our method')
% legend('参考心率','EMD','ICA','本文方法')

% % 鸟叫，表示程序运行结束
% load chirp
% sound(y,Fs)