function scatter = runCellImAlg( alg, image, FF )
%RUNCELLIMALG extract cell images and calls alg with it
%   It returns with a full scatter image not cell image

% getting cached mod points from mpGlobal, or find them on FF
mp = getModPoints(FF);

% sampling at modulator cell points
% sampleImage = getSampleWin(image, mp);
% sampleFF = getSampleWin(FF, mp);

global cache;
sampleImage = getCellImCached(cache, image);
sampleFF = getCellImCached(cache, FF);


sampleScatter = alg(sampleImage, sampleFF);

scatter = upSampleInterpol(sampleScatter, mp);

end

