function scatter = estScatterSSE( modProj, modFF )
%ESTSCATTERSSE SSE algorithm

scatter = runCellImAlg(@estScatterSSEcellIm, modProj, modFF);

end

