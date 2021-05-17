function [ rx_sym_no_channel ] = correct_channel(rx_sym,H)

load ../Mat_Files/Parameters.mat

%  ... add your code here ... %
rx_sym_no_channel = zeros(1,num_bins);
for m=1:1:num_bins
    fftbin = convert_bin_index_fft_to_normal(m, num_bins);
    if sum(gaurd_bins == fftbin) == 0
        rx_sym_no_channel(m) = rx_sym(m)/H(m);
    else
        rx_sym_no_channel(m) = nan;
    end
end
end