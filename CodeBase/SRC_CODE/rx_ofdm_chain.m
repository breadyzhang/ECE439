function [ bits_data ] = rx_ofdm_chain(rx_signal)

load ../Mat_Files/Parameters.mat

bits_data = [];

% Use this variable to help you set the data subcarriers from pilot
% subcarriers from unused subcarriers
subcarrier_config = ones(1,num_bins);
subcarrier_config(convert_bin_index_normal_to_fft(gaurd_bins,num_bins)) = 0;
subcarrier_config(convert_bin_index_normal_to_fft(pilots,num_bins)) = 3; 

% Use this variable to keep track at which sample you are in packet
current_index = 1;

%% PACKET DETECTION

%  ... add your code here ... %
start = packet_detection(rx_signal);
rx_signal = rx_signal(start,start+num_samples*num_bins);
%% CFO ESTIMATION AND CORRECTION

%  ... add your code here ... %
current_index = current_index + num_bins*4;
sym1 = rx_signal(1,current_index:current_index+num_bins-1);
sym2 = rx_signal(1,current_index+num_bins:current_index+num_bins*2-1);
cfo = estimate_cfo(sym1,sym2,fs);
rx_signal = correct_cfo(rx_signal,cfo,fs);
%% CHANNEL ESTIMATION

%  ... add your code here ... %
current_index = current_index + num_bins*2;
sym1 = rx_signal(1,current_index:current_index+num_bins-1);
sym2 = rx_signal(1,current_index+num_bins:current_index+num_bins*2-1);
H = estimate_channel(sym1,sym2);
rx_signal = correct_channel(rx_signal,H);
%% DECODING
for m = 1:1:num_syms_data

%  ... add your code here ... %
end
    
end