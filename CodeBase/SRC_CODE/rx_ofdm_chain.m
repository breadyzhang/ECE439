function [ bits_data ] = rx_ofdm_chain(rx_signal)

load ../Mat_Files/Parameters.mat

bits_data = zeros(1,num_bins_data*num_syms_data);

% Use this variable to help you set the data subcarriers from pilot
% subcarriers from unused subcarriers
subcarrier_config = ones(1,num_bins);
subcarrier_config(convert_bin_index_normal_to_fft(gaurd_bins,num_bins)) = 0;
subcarrier_config(convert_bin_index_normal_to_fft(pilots,num_bins)) = 3; 

% Use this variable to keep track at which sample you are in packet
current_index = 1;

%% PACKET DETECTION

%  ... add your code here ... %
if size(rx_signal,2) == 1
    rx_signal = rx_signal.';
start = packet_detection(rx_signal);
rx_signal = rx_signal(start:start+num_samples);
current_index = current_index + num_bins*4;
%% CFO ESTIMATION AND CORRECTION

%  ... add your code here ... %
sym1 = rx_signal(current_index:current_index+num_bins-1);
sym2 = rx_signal(current_index+num_bins:current_index+num_bins*2-1);
cfo = estimate_cfo(sym1,sym2,fs);
rx_signal = correct_cfo(rx_signal,cfo,fs);
current_index = current_index + num_bins*2;
%% CHANNEL ESTIMATION

%  ... add your code here ... %
sym1 = rx_signal(1,current_index:current_index+num_bins-1);
sym2 = rx_signal(1,current_index+num_bins:current_index+num_bins*2-1);
H = estimate_channel(sym1,sym2);
current_index = current_index +num_bins*2 + cp;
%% DECODING

for m = 1:1:num_syms_data

%  ... add your code here ... %
    current_index = current_index+cp*3/4;
    Y = rx_signal(current_index:current_index+num_bins-1);
    Y = fft(Y);
    Y = correct_channel(Y,H);
    [r_cfo,r_sfo] = estimate_residual_cfo_sfo(Y,H);
    H = correct_residual_cfo_sfo(h,r_cfo,r_sfo);
    offset = 0;
    for n=1:1:size(Y,2)
        if sum(gaurd_bins == convert_bin_index_fft_to_normal(n,num_bins)) == 0 && sum(pilots == convert_bin_index_fft_to_normal(n,num_bins)) == 0
            data = real(Y(n));
            if ceil(data) || floor(data) == 1
                bits_data(num_bins_data*(m-1)+n-offset)=0;
            else
                bits_data(num_bins_data*(m-1)+n-offset)=1;
            end
        else
            offset = offset + 1;
        end
    end
    current_index = current_index + cp/4;
end
    
end