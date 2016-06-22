function scatter = estScatterBDASE(image, FF, svf)
%svf: vagasi frekvenciaja a Gauss szuronek felul/alul ateresztesnel

if ~exist('svf', 'var')
    svf = 0.2;
end

scatter = runCellImAlg(@(im, ff) estScatterBDASEcellIm(im, ff, svf), image, FF);

end