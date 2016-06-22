function smoothed = scatterSmoothLowess( scatter, span, robust, weights )
%scatterSmooth smooths the sampled scatter
% if robust is true, it will use LAR

% span ~0.05


[h,w] = size(scatter);
[X,Y] = meshgrid(1:h, 1:w);
mask = ~isnan(scatter);


% Set up fittype and options.
ft = fittype( 'loess' );
opts = fitoptions( 'Method', 'LowessFit' );
opts.Normalize = 'on';

if exist('robust', 'var') && robust
    opts.Robust = 'LAR';
end

opts.Span = span;
if exist('weights', 'var');
    opts.Weights = weights(mask);     
end

xData = X(mask);
yData = Y(mask);
zData = scatter(mask);

% Fit model to data.
[f, gof] = fit( [xData, yData], zData, ft, opts );

mg = [X(:), Y(:)];
smoothed = reshape(feval(f, mg), [h, w]);

end

