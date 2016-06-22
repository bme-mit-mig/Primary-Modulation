function filtered = imfilterWeightedPad(image, kernel, weights)

padSize= round(max(size(kernel)) / 2);
[h,w] = size(image);
paddedWeights = zeros([h,w] + 2*padSize);
paddedIm = paddedWeights;

imMask = ~isnan(image);
image(~imMask) = 0;

paddedIm((1:h)+padSize, (1:w)+padSize) = image;
% weights((1:h)+padSize, (1:w)+padSize) = ones([h,w]);


if exist('weights', 'var')
    paddedWeights((1:h)+padSize, (1:w)+padSize) = weights;
else
    % handling NaNs as unknown values
    paddedWeights((1:h)+padSize, (1:w)+padSize) = imMask;
end
filtered = imfilter(paddedIm.*paddedWeights, kernel) ./ imfilter(paddedWeights, kernel);
filtered = filtered((1:h)+padSize, (1:w)+padSize);

end