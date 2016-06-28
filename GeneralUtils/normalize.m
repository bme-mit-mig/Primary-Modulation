function norm = normalize(im)
% normalize  maps to [0..1] interval

norm = normalizeMax( im - min(im(:)) );