function scatter = estScatterLSGSE(modProj, modFF, numberOfLevels, radiusOfPatch, scatterRange, postSmoothSigma)
%estScatterLSGSE  LSGSE algorithm - Level Set Based GSE
% radiusOfPatch:    the radius of the patch for mean absolute gradient
% calculation
% scatterRange:     [min, max] possible scatter value
% postSmoothSigma:  sigma of gaussian filter applied at the end (0: no filtering)

n = numberOfLevels;
[h,w] = size(modProj);

a = zeros(h,w);


scatterLevels = linspace(scatterRange(1), scatterRange(2), n);

% stores the average abs gradients for each predefined scatter level
f = NaN(1530, 1530, n);

for i = 1:n      
    a = (modProj - scatterLevels(i)) ./ modFF;  % scatter corrected image with the given level
    dv0 = abs(diff(a, 1, 1));
    dh0 = abs(diff(a, 1, 2));
    dv = zeros(h,w); dh = zeros(h,w);
    dv(2:end,:) = dv0;
    dv(1:end-1,:) = dv(1:end-1,:) + dv0;
    dh(:, 1:end-1) = dh(:, 1:end-1) + dh0;
    dh(:, 2:end) = dh(:, 2:end) + dh0;
    d = dv + dh;
    f(:,:,i) = boxFilterIntegImage(d, radiusOfPatch);
end

[~, idx] = min(f,[], 3);
est = scatterLevels(squeeze(idx));

if postSmoothSigma > 0            
    scatter = imfilter(est, fspecial('gauss', 4 * postSmoothSigma, postSmoothSigma), 'replicate');
else
    scatter = est;
end

end



