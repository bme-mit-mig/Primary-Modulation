function checkerboard = checkerBoard( gridSize, n )
%chekerBoard creates a n*n checkerboard
%   gridSize   size of a field
%   n          number of fields have to be even

checkerboard = repmat([ones(gridSize), zeros(gridSize); zeros(gridSize), ones(gridSize)], ceil(n / 2));
checkerboard = checkerboard(1:n*gridSize, 1:n*gridSize);

end

