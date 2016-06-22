function loc = maxLocAroundSubPix( A, point, searchRadius )
%maxLocAround finds the location of the maximum around the given point with
%subpixel resolution. It uses the 3x3 neighbourhood.
% point   [row, col]
        
        loc = maxLocAround( A, point, searchRadius );
        neighbourhood = A( loc(1)+(-1:1), loc(2)+(-1:1) );
        neighbourhood = neighbourhood - min(neighbourhood(:));
        loc = loc + cog(  neighbourhood ) -2;
end

