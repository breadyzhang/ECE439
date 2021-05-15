function [ packet_start_index ] = packet_detection(rx_signal)

load ../Mat_Files/Parameters.mat 

% Dc removal filter
alpha = 0.975; 
rx_signal = filter([1 -1], [1 -alpha], rx_signal);

threshold=241;

%  ... add your code here ... %
length = size(rx_signal,2);
% a = zeros(1,length);
% for m=1:1:length-103
%     windowA = rx_signal(1,m:m+51);
%     windowB = rx_signal(1,m+52:m+103);
%     powerA = 0;
%     powerB = 0;
%     for n=1:1:52
%        powerA = powerA + abs(windowA(1,n))^2;
%        powerB = powerB + abs(windowB(1,n))^2;
%     end
%     a(m) = powerB/powerA;
%     if powerB/powerA > threshold
%         packet_start_index = m;
%     end
% end
% x = 1:1:length;
% plot(x,a);
for m=1:1:length-103
    windowA = rx_signal(1,m:m+51);
    windowB = rx_signal(1,m+52:m+103);
    powerA = 0;
    powerB = 0;
    for n=1:1:52
       powerA = powerA + abs(windowA(1,n))^2;
       powerB = powerB + abs(windowB(1,n))^2;
    end
    if powerB/powerA > threshold
        packet_start_index = m;
        break;
    end
end
end