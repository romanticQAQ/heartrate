clear all
close all

load('.\data_txt\data_20220319_1958.mat');
% load('.\savedData_20220702_2050.mat');
name_true_data_csv = '.\true_data_csv\20220319_1958.csv';
fs=30;%���ü��

% ��csv��ȡ��ʵֵ
%exp_data = zeros(20);
% exp_data = record_X_after_iva;
exp_data = record_X_after_iva_v0;

% ��ȡcsv��������
Mat = csvread(name_true_data_csv);
not = length(Mat)-length(exp_data)*fs;
% ������ÿ��ʮ��ȡƽ��ֵ���豣֤���������������30*��Ƶ��������ʵ���������ݸ�����
begin_point=length(Mat)-length(exp_data)*fs+1;
% begin_point=length(Mat)-length(exp_data)*fs-10;

for i=1:length(exp_data)
    true_data(i)=mean(Mat(begin_point:(begin_point+fs-1),1));
    begin_point=begin_point+fs;
end

% ������ÿ30��ȡƽ��ֵ
% begin_point=1;
% 
% for i=1:length(exp_data)
%     true_data(i)=mean(Mat(begin_point:(begin_point+fs-1),1));
%     begin_point=begin_point+fs;
% end
