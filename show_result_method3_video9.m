clear all
close all

load (['.\savedData_forDrawing\data_3_1.mat'])
subplot(331)
plot(xdata,hr_true,'k.-',xdata,plot_fre_emd,'b+-',xdata,plot_fre_ica,'gs-',xdata,plotfreq,'rp-');
ylim([50, 140]);
xlim([0,xdata(end)]);
xlabel('ʱ��/����');
ylabel('ÿ������������');
set(gca,'xtick',[0:1:xdata(end)]) 
RMSE = sqrt(mean((plotfreq-hr_true).^2));
RMSE1 = sqrt(mean((plot_fre_emd-hr_true).^2));
RMSE2 = sqrt(mean((plot_fre_ica-hr_true).^2));
title('(a)DROZY���ݼ���Ƶ3-1');
% legend('�ο�����','EMD','ICA','���ķ���')

load (['.\savedData_forDrawing\data_3_2.mat'])
subplot(332)
plot(xdata,hr_true,'k.-',xdata,plot_fre_emd,'b+-',xdata,plot_fre_ica,'gs-',xdata,plotfreq,'rp-');
ylim([50, 140]);
xlim([0,xdata(end)]);
xlabel('ʱ��/����');
ylabel('ÿ������������');
set(gca,'xtick',[0:1:xdata(end)]) 
RMSE = sqrt(mean((plotfreq-hr_true).^2));
RMSE1 = sqrt(mean((plot_fre_emd-hr_true).^2));
RMSE2 = sqrt(mean((plot_fre_ica-hr_true).^2));
title('(b)DROZY���ݼ���Ƶ3-2');
% legend('�ο�����','EMD','ICA','���ķ���')

load (['.\savedData_forDrawing\data_3_3.mat'])
subplot(333)
plot(xdata,hr_true,'k.-',xdata,plot_fre_emd,'b+-',xdata,plot_fre_ica,'gs-',xdata,plotfreq,'rp-');
ylim([50, 140]);
xlim([0,xdata(end)]);
xlabel('ʱ��/����');
ylabel('ÿ������������');
set(gca,'xtick',[0:1:xdata(end)]) 
RMSE = sqrt(mean((plotfreq-hr_true).^2));
RMSE1 = sqrt(mean((plot_fre_emd-hr_true).^2));
RMSE2 = sqrt(mean((plot_fre_ica-hr_true).^2));
title('(c)DROZY���ݼ���Ƶ3-3');
% legend('�ο�����','EMD','ICA','���ķ���')

load (['.\savedData_forDrawing\data_9_2.mat'])
subplot(334)
plot(xdata,hr_true,'k.-',xdata,plot_fre_emd,'b+-',xdata,plot_fre_ica,'gs-',xdata,plotfreq,'rp-');
ylim([50, 140]);
xlim([0,xdata(end)]);
xlabel('ʱ��/����');
ylabel('ÿ������������');
set(gca,'xtick',[0:1:xdata(end)]) 
RMSE = sqrt(mean((plotfreq-hr_true).^2));
RMSE1 = sqrt(mean((plot_fre_emd-hr_true).^2));
RMSE2 = sqrt(mean((plot_fre_ica-hr_true).^2));
title('(d)DROZY���ݼ���Ƶ9-2');
% legend('�ο�����','EMD','ICA','���ķ���')

load (['.\savedData_forDrawing\data_9_3.mat'])
subplot(335)
plot(xdata,hr_true,'k.-',xdata,plot_fre_emd,'b+-',xdata,plot_fre_ica,'gs-',xdata,plotfreq,'rp-');
ylim([50, 140]);
xlim([0,xdata(end)]);
xlabel('ʱ��/����');
ylabel('ÿ������������');
set(gca,'xtick',[0:1:xdata(end)]) 
RMSE = sqrt(mean((plotfreq-hr_true).^2));
RMSE1 = sqrt(mean((plot_fre_emd-hr_true).^2));
RMSE2 = sqrt(mean((plot_fre_ica-hr_true).^2));
title('(e)DROZY���ݼ���Ƶ9-3');
% legend('�ο�����','EMD','ICA','���ķ���')

load (['.\savedData_forDrawing\data_10_1.mat'])
subplot(336)
plot(xdata,hr_true,'k.-',xdata,plot_fre_emd,'b+-',xdata,plot_fre_ica,'gs-',xdata,plotfreq,'rp-');
ylim([50, 140]);
xlim([0,xdata(end)]);
xlabel('ʱ��/����');
ylabel('ÿ������������');
set(gca,'xtick',[0:1:xdata(end)]) 
RMSE = sqrt(mean((plotfreq-hr_true).^2));
RMSE1 = sqrt(mean((plot_fre_emd-hr_true).^2));
RMSE2 = sqrt(mean((plot_fre_ica-hr_true).^2));
title('(f)DROZY���ݼ���Ƶ10-1');
% legend('�ο�����','EMD','ICA','���ķ���')

load (['.\savedData_forDrawing\data_14_1.mat'])
subplot(337)
plot(xdata,hr_true,'k.-',xdata,plot_fre_emd,'b+-',xdata,plot_fre_ica,'gs-',xdata,plotfreq,'rp-');
ylim([30, 120]);
xlim([0,xdata(end)]);
xlabel('ʱ��/����');
ylabel('ÿ������������');
set(gca,'xtick',[0:1:xdata(end)]) 
RMSE = sqrt(mean((plotfreq-hr_true).^2));
RMSE1 = sqrt(mean((plot_fre_emd-hr_true).^2));
RMSE2 = sqrt(mean((plot_fre_ica-hr_true).^2));
title('(g)DROZY���ݼ���Ƶ14-1');
% legend('�ο�����','EMD','ICA','���ķ���')

load (['.\savedData_forDrawing\data_14_2.mat'])
subplot(338)
plot(xdata,hr_true,'k.-',xdata,plot_fre_emd,'b+-',xdata,plot_fre_ica,'gs-',xdata,plotfreq,'rp-');
ylim([30, 120]);
xlim([0,xdata(end)]);
xlabel('ʱ��/����');
ylabel('ÿ������������');
set(gca,'xtick',[0:1:xdata(end)]) 
RMSE = sqrt(mean((plotfreq-hr_true).^2));
RMSE1 = sqrt(mean((plot_fre_emd-hr_true).^2));
RMSE2 = sqrt(mean((plot_fre_ica-hr_true).^2));
title('(h)DROZY���ݼ���Ƶ14-2');
% legend('�ο�����','EMD','ICA','���ķ���')

load (['.\savedData_forDrawing\data_14_3.mat'])
subplot(339)
plot(xdata,hr_true,'k.-',xdata,plot_fre_emd,'b+-',xdata,plot_fre_ica,'gs-',xdata,plotfreq,'rp-');
ylim([30, 120]);
xlim([0,xdata(end)]);
xlabel('ʱ��/����');
ylabel('ÿ������������');
set(gca,'xtick',[0:1:xdata(end)]) 
RMSE = sqrt(mean((plotfreq-hr_true).^2));
RMSE1 = sqrt(mean((plot_fre_emd-hr_true).^2));
RMSE2 = sqrt(mean((plot_fre_ica-hr_true).^2));
title('(i)DROZY���ݼ���Ƶ14-3');
% legend('�ο�����','EMD','ICA','���ķ���')

