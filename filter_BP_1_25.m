function Hd = filter_BP_1_25(fs)
%FILTER_BP_07_25 Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.7 and Signal Processing Toolbox 8.3.
% Generated on: 24-Feb-2022 11:27:38

% Butterworth Bandpass filter designed using FDESIGN.BANDPASS.

% All frequency values are in Hz.
% Fs = 25;  % Sampling Frequency
Fs = fs;

N   = 6;    % Order
Fc1 = 1;  % First Cutoff Frequency
Fc2 = 2.5;  % Second Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandpass('N,F3dB1,F3dB2', N, Fc1, Fc2, Fs);
Hd = design(h, 'butter');

% [EOF]