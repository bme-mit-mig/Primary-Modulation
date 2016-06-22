function scatter = estScatterSSE( image, FF )
%ESTSCATTERSSE SSE algorithm

scatter = runCellImAlg(@estScatterSSEcellIm, image, FF);

end

