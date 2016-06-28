function scatter = estScatterADASEcellIm(proj, FF, cutOffFreq)
%estScatterADASEcellIm  ADASE algorithm on cell-image

% this is hardcoded!!
% it works mainly for central projections
l = 10:81;


scatter = NaN(size(FF));
scatter(l,l) = sest_demod4(proj(l,l), cutOffFreq, FF(l,l), 1);

end