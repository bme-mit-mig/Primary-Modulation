function cache = createCellImCache(imsize, samplingPos, r)
%getSampleWin  creates downsampled modulatorimage, by using a sinus window

% it is subpixel accurate

global samplingRadius;

if ~isempty(samplingRadius)
    r = samplingRadius;
elseif ~exist('r','var')
    r = 6;
end

    % these functions work in the range -r:r
%     function h = hannWin(p)
%         d = norm(p/r);
%         if (d >= -1 && d <= 1)            
%             h = sin((d/2+0.5)*pi)^2;
%         else
%             h = 0;
%         end
%     end

   function h = hannWin(p)
        if max(abs(p))/r <= 1     
            q = cos(p/r*pi/2).^2;
            h = q(1)*q(2);
        else
            h = 0;
        end
    end

    function h = rectWin(p)
        h = max(abs(p))<=r;
    end

    function h = diskWin(p)
        h = norm(p) <= r;
    end

    function h = cosWin(p)        
        if max(abs(p))/r <= 1     
            q = cos(p/r*pi/2);
            h = q(1)*q(2);
        else
            h = 0;
        end
    end

global useWinType;

% default is cos
% if ~exist('useWinType', 'var')
if isempty(useWinType)
    useWinType = 'cos';
end

switch useWinType
    case 'hann'
        win = @hannWin;
    case 'rect'
        win = @rectWin;
    case 'disk'
        win = @diskWin;
    case 'cos'
        win = @cosWin;
    otherwise
        win = @cosWin;
end
        

%imsize = size(image,1);

winsum = 0;
for y = -r:r
    for x = -r:r
        p = round([y x]);
        ww = win(p);
        winsum = winsum+ww;                
    end
end

% Threshold for considering it a real sampling point
% if it is too small it will be at image border
% for very small windows granularity can cause problems
if winsum < 10
    threshold = winsum * 0.2;
else
    threshold = winsum * 0.6;
end
    
[h,w] = size(samplingPos.V);

% default value is -1, it represents an unsuccessful sampling
% sample = zeros(h,w) -1;
cellCorners = NaN(h,w,5);
weights=zeros(imsize,imsize,'single');
for i = 1:h
    for j = 1:w                
        %s = 0;
        sumW = 0;
        center = [samplingPos.V(i,j), samplingPos.H(i,j)];
        for y = -r:r
            for x = -r:r
                p = round(center + [y x]);
                ww = win(p - center);
                if (p(1) >= 1 && p(1) <= imsize && p(2) >= 1 && p(2) <= imsize)
                    weights(p(1),p(2))=ww;
                    sumW = sumW+ww;
                    %s = s + ww * image(p(1), p(2));
                end
            end
        end
        % if there was at least one pixel on the image
        if (sumW > threshold)
            cellCorners(i, j,1) = sumW;
            cellCorners(i,j,2)=min(max(center(1)-r,1),imsize);
            cellCorners(i,j,3)=min(max(center(2)-r,1),imsize);
            cellCorners(i,j,4)=min(max(center(1)+r,1),imsize);
            cellCorners(i,j,5)=min(max(center(2)+r,1),imsize);            
        end
    end
end
cellCorners(:,:,2:5)=round(cellCorners(:,:,2:5));

cache.weights = weights;
cache.cellCorners = cellCorners;
end

