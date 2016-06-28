function scatter = estScatterSSENPcellIm(proj, FF)

% calling SSE
scatter = estScatterSSEcellIm(proj, FF);

% replacing outliers
scatter(isnan(proj)) = NaN;
scatter = repairScatter(scatter, 0.5);

end

