function corrected = changeNaNsToMedian(im, medianRadius)
%changeNaNsToMedian changes NaNs to median values

wrongOnes = find(padarray(isnan(im), [1 1] * medianRadius, false));
padded = padarray(im, [1 1] * medianRadius, NaN);
corrected = padded;


for i = wrongOnes'    
    [I,J] = ind2sub(size(padded), i);
    p = [I,J];
    patch = getPatchAround(padded, p, medianRadius);
    med = median(patch(~isnan(patch)));
    corrected(i) = med;
end

r = medianRadius;
corrected = corrected(1+r:end-r, 1+r:end-r);