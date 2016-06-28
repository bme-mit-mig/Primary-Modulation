function scatter = estScatterSSENP( modProj, modFF )
%ESTSCATTERSSENP SSENP algorithm on full-scale image
% Simple Scatter Estimation with Non-linear postprocessing

scatter = runCellImAlg(@estScatterSSENPcellIm, modProj, modFF);

end

