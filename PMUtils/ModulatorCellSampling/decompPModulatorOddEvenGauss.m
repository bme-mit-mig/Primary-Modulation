function [ odd, even ] = decompPModulatorOddEvenGauss( sample, sigma )
%decompPModulatorOddEven returns the blocked and the not blocked images in the
%same resolution using interpolation

h = size(sample, 1);

mask = checkerBoard(1, h)  == 1;
even = sample;
odd = sample; 
even(mask) = NaN;
% kernel = fspecial('gaussian', [1 1] * round(sigma*8), sigma);
kernel = fspecial('gaussian', [1 1] * round(sigma*3)*2+1, sigma);
even = imfilterWeightedPad(even, kernel);
odd(~mask) = NaN;
odd = imfilterWeightedPad(odd, kernel);


end

