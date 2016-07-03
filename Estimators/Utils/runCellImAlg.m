function scatter = runCellImAlg( alg, modProj, modFF, cellWinCache )
%RUNCELLIMALG extract cell-images and calls alg with it
%   It returns a full-scale scatter image not a cell image
% alg          : function handler for the cell-image based scatter estimator
% modProj      : the modulated image
% modFF        : flood-field image of the modulator
% cellWinCache : cache containing precalculated positioned windows for each
% cell

cellImModProj = getCellImCached(cellWinCache, modProj);
cellImModFF   = getCellImCached(cellWinCache, modFF);

% calling alg
cellImScatter = alg(cellImModProj, cellImModFF);

% recreating a fullscale image
scatter = upSampleInterpol(cellImScatter, cellWinCache.cellLocs);

end

