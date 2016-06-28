function D = estModCellDist( line )
%ESTMODCELLDIST returns the period of the highest freq between 30 and 50

f = abs(fft(line));

start = 30;
[~, i] = max(f(start:start+20));
D = length(line) / (i+start-2);

end

