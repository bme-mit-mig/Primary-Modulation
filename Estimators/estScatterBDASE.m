function scatter = estScatterBDASE(modProj, modFF, svf)
%svf: vagasi frekvenciaja a Gauss szuronek felul/alul ateresztesnel

if ~exist('svf', 'var')
    svf = 0.2;
end

scatter = runCellImAlg(@(proj, ff) estScatterBDASEcellIm(proj, ff, svf), modProj, modFF);

end