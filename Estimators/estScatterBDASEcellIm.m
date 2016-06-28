function scatter = estScatterBDASEcellIm(proj, FF, cutOffFreq)
%estScatterBDASEcellIm  BDASE algorithm on cell-image


% simulating fix alpha -> new FF
[ odd, even ] = decompPModulatorOddEven(FF);
odd = ones(size(odd)) * mean(odd(~isnan(odd)));
even = ones(size(even)) * mean(even(~isnan(even)));
FF = composePModulator(even, odd);

scatter = estScatterADASEcellIm(proj, FF, cutOffFreq);

end