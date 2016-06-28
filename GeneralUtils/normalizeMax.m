function norm = normalizeMax(im)
% normalizeMax  divides by the max value  

norm = im./max(im(:));