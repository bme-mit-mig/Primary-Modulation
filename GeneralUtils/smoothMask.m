function smoothed = smoothMask( mask, radius )
%smoothMask smooths the transfer between the 0/1 regions keeping the 0
%region untouched
% radius is the radius of the smoothing filter, cannot be larger than frame


eroded = double(imerode(mask, strel('disk', radius)));
smoothed = imfilter(eroded, fspecial('gauss', radius*2-1, radius));

% at corners zeros can change, it corrects it
smoothed(~mask) = 0;

end

