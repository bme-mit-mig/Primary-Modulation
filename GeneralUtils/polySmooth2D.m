function smoothed = polySmooth2D( data, fitType )
%POLYSMOOTH2D smooths a matrix by a polynomial surface
%   fitType    optional - fitType paramter of fit matlab function

if ~exist('fitType','var')
    fitType = 'poly33';    
end

[h,w] = size(data);
    
[X,Y] = meshgrid(1:w, 1:h);
sf = fit( [X(:), Y(:)], data(:), fitType);
mg = [X(:), Y(:)];
smoothed = reshape(feval(sf, mg), [h, w]);
            
end

