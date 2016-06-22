function modImage = composePModulator( even, odd )
%composePModulator creates a downsample modulator image from its two
%components

    modImage = zeros(size(even));
    
    [h, w] = size(even);
    
    for i = 1:h
        for j = 1:w            
            if mod(i+j, 2) == 0
                modImage(i,j) = even(i,j);
            else
                modImage(i,j) = odd(i,j);
            end
        end
    end

end

