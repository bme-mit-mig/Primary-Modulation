%% loading sample data
load('sample.mat')

% modFF   : modulated flood-field image
% modProj : modulated projection image / the image to correct for scatter
%it is a real projection of the LUNGMAN phantom with our modulator

%% finding cells
polySmooth = true;
% a rectangular grid of unattenuated cells / every other cell
cellLocs0 = findModCells(modFF, polySmooth);
close all; figure; showCellLocations(modFF, cellLocs0);

%% a rectangular grid of all the cells, even non-visible cells
cellLocs = doubleSamplePoints( extrapolSamplingPoints( cellLocs0, 5));
close all; figure; showCellLocations(modFF, cellLocs);

%% creation and decomposition of cell-images
winRadius = 6;
winType = 'cos';
% precalculating cell masks into a cache
cache = createCellImCache(size(modFF, 1), cellLocs, winRadius, winType);

% cell-images
cellImModFF = getCellImCached(cache, modFF);
cellImModProj = getCellImCached(cache, modProj);

close all;
figure;imagesc(cellImModFF)
figure;imagesc(cellImModProj)

%% SSE algorithm

% sigma of gauss
sigma = 0.9;

% attenuated, unattenuated
[a, u] = decompPModulatorGauss(cellImModProj, sigma);
[aFF, uFF] = decompPModulatorGauss(cellImModFF, sigma);

% alpha image
alpha = aFF./uFF;

% scatter estimation formula
cellImScatter = (a - alpha.*u) ./ (1-alpha);

close all;
figure; imagesc(cellImScatter);

%% upscaling
scatter = upSampleInterpol(cellImScatter, cache.cellLocs);
imagesc(scatter)

%% smoothing
smoothedScatter = imgaussfilt(scatter, 70);
imagesc(smoothedScatter);

%% how to call it
scatter = estScatterSSE(modProj, modFF);
imagesc(scatter);

%% executing a cell-image based algorithm for full-scale images
scatter = runCellImAlg(@estScatterSSEcellIm, modProj, modFF, cache);
imagesc(scatter);

%% scatter correction
corrected = (modProj-smoothedScatter) ./ modFF;
imagesc(corrected);