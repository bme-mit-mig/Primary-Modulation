function pos = findModCells(image, polySmooth)
%findModCells  estimates modulator cell locations without much prior knowledge
%about the geometry.
% It finds every other bright cell.
% The cell size can be 15..25 pixel.
% Returns a struct with two matrices containing the horizontal and vertical
% coordinates. 

% It handles nonlinear geometric distortions, which occures in
% tomosynthesis when the modulator is attached to the collimator


% calculating the distance between horizontal modulator points
q = round(linspaceC(1530/2, 50, 10));
for i = 1:10
    % cell size is restricted by estModCellDist
    dH(i) = estModCellDist(image(q(i), :));
end

dH = median(dH);

imSize = size(image, 1);

originalImage = image;

% noise reduction
g = fspecial('gaussian', [13 13], 2);
% originalImage = imfilter(medfilt2(originalImage),g);
originalImage = imfilter(originalImage, g, 'symmetric');


% distance between two sampling point
r = dH/2;
image = enhanceModulator(originalImage, r);

% search radius
sr = r / 3;

% the coord of the central sampling array element
center = maxLocAroundSubPix(image, [imSize/2, imSize/2], r+1);

% num of sampling points = R*2+1
R = 19;

hadError = true;


    function [x, y] = findHMidLine(c)
        left_ = NaN(R, 2);
        right_ = NaN(R, 2);

        % finding horizontal midline points
        p = c;
        for i = 1:R
            p = maxLocAroundSubPix(image, p + [0, dH], sr);
            right_(i,:) = p;
        end

        p = c;
        for i = 1:R
            p = maxLocAroundSubPix(image, p - [0, dH], sr);
            left_(i,:) = p;
        end

        hline = [flipud(left_)', c', right_'];

        x = hline(2,:);
        y = hline(1,:);
        x = smooth(x, R, 'rloess');
        y = smooth(y, R, 'rloess');
    end


% looping while we find an appropriate R
while hadError
    try
        R = R - 1;
        D = R*2+1;
        posV = NaN(D, D);
        posH = NaN(D, D);
        posV2 = NaN(D, D);
        posH2 = NaN(D, D);
        
        % checking at different heights
        nl = 5;
        q = linspaceC(center(1), dH*2, nl);
        xss = NaN(nl, 2*R+1);
        yss = NaN(nl, 2*R+1);
        for u = 1:nl
            [xss(u,:), yss(u,:)] = findHMidLine([q(u), center(2)]);
        end
        
        % vertical modP distance
        dV = median(yss(nl,:) - yss(1,:))/(nl-1);
        
        % robust central horiz line detection
        yss = yss - linspaceC(0, dV*2, nl)' * ones(1,D);
        xs = median(xss, 1);
        ys = median(yss, 1);
        

        % finding points along vertical lines
        left = NaN(R, 2);
        right = NaN(R, 2);
        for i = (-R:R)+R+1
            p = [ys(i), xs(i)];
            for j = 1:R
                p = maxLocAroundSubPix(image, round(p + [dV, 0]), sr);
                right(j,:) = p;
            end

            p = [ys(i), xs(i)];
            for j = 1:R
                p = maxLocAroundSubPix(image, round(p - [dV, 0]), sr);
                left(j,:) = p;
            end

            vline = [flipud(left)', [ys(i), xs(i)]', right'];
            posV(:,i) = vline(1,:);
            posH(:,i) = vline(2,:);
        end

        hadError = false;
    catch
        hadError = true;
    end
end


ps.V =posV;
ps.H = posH;
% showSamplingPoints(image, ps);

posHsm = polySmooth2D(posH, 'poly22');
posVsm = polySmooth2D(posV, 'poly22');

% second iteration of localization
for i = 1:2*R+1
    for j = 1:2*R+1
        p = maxLocAroundSubPix(image, [posVsm(i,j), posHsm(i,j)], 4);
        posV2(i,j) = p(1);
        posH2(i,j) = p(2);
    end
end

% % second smoothing
if polySmooth
    posH = polySmooth2D(posH2, 'poly22');
    posV = polySmooth2D(posV2, 'poly22');
else
    posV = posV2;
    posH = posH2;
end

pos.V = posV;
pos.H = posH;


end
