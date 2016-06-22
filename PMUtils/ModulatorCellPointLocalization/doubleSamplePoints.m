function doubleP = doubleSamplePoints(positions)
%doubleSamplePoints  adds a new sampling point between each pair of
%adjacent points


    n = size(positions.V,1);

    doubleP.V = f(positions.V);
    doubleP.H = f(positions.H);


    function posD = f(pos)
        for i = 1:n
            for j = 1:n     
                posD(i*2-1, j*2-1) = pos(i,j);

                if i < n            
                    posD(i*2, j*2-1) = mean([pos(i,j), pos(i+1,j)]);
                end

                if j < n                              
                    posD(i*2-1, j*2) = mean([pos(i,j), pos(i,j+1)]);
                end

                if j < n && i < n                  
                    posD(i*2, j*2) = mean([pos(i,j), pos(i+1,j+1)]);
                end

            end
        end
    end

end