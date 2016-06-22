function scatter = estScatterSSEcellIm(image, FF)
% Works on sampled images

sigma = 0.9;
[a, u] = decompPModulatorGauss(image, sigma);
[aFF, uFF] = decompPModulatorGauss(FF, sigma);

alpha = aFF./uFF;
scatter = (a - alpha.*u) ./ (1-alpha);
    
scatter = imfilter(fillNaNsCheckerboard(scatter), [1,2,1;2,4,2;1,2,1]/16);  

end

