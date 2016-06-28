function scatter = runCellImAlg( alg, modProj, modFF, cache )
%RUNCELLIMALG extract cell images and calls alg with it
%   It returns with a full scatter image not cell image
% alg : function handler for the cell-image based scatter estimator
% image : the modulated image
% modFF : flood-field image of the modulator

cellImModProj = getCellImCached(cache, modProj);
cellImModFF   = getCellImCached(cache, modFF);

% calling alg
cellImScatter = alg(cellImModProj, cellImModFF);

% recreating a fullscale image
scatter = upSampleInterpol(cellImScatter, cache.cellLocs);

end

