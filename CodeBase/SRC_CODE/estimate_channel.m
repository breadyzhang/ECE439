function [ H ] = estimate_channel(rx_sym1,rx_sym2)

load ../Mat_Files/Parameters.mat 

%  ... add your code here ... %
offset = 0;
fft1 = fft(rx_sym1);
fft2 = fft(rx_sym2);
H = zeros(1, num_bins);
for m=1:1:num_bins
    index = convert_bin_index_fft_to_normal(m,num_bins);
    if any(gaurd_bins == index)
        offset = offset + 1;
        H(m) = nan;
    else
        if bits_preamble(m-offset) == 0
            H(m) = (fft1(m)+fft2(m))/2;
        else
            H(m) = -1*(fft1(m)+fft2(m))/2;
        end
    end
end
end