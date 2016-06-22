function repaired = repairScatter(sample, threshold)
% repairScatter changes the outlier values to their corresponding smoothed
% one

nanMask = isnan(sample);
smoothed = scatterSmoothLowess(sample, 0.25, false);
% smoothed = imfilter(sample, fspecial('gauss', 400, 100), 'replicate');

dif = abs(sample - smoothed);
mask = dif > threshold * median(sample(~nanMask));
mask = imdilate(mask, strel('disk', 3));
repaired = sample;
repaired(mask) = NaN;

repOld = sample;
repNew = repaired;

while mean(repOld(~nanMask) ~= repNew(~nanMask)) > 0
    repOld = repNew;
    repNew = changeNaNsToMedian(repOld, 1);
end

repaired = repNew;
repaired = imfilter(repaired, fspecial('gauss', 3, 1));
repaired(~mask) = sample(~mask);

repaired(nanMask) = NaN;

end