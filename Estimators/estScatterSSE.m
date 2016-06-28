function scatter = estScatterSSE( modProj, modFF )
%ESTSCATTERSSE SSE algorithm on full-scale image
% Simple Scatter Estimation

scatter = runCellImAlg(@estScatterSSEcellIm, modProj, modFF);

end

