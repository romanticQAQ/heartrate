addpath('pca_ica');
clear all
close all
%% �������û���:��ʼ
%% ��ȡ��Ƶ����
XX='.\data_video_3ROI\data_1-1_ROI.mat'; %���������ļ���:ע�⣺����������һ��
%% �˲���ѡ��
flag_bp = 072; % ��ͨ�˲���Ƶ��ѡ��
%% ��ȡ������ʵֵ���ļ���
trueHr_name='.\savedData_forDrawing\data_1_1';
%% Ƶ�ʲ���ѡ��
flag_choice=2; %1Ϊֱ��ȡƽ����2Ϊȡ��ֵ���
%% �������û���:����
load(XX); %��ȡ��������

for iter = 1: length(X_tensor)

temp=X_tensor{iter};
X_comp(1,:)=temp(1,:,1);
X_comp(2,:)=temp(1,:,2);
X_comp(3,:)=temp(1,:,3);
%% �˲�
for i=1:3
    if flag_bp==12
        X_after_filter(i,:)=filter(filter_BP_1_2(fs),X_comp(i,:));
    elseif flag_bp==13
        X_after_filter(i,:)=filter(filter_BP_1_3(fs),X_comp(i,:));
    elseif flag_bp==125
        X_after_filter(i,:)=filter(filter_BP_1_25(fs),X_comp(i,:));
    elseif flag_bp==62
        X_after_filter(i,:)=filter(filter_BP_06_2(fs),X_comp(i,:));
    elseif flag_bp==72
        X_after_filter(i,:)=filter(filter_BP_07_2(fs),X_comp(i,:));
    end
end

[Zica, W, T, mu] = fastICA(X_after_filter,3);


for i=1:3
frame_num=size(Zica);
t=(1:1:frame_num(2));
singal=Zica(i,:);

L=frame_num(2);
f = fs*(0:(L/2))/L;
Y = fft(singal);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
%��ͼ
% figure();plot(f,P1) 
% xlabel('f (Hz)')
% ylabel('|P1(f)|')

[ampl,pos]=max(P1);
temp_plot_fre_ica(i)=f(pos)*60;
temp_ampl(i)=ampl;
end
if flag_choice==1
    plot_fre_ica(iter)=mean(temp_plot_fre_ica);
elseif flag_choice==2
    [ampl,pos]=max(temp_ampl);
    plot_fre_ica(iter)=temp_plot_fre_ica(pos);
end

end
load(trueHr_name, 'hr_true','savedDataName');

xdata=[1:length(plot_fre_ica)]/2;

figure(22)
plot(xdata,hr_true,'k',xdata,plot_fre_ica,'r');
ylim([30, 120]);
xlim([0,xdata(end)]);
% title(savedDataName)
xlabel('ʱ��/����');
ylabel('ÿ������������');
set(gca,'xtick',[0:1:xdata(end)]) 
RMSE = sqrt(mean((plot_fre_ica-hr_true).^2));
title([savedDataName,'   RMSE=',num2str(RMSE)],'Interpreter','none');
legend('�ο�����','ica��������')

load(['.\savedData_forDrawing\',savedDataName,'.mat'],'xdata','hr_true','plotfreq','savedDataName','plot_fre_emd'); 
save(['.\savedData_forDrawing\',savedDataName,'.mat'],'xdata','hr_true','plotfreq','savedDataName','plot_fre_emd','plot_fre_ica'); 


% ��У���ʾ�������н���
load chirp
sound(y,Fs)