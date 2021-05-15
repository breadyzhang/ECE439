function [ cfo ] = estimate_cfo(rx_sym1,rx_sym2,fs)

load ../Mat_Files/Parameters.mat

%  ... add your code here ... %
phase = 0;
length = size(rx_sym1,2);
rx_sym2 = conj(rx_sym2);
rx_sym2 = transpose(rx_sym2);
% for m = 1:1:length
%     phase = phase + (rx_sym1(m) * rx_sym2(m)); 
% end
phase = angle(rx_sym1*rx_sym2);
cfo = -1*fs/(2*pi*length)*phase;
end