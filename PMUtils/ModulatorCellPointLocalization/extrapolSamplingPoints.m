function extrapolated = extrapolSamplingPoints( pos, np )
%POLYSMOOTH2D smooths a matrix by a polynomial surface
%   pos    position values
%   np     number of points to add at each border

extrapolated.V = doForOne(pos.V);
extrapolated.H = doForOne(pos.H);


    function extraPoled = doForOne( pos )

        fitType = 'poly33';

        [h,w] = size(pos);

        [X,Y] = meshgrid(1:w, 1:h);
        sf = fit( [X(:), Y(:)], pos(:), fitType);

        extraPoled = zeros(h,w);

        for i = 1:h+np*2
            for j = 1:w+np*2
                extraPoled(i,j) = feval(sf, [j-np, i-np]);  
            end
        end
        
        % keeping the original points untouched
        extraPoled(np+1:end-np, np+1:end-np) = pos;

    end

end