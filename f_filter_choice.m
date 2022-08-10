function [output_9max_fre,output_9max_fuzhi,output_snr] = f_filter_choice(record_X_after_iva,flag_bp,fs,flag_snr,f_signal_range)
for iter = 1:length(record_X_after_iva)
    X_after_iva = record_X_after_iva{iter};
    %% 巴特沃斯带通滤波
    % 使用命令fdatool设计巴特沃斯带通滤波器，通带0.7-2.5Hz
    % 展示波形和频谱
    for i=1:3
        for j=1:3
            if flag_bp==12
                X_after_filter(i, :, j)=filter(filter_BP_1_2(fs),X_after_iva(i, :, j));
            elseif flag_bp==13
                X_after_filter(i, :, j)=filter(filter_BP_1_3(fs),X_after_iva(i, :, j));
            elseif flag_bp==125
                X_after_filter(i, :, j)=filter(filter_BP_1_25(fs),X_after_iva(i, :, j));
            elseif flag_bp==62 
                X_after_filter(i, :, j)=filter(filter_BP_06_2(fs),X_after_iva(i, :, j));
            elseif flag_bp==72 
                X_after_filter(i, :, j)=filter(filter_BP_07_2(fs),X_after_iva(i, :, j));
            
            end
        end
    end
    
    L=length(X_after_filter(3, :, 1));
    NFFT = L;
    f=fs/2*linspace(0,1,NFFT/2+1);
    
    for i=1:3
        for j=1:3
            Y1=fft(X_after_filter(j, :, i),NFFT).^2/L;
            Y(3*(i-1)+j,:) = 2*abs(Y1(1:NFFT/2+1));
            
            x = find(Y(3*(i-1)+j,:)==max(Y(3*(i-1)+j,:)));
            output_9max_fre(iter,3*(i-1)+j) = f(x);
            output_9max_fuzhi(iter,3*(i-1)+j) = Y(3*(i-1)+j,x);
            %信噪比
            if flag_snr == 1
                output_snr(iter,3*(i-1)+j) = snr(f, Y(3*(i-1)+j,:),f_signal_range);
            elseif flag_snr == 2
                output_snr(iter,3*(i-1)+j) = snr_v2(f, Y(3*(i-1)+j,:),f_signal_range);

        end
    end
%     record_X_after_iva{iter} = X_after_iva;
%     output_fre(iter,:) = f_try_autotest(Y, f);
end
end