function showCellLocations(image, cellLocations)

imshown(image);
hold on;
plot(cellLocations.H(:), cellLocations.V(:), 'r.')
hold off;

end