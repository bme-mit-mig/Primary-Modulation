function image = upSampleInterpol( sample, pos )
%#codegen
%UPSAMPLE from a sample it recreates the full size image using poly55
% posV, posH pixel coords
% sample may contain NaNs

imsize = 1530;
frame = 30;
imsizeExt = imsize+frame*2;
pos.H = pos.H + frame;
pos.V = pos.V + frame;

mask = isnan(sample);
sampleMed = sample;

for i = 1:3
    sampleMed = medfilt2NaN(sampleMed, 1+i, true);
end

sample(mask) = sampleMed(mask);
mask = ~isnan(sample);

ft = 'linearinterp';

% Fit model to data.
[X,Y] = meshgrid(1:imsizeExt, 1:imsizeExt);
sf = fit( [pos.H(mask), pos.V(mask)], sample(mask), ft);
mg = [X(:), Y(:)];
image = reshape(feval(sf, mg), [imsizeExt, imsizeExt]);


% [X,Y] = meshgrid(1:imsizeExt, 1:imsizeExt);
% sf = fit( [pos.H(mask), pos.V(mask)], sampleMed(mask), 'poly55');
% mg = [X(:), Y(:)];
% imagePoly = reshape(feval(sf, mg), [imsizeExt, imsizeExt]);
% 
% image(isnan(image)) = imagePoly(isnan(image));

% image = imfilter(image, fspecial('gaussian', 50,15), 'symmetric');

image = crop(image, imsize);

end

