function scatter = estScatterSSEcellIm(proj, FF)
%%estScatterSSEcellIm SSE algorithm on cell-images

% sigma of gauss
sigma = 0.9;

% attenuated, unattenuated
[a, u] = decompPModulatorGauss(proj, sigma);
[aFF, uFF] = decompPModulatorGauss(FF, sigma);

alpha = aFF./uFF;
scatter = (a - alpha.*u) ./ (1-alpha);
    
% filling empty values and smoothing
% it removes the 1 cell sized ripples near strong edges
% it can be substituted by fullscale image based smoothing as well
scatter = imfilter(fillNaNsCheckerboard(scatter), [1,2,1;2,4,2;1,2,1]/16);  

end

