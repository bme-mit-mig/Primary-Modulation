function loc = maxLocAround( A, point, searchRadius )
%maxLocAround finds the loocation of the maximum around the given point
% point   [row, col]
        
        max = -inf;
        
        for i = point(1) -searchRadius : point(1)+searchRadius
            for j = point(2) -searchRadius : point(2)+searchRadius
                if norm( [i j] - point ) <= searchRadius
                    ii = round(i);
                    jj = round(j);
                    if A(ii,jj) >= max
                        maxI = ii;
                        maxJ = jj;
                        max = A(ii,jj);
                    end
                end
            end
        end
        
        loc = [maxI, maxJ];
end

