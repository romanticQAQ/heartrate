function [xdata,plotfreq] = f_HR_curve(freq0,ampl0)
freq0 = freq0';
ampl0 = ampl0';
global k freq ampl res next
k = size(freq0,2);
freq = zeros(9, k+2);
ampl = zeros(9, k+2);
res = zeros(9, k+2) - 1;
next = zeros(9, k+2) - 1;

freq(:,1:k) = freq0;
ampl(:,1:k) = ampl0;

for i =0:8
    dp(i, 0);
end

tmax = -1;
first = -1;
for i = 0:8
    if (tmax < res(i+1,1))
        tmax = res(i+1,1);
        first = i;
    end
end

plotfreq = zeros(1,k);
plotampl = zeros(1,k);
xdata = (0:(k-1)).*30;

p = first;
plotfreq(1) = freq(p+1,1) *60;
plotampl(1) = ampl(p+1,1);
% print(p, 0, plotfreq(1)/60, plotfreq(1), ampl(p+1,1));
if_pass  = 0;

for j = 1:(k-1) 
    if if_pass == 1
        if_pass = 0;
    else
        flag = next(p+1,j);
        if flag < 9
            p = next(p+1,j);
            % 加入matlab版调整：p为-1时取最后一个值
            if p==-1
                p=8;
            end
            % 加入完
            plotfreq(j+1) = freq(p+1,j+1) *60;
            plotampl(j+1) = ampl(p+1,j+1);
%             print(p, j, plotfreq(j)/60, plotfreq(j), plotampl(j))
        else
            p = mod(next(p+1,j) , 9);
            plotfreq(j + 1+1) = freq(p+1,j + 1+1) * 60;
            plotampl(j + 1+1) = ampl(p+1,j + 1+1);
            plotfreq(j+1) = (freq(p+1,j + 1+1) * 60 + plotfreq(j)) / 2;
%             print(p + 9, j, plotfreq[j]/60, plotfreq[j])
%             print(p, j + 1, plotfreq[j + 1]/60, plotfreq[j + 1], plotampl[j + 1])            
            if_pass = 1;
        end
    end
end
% figure()
% plot(xdata,plotfreq);
% ylim([50, 200]);



end