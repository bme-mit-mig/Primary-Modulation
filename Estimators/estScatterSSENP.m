function scatter = estScatterSSENP( image, FF )
%ESTSCATTERSSE SSE algorithm

scatter = runCellImAlg(@estScatterSSENPcellIm, image, FF);

end

