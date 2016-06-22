function scatter = estScatterADASEcellIm(image, FF, svf)
%svf: vagasi frekvenciaja a Gauss szuronek felul/alul ateresztesnel


% this is hardcoded!!\s
% it works mainly for central projections
l = 10:81;


scatter = NaN(size(FF));
scatter(l,l) = sest_demod4(image(l,l), svf, FF(l,l), 1);

end