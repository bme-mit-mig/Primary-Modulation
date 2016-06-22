function mp = getModPoints( FF )
%GETMODPOINTS  gets cached mod points from mpGlobal, or finds them on FF
%it returns mpGlobal if exists, otherwise it calls
%findModPoints + double + extrapolate

% making testing faster if the same modulator is used everywhere
global mpGlobal;

if isempty(mpGlobal)
    mp = findModPoints(FF, true);
    mp = doubleSamplePoints( extrapolSamplingPoints( mp, 5));
else
    mp = mpGlobal;
end


end

