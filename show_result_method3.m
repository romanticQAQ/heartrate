clear all
close all
%ע����������test_other_way_ica.m,ȷ�������������ݶ���
%%
% �Ա�ͼPic1��ͼ���̼�¼��
% ��ƵתROI3ͨ�����ݣ�test_other_way_emd.m
% �ֶ�������ʵֵ�����뱾�ķ��������Ƚϣ�����������show_result_4_4.m
% emd��������������test_other_way_emd.m
% iva��������������test_other_way_iva.m
% �����������������Ա�ͼ��show_result_pic1_method3.m
% 
% ɢ��ͼPic2��ͼ���̼�¼��
% 1. ���У�show_result_pic2
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
% xlabel('ʱ��/����');
ylabel('heartbeats per minute');
% ylabel('ÿ������������');
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
% legend('�ο�����','EMD','ICA','���ķ���')

% % ��У���ʾ�������н���
% load chirp
% sound(y,Fs)