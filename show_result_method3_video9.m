clear all
close all

load (['.\savedData_forDrawing\data_3_1.mat'])
subplot(331)
plot(xdata,hr_true,'k.-',xdata,plot_fre_emd,'b+-',xdata,plot_fre_ica,'gs-',xdata,plotfreq,'rp-');
ylim([50, 140]);
xlim([0,xdata(end)]);
xlabel('时间/分钟');
ylabel('每分钟心跳次数');
set(gca,'xtick',[0:1:xdata(end)]) 
RMSE = sqrt(mean((plotfreq-hr_true).^2));
RMSE1 = sqrt(mean((plot_fre_emd-hr_true).^2));
RMSE2 = sqrt(mean((plot_fre_ica-hr_true).^2));
title('(a)DROZY数据集视频3-1');
% legend('参考心率','EMD','ICA','本文方法')

load (['.\savedData_forDrawing\data_3_2.mat'])
subplot(332)
plot(xdata,hr_true,'k.-',xdata,plot_fre_emd,'b+-',xdata,plot_fre_ica,'gs-',xdata,plotfreq,'rp-');
ylim([50, 140]);
xlim([0,xdata(end)]);
xlabel('时间/分钟');
ylabel('每分钟心跳次数');
set(gca,'xtick',[0:1:xdata(end)]) 
RMSE = sqrt(mean((plotfreq-hr_true).^2));
RMSE1 = sqrt(mean((plot_fre_emd-hr_true).^2));
RMSE2 = sqrt(mean((plot_fre_ica-hr_true).^2));
title('(b)DROZY数据集视频3-2');
% legend('参考心率','EMD','ICA','本文方法')

load (['.\savedData_forDrawing\data_3_3.mat'])
subplot(333)
plot(xdata,hr_true,'k.-',xdata,plot_fre_emd,'b+-',xdata,plot_fre_ica,'gs-',xdata,plotfreq,'rp-');
ylim([50, 140]);
xlim([0,xdata(end)]);
xlabel('时间/分钟');
ylabel('每分钟心跳次数');
set(gca,'xtick',[0:1:xdata(end)]) 
RMSE = sqrt(mean((plotfreq-hr_true).^2));
RMSE1 = sqrt(mean((plot_fre_emd-hr_true).^2));
RMSE2 = sqrt(mean((plot_fre_ica-hr_true).^2));
title('(c)DROZY数据集视频3-3');
% legend('参考心率','EMD','ICA','本文方法')

load (['.\savedData_forDrawing\data_9_2.mat'])
subplot(334)
plot(xdata,hr_true,'k.-',xdata,plot_fre_emd,'b+-',xdata,plot_fre_ica,'gs-',xdata,plotfreq,'rp-');
ylim([50, 140]);
xlim([0,xdata(end)]);
xlabel('时间/分钟');
ylabel('每分钟心跳次数');
set(gca,'xtick',[0:1:xdata(end)]) 
RMSE = sqrt(mean((plotfreq-hr_true).^2));
RMSE1 = sqrt(mean((plot_fre_emd-hr_true).^2));
RMSE2 = sqrt(mean((plot_fre_ica-hr_true).^2));
title('(d)DROZY数据集视频9-2');
% legend('参考心率','EMD','ICA','本文方法')

load (['.\savedData_forDrawing\data_9_3.mat'])
subplot(335)
plot(xdata,hr_true,'k.-',xdata,plot_fre_emd,'b+-',xdata,plot_fre_ica,'gs-',xdata,plotfreq,'rp-');
ylim([50, 140]);
xlim([0,xdata(end)]);
xlabel('时间/分钟');
ylabel('每分钟心跳次数');
set(gca,'xtick',[0:1:xdata(end)]) 
RMSE = sqrt(mean((plotfreq-hr_true).^2));
RMSE1 = sqrt(mean((plot_fre_emd-hr_true).^2));
RMSE2 = sqrt(mean((plot_fre_ica-hr_true).^2));
title('(e)DROZY数据集视频9-3');
% legend('参考心率','EMD','ICA','本文方法')

load (['.\savedData_forDrawing\data_10_1.mat'])
subplot(336)
plot(xdata,hr_true,'k.-',xdata,plot_fre_emd,'b+-',xdata,plot_fre_ica,'gs-',xdata,plotfreq,'rp-');
ylim([50, 140]);
xlim([0,xdata(end)]);
xlabel('时间/分钟');
ylabel('每分钟心跳次数');
set(gca,'xtick',[0:1:xdata(end)]) 
RMSE = sqrt(mean((plotfreq-hr_true).^2));
RMSE1 = sqrt(mean((plot_fre_emd-hr_true).^2));
RMSE2 = sqrt(mean((plot_fre_ica-hr_true).^2));
title('(f)DROZY数据集视频10-1');
% legend('参考心率','EMD','ICA','本文方法')

load (['.\savedData_forDrawing\data_14_1.mat'])
subplot(337)
plot(xdata,hr_true,'k.-',xdata,plot_fre_emd,'b+-',xdata,plot_fre_ica,'gs-',xdata,plotfreq,'rp-');
ylim([30, 120]);
xlim([0,xdata(end)]);
xlabel('时间/分钟');
ylabel('每分钟心跳次数');
set(gca,'xtick',[0:1:xdata(end)]) 
RMSE = sqrt(mean((plotfreq-hr_true).^2));
RMSE1 = sqrt(mean((plot_fre_emd-hr_true).^2));
RMSE2 = sqrt(mean((plot_fre_ica-hr_true).^2));
title('(g)DROZY数据集视频14-1');
% legend('参考心率','EMD','ICA','本文方法')

load (['.\savedData_forDrawing\data_14_2.mat'])
subplot(338)
plot(xdata,hr_true,'k.-',xdata,plot_fre_emd,'b+-',xdata,plot_fre_ica,'gs-',xdata,plotfreq,'rp-');
ylim([30, 120]);
xlim([0,xdata(end)]);
xlabel('时间/分钟');
ylabel('每分钟心跳次数');
set(gca,'xtick',[0:1:xdata(end)]) 
RMSE = sqrt(mean((plotfreq-hr_true).^2));
RMSE1 = sqrt(mean((plot_fre_emd-hr_true).^2));
RMSE2 = sqrt(mean((plot_fre_ica-hr_true).^2));
title('(h)DROZY数据集视频14-2');
% legend('参考心率','EMD','ICA','本文方法')

load (['.\savedData_forDrawing\data_14_3.mat'])
subplot(339)
plot(xdata,hr_true,'k.-',xdata,plot_fre_emd,'b+-',xdata,plot_fre_ica,'gs-',xdata,plotfreq,'rp-');
ylim([30, 120]);
xlim([0,xdata(end)]);
xlabel('时间/分钟');
ylabel('每分钟心跳次数');
set(gca,'xtick',[0:1:xdata(end)]) 
RMSE = sqrt(mean((plotfreq-hr_true).^2));
RMSE1 = sqrt(mean((plot_fre_emd-hr_true).^2));
RMSE2 = sqrt(mean((plot_fre_ica-hr_true).^2));
title('(i)DROZY数据集视频14-3');
% legend('参考心率','EMD','ICA','本文方法')

