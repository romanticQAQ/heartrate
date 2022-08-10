% �Ա�ͼPic1��ͼ���̼�¼��
% ��ƵתROI3ͨ�����ݣ�test_other_way_emd.m
% �ֶ�������ʵֵ�����뱾�ķ��������Ƚϣ�����������show_result_4_4.m
% emd��������������test_other_way_emd.m
% iva��������������test_other_way_iva.m
% �����������������Ա�ͼ��show_result_pic1_method3.m
% 
% ɢ��ͼPic2��ͼ���̼�¼��
% 1. ���У�show_result_pic2


clear all
close all
% ��ȡ�����ļ���
Path = '.\savedData_forDrawing_SanDian\';                   % �������ݴ�ŵ��ļ���·��
File = dir(fullfile(Path,'*.mat'));  % ��ʾ�ļ��������з��Ϻ�׺��Ϊ.txt�ļ���������Ϣ
FileNames = {File.name}';            % ��ȡ���Ϻ�׺��Ϊ.txt�������ļ����ļ�����ת��Ϊn��1��
% ���ݻ���
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



