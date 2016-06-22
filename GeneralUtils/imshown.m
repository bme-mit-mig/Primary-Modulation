function imshown(img, gain)
% imshown  imshow with normalization
% gain  multiplier after normalization
    
    if ~exist('gain', 'var')
        gain = 1;
    end
    
    img(isnan(img)) = 0;
    imshow(normalize(img)*gain);

end