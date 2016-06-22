function smoothed = boxFilterIntegImage(image, boxR)
% boxFilterIntegImage applies a box filter on image with zero padding
% box size = boxR*2+1;
% the result is not devided by the area of the kernel

[h, w] = size(image);

padded = padarray(image, [boxR, boxR]);
II = integralImage(padded);

n = boxR*2+1;

A = II(1:h, 1:w);
B = II(1:h, 1+n:end);
C = II(1+n:end, 1:w);
D = II(1+n:end, 1+n:end);

smoothed = D+A-B-C;

end