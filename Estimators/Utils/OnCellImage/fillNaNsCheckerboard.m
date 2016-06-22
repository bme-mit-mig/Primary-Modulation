function sample = fillNaNsCheckerboard( sample )
%FILLNANSCHECKERBOARD fill NaN values with neighbouring values 2 pixels
%away

[ odd, even ] = decompPModulatorOddEven(sample);

r = 3;
odd = medfilt2NaN(odd, r, true);
even = medfilt2NaN(even, r, true);

expanded = composePModulator(even, odd);
mask = isnan(sample);
sample(mask) = expanded(mask);

end

