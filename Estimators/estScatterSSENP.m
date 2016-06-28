function scatter = estScatterSSENP( modProj, modFF )
%ESTSCATTERSSE SSE algorithm

scatter = runCellImAlg(@estScatterSSENPcellIm, modProj, modFF);

end

