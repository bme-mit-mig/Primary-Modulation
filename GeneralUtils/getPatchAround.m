function patch = getPatchAround( image, point, radius )
%GETPATCHAROUND clips a patch from the image around point with radius
%   point contains the coordinates of the middle of the patch (y,x)

patch = image(point(1) - radius : point(1) + radius, point(2) - radius : point(2) + radius);

end

