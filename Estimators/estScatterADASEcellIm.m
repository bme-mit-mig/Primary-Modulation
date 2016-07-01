function scatter = estScatterADASEcellIm(proj, FF, cutOffFreq)
%estScatterADASEcellIm  ADASE algorithm on cell-image

% this is hardcoded!!
% it works mainly for central projections
% does not tolarate NaN-s, so it have to be cropped
l = 10:81;

scatter = NaN(size(FF));
N = length(l); 
scatter(l,l)=scatest2conv(proj(l,l),N*cutOffFreq/3,FF(l,l));

end