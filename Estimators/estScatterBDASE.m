function scatter = estScatterBDASE(modProj, modFF, cutOffReq, cellWinCache )
%estScatterBDASE BDASE algorithm on full-scale image
% Basic Demodulation Based Analytical Scatter Estimation

if ~exist('cutOffFreq', 'var')
    cutOffReq = 0.2;
end

scatter = runCellImAlg(@(proj, ff) estScatterBDASEcellIm(proj, ff, cutOffReq), modProj, modFF, cellWinCache );

end