function [ H ] = estimate_channel(rx_sym1,rx_sym2)

load ../Mat_Files/Parameters.mat 

%  ... add your code here ... %
H = zeros(1,num_bins);
preamble = zeros(1,num_bins);
for m=1:1:size(bits_preamble,2)
    index = 0;
    if m > 26
        index = m+12;
    else
        index = m+1;
    end
    if bits_preamble(m) == 1
        preamble(index)= -1;
    else
        preamble(index) = 1;
    end
end
for m=1:1:num_bins
%     fftbin = convert_bin_index_fft_to_normal(m, num_bins);
%     if sum(gaurd_bins == fftbin) == 0
    if preamble(m) ~= 0
        H(m) = (rx_sym1(m)+rx_sym2(m))/(2*preamble(m));
    end
end
end