%% ʹ��TXT���ܳ�����Ƶ����Ϊ���룬�Խ�����л��ܶԱ�
clear all
close all
%% ��ʵֵ���沢����
    hr_true=[121.400000000000,116.166666666667,111.266666666667,107.300000000000,106.700000000000,102.400000000000,103.133333333333,103.966666666667,103.500000000000,101.133333333333,98.3000000000000,99.6333333333333,99.7000000000000,96.3333333333333,97.2666666666667,98.8333333333333,97.9333333333333,92.3000000000000,94.2000000000000];
%% ��������
% path_savedData_name='.\';
path_savedData_name='.\data_txt\';
savedDataName='data_20220307_1935'; %���������ļ���:ע�⣺����������һ��
XX=[path_savedData_name,savedDataName,'.mat'];
fs= 25; %��ȡ��������ʱ��Ҫ�ֶ�����֡��
%% �˲���ѡ��
flag_bp = 125; % ��ͨ�˲���Ƶ��ѡ��
%% ����ȶ���ѡ��
% flag_snrȡ1Ϊ����ֵƵ������0.1��ΧΪ�źţ�ȡ2Ϊ�̶�Ƶ�ʷ�Χ��f1,f2��(������ͨ�˲���ͨ����Χһ��)
flag_snr = 2;
    %��f_signal_range=2�������ù̶�Ƶ�ʷ�Χ(������ͨ�˲���ͨ����Χһ��)
    f_signal_range = [1,2.5];
%% ��������
load (XX);

%% ������ѡ��İ�����˹�˲����˲�,�������ֵ�����ӦƵ��ֵ���Լ������
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
xlabel('ʱ��/����');
ylabel('ÿ������������');
%set(gca,'xtick',[0:1:xdata(end)]) 
set(gca,'xtick',[0:5:xdata(end)]) 
RMSE = sqrt(mean((plotfreq-hr_true).^2));
% title([savedDataName,'   RMSE=',num2str(RMSE)],'Interpreter','none');
legend('�ο�����','��������')

save(['.\savedData_forDrawing\',savedDataName,'.mat'],'xdata','hr_true','plotfreq','savedDataName'); 

% ��У���ʾ�������н���
load chirp
sound(y,Fs)
