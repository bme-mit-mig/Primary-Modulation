function scatInterp = estScatterGSE(image, FF, scatterRange)


[h,w] = size(FF);


n = 200;
scatterLevels = linspace(scatterRange(1), scatterRange(2), n);

f = NaN(h,w,n);

    for i = 1:n      
        dv = zeros(1530);
        dh = dv;
        a = (image - scatterLevels(i)) ./ FF;
        dv(2:end,:) = abs(diff(a, 1, 1));
        dh(:, 2:end) = abs(diff(a, 1, 2));
        d = sqrt(dv.^2+dh.^2);
        f(:,:,i) = imfilter(d, ones(43));
    end

    [~, idx] = min(f,[], 3);
    est = scatterLevels(squeeze(idx));

    % simulation of calculating only for 2x2 cells
    grid = 20:43:1530;
    [X,Y] = meshgrid(grid);
    [Xq,Yq] = meshgrid(1:1530);

    scatInterp = interp2(X,Y, est(grid,grid), Xq, Yq);
    scatInterpSpline = interp2(X,Y, est(grid,grid), Xq, Yq, 'spline');
    scatInterp(isnan(scatInterp)) = scatInterpSpline(isnan(scatInterp));
 