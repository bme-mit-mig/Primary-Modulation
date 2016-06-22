function showSamplingPoints(image, pos)

mark = zeros(size(image));
imsize = size(image, 1);

[h, w] = size(pos.V);

for i = 1:h
    for j = 1:w                
        for x = -1:1
            for y = -1:1             
                yy = round(pos.V(i,j)+x);
                xx = round(pos.H(i,j)+y);
                if (xx > 0 && xx <= imsize && yy > 0 && yy <= imsize) 
                    mark(yy, xx) = 1;                
                end
            end
        end
    end
end

image(logical(mark)) = range(image(:));
imshown(image);


end