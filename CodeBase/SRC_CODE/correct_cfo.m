function [ rx_signal_no_cfo ] = correct_cfo(rx_signal,cfo,fs)

load ../Mat_Files/Parameters.mat

%  ... add your code here ... %
rx_signal_no_cfo = zeros(size(rx_signal));
length = size(rx_signal,2);
for m=1:1:length
    rx_signal_no_cfo(m) = rx_signal(m)*exp(-2j*pi*cfo*m/fs);
end
end