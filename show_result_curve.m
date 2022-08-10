clear all
close all
load (['.\savedData_forDrawing\data_20220307_1935.mat'])

figure(11)
% plot(xdata,hr_true,'k.-',xdata,plotfreq,'rp-',xdata,plot_fre_emd,'b+-');
plot(xdata,hr_true,'k.-',xdata,plotfreq,'bs-');
ylim([60, 200]);
xlim([0,xdata(end)]);
% title(savedDataName)
xlabel('time/minute');
ylabel('heartbeats per minute');
set(gca,'xtick',[0:1:xdata(end)]) 
RMSE = sqrt(mean((plotfreq-hr_true).^2));
% RMSE1 = sqrt(mean((plot_fre_emd-hr_true).^2));
% title([savedDataName,'   RMSE=',num2str(RMSE),',',num2str(RMSE1)],'Interpreter','none');
% title([savedDataName,'   RMSE=',num2str(RMSE)],'Interpreter','none');
legend('ground truth','heart rate measurement')

% hold on
% plot(xdata,plotfreq,'-rO');

% 鸟叫，表示程序运行结束
load chirp
sound(y,Fs)