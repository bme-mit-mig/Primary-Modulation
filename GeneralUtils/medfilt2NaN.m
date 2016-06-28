function md = medfilt2NaN( a, r, fillNaNs )
%medfilt2NaN  fills NaNs with median value from the neighbours

d = padarray(a, [r, r], NaN);

    function m = med(x)
        m = median(x(~isnan(x)));
    end
    
[h, w] = size(d);

md = NaN(size(d));

for i = r+1:h-r
    for j = r+1:w-r          
        if ~isnan(d(i,j)) || fillNaNs     
            patch = d(i-r:i+r, j-r:j+r);
            md(i,j) = med(patch);
        end
    end
end
   
md = crop(md, size(a, 1));

end

