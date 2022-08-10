function [ X_2 ] = f_pre_process( X )
for i=1:3
    % x=signal2;
    x=X(i,:);
    t=[0:1/30:30];
    %����ͼ
    % figure()
    % plot(t(2:end), x);
    % xlabel('Time / (s)');ylabel('����ֵ');
    % title('ԭʼ�ź�');
    
    %% �ź�Ԥ������׼��+ȥ���ƣ�
    %��׼��
    x1 = (x-mean(x))/std(x);
    % figure()
    % plot(t(2:end), x1);
    % axis([0 30 -3 3]);
    % xlabel('Time / (s)');ylabel('����ֵ');
    % title('��׼��');
    
    T = length(x1);
    lambda = 1000;
    I = speye(T);
    D2 = spdiags(ones(T-2,1)*[1 -2 1],[0:2],T-2,T);
    x2 = (I-inv(I+lambda^2*D2'*D2))*x1';
    % figure()
    % plot(t(2:end), x2);
    % %axis([0 30 -3 3]);
    % xlabel('Time / (s)');ylabel('����ֵ');
    % title('ƽ������_ȥ����');
    X_1(i,:)=x2;
end
%�����ӳٱ任
for i=1:3
    X_2(1, :, i)=X_1(i, 1:end-2);
    X_2(2, :, i)=X_1(i, 2:end-1);
    X_2(3, :, i)=X_1(i, 3:end);
end

end

