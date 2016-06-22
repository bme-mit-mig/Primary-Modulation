function scatter = estScatterBDASEcellIm(image, FF, svf)
%svf: vagasi frekvenciaja a Gauss szuronek felul/alul ateresztesnel


% simulating fix alpha -> new FF
[ odd, even ] = decompPModulatorOddEven(FF);
odd = ones(size(odd)) * mean(odd(~isnan(odd)));
even = ones(size(even)) * mean(even(~isnan(even)));
FF = composePModulator(even, odd);

scatter = estScatterADASEcellIm(image, FF, svf);

end