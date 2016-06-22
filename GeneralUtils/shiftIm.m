function shifted = shiftIm(img, shiftVector)
% SHIFTIM shifts the image using zero padding
%  shiftVector  [horizontal, vertical] can be floating point

T = maketform('affine', [1 0 0; 0 1 0; shiftVector(1) shiftVector(2) 1]);   %# represents translation
shifted = imtransform(img, T, ...
    'XData',[1 size(img,2)], 'YData',[1 size(img,1)]);

end