function scatter = estScatterADASE(image, FF, svf)
%svf: vagasi frekvenciaja a Gauss szuronek felul/alul ateresztesnel

if ~exist('svf', 'var')
    svf = 0.2;
end

scatter = runCellImAlg(@(im, ff) estScatterADASEcellIm(im, ff, svf), image, FF);

end