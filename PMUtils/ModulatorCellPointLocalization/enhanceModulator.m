function enhanced = enhanceModulator( image, r )
%MODULATORENHANCER enhances the modulator on an image
%   image      the image of the modulator
%   r          distance between two sampling points

% shifts and adds copies of itself
% it smooths out other structures but keeps the modulator pattern

srd = shiftIm(image, [r, r]);
slu = shiftIm(image, [-r, -r]);
sld = shiftIm(image, [-r, r]);
sru = shiftIm(image, [r, -r]);
sd  = shiftIm(image, [0, r]);
sr  = shiftIm(image, [r, 0]);
sl  = shiftIm(image, [-r, 0]);
su  = shiftIm(image, [0, -r]);

enhanced = srd + slu + sld + sru - sd - sr - sl -su;
enhanced0 = enhanced;


% repairing edges
rPlus = 15;
R = ceil(r) + rPlus;           

top = (slu + sru) *4/2 - (sr + sl + su) *4/3;
enhanced(1:R,:) = top(1:R,:);

bottom = (sld + srd) *4/2 - (sr + sl + sd) *4/3;
enhanced(end-R:end,:) = bottom(end-R:end,:);

left = (sld + slu) *4/2 - (sd + sl + su) *4/3;
enhanced(:, 1:R) = left(:, 1:R);

right = (srd + sru) *4/2 - (sd + sr + su) *4/3;
enhanced(:, end-R:end) = right(:, end-R:end);

topLeft = slu * 4  - (sl + su) * 2;
enhanced(1:R, 1:R) = topLeft(1:R, 1:R);

topRight = sru * 4  - (sr + su) * 2;
enhanced(1:R, end-R:end) = topRight(1:R, end-R:end);

bottomLeft = sld * 4  - (sl + sd) * 2;
enhanced(end-R:end, 1:R) = bottomLeft(end-R:end, 1:R);

bottomRight = srd * 4  - (sr + sd) * 2;
enhanced(end-R:end, end-R:end) = bottomRight(end-R:end, end-R:end);


% mask of the part which is fully correct
RR = ceil(r + rPlus*0.8);
mask = zeros(size(image));
mask(1:RR, :) = 1;
mask(:, 1:RR) = 1;
mask(end-RR:end, :) = 1;
mask(:, end-RR:end) = 1;

% mixing
sMask = smoothMask(mask, floor(rPlus/2));
enhanced = sMask.*enhanced + (1-sMask).*enhanced0;

% enhanced only contained the shifted versions, but not the original one
enhanced = enhanced + image;

              
end

