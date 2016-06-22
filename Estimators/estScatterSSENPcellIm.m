function scatter = estScatterSSENPcellIm(image, FF)

scatter = estScatterSSEcellIm(image, FF);

scatter(isnan(image)) = NaN;
scatter = repairScatter(scatter, 0.5);

end

