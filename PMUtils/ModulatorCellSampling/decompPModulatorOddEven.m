function [ odd even ] = decompPModulatorOddEven( downsampled )
%decompPModulatorOddEven returns the blocked and the not blocked images in the
%same resolution using interpolation

d = downsampled;

    odd = zeros(size(d));
    even = zeros(size(d));

    [h, w] = size(d);
    for i = 1:h
        for j = 1:w
            if i == 1 && j == 1
                ipt = (d(1, 2) + d(2, 1))/2;
            elseif i == 1 && j == w
                ipt = (d(2, w) + d(1, w-1))/2;
            elseif i == h && j == w
                ipt = (d(h, w-1) + d(h-1, w))/2;
            elseif i == h && j == 1;
                ipt = (d(h, 2) + d(h-1, 1))/2;
            elseif i == 1
                ipt = (d(1, j-1) + d(1, j+1) + d(2, j))/3;
            elseif i == h
                ipt = (d(h, j-1) + d(h, j+1) + d(h-1, j))/3;
            elseif j == 1
                ipt = (d(i-1, 1) + d(i+1, 1) + d(i, 2))/3;
            elseif j == w
                ipt = (d(i-1, w) + d(i+1, w) + d(i, w-1))/3;
            else 
                ipt = (d(i-1, j) + d(i+1, j) + d(i, j-1) + d(i, j+1))/4;
            end
            
            if mod(i+j, 2) == 0
                even(i,j) = d(i,j);
                odd(i,j) = ipt;
            else
                even(i,j) = ipt;
                odd(i,j) = d(i,j);
            end
        end
    end


end

