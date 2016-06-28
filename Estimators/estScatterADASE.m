function scatter = estScatterADASE(modProj, modFF, cutOffFreq)
%estScatterADASE ADASE algorithm on full-scale image
% Advanced Demodulation Based Analytical Scatter Estimation

if ~exist('cutoffFreq', 'var')
    cutOffFreq = 0.2;
end

scatter = runCellImAlg(@(proj, ff) estScatterADASEcellIm(proj, ff, cutOffFreq), modProj, modFF);

end