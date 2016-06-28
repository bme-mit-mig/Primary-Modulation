function scatter = estScatterSSENP( modProj, modFF, modWinCache  )
%ESTSCATTERSSENP SSENP algorithm on full-scale image
% Simple Scatter Estimation with Non-linear postprocessing

scatter = runCellImAlg(@estScatterSSENPcellIm, modProj, modFF, modWinCache );

end

