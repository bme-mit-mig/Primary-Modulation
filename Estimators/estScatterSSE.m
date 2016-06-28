function scatter = estScatterSSE( modProj, modFF, cellWinCache )
%ESTSCATTERSSE SSE algorithm on full-scale image
% Simple Scatter Estimation

scatter = runCellImAlg(@estScatterSSEcellIm, modProj, modFF, cellWinCache);

end

