function [ attenuated, unattenuated ] = decompPModulatorGauss( downsampled, sigma )

[even, odd] = decompPModulatorOddEvenGauss(downsampled, sigma);
[even2, odd2] = decompPModulatorOddEven(downsampled);
even(isnan(even2)) = NaN;
odd(isnan(odd2)) = NaN;

    if (mean(even(~isnan(even))) > mean(odd(~isnan(odd))))
        unattenuated = even;
        attenuated = odd;
    else
        unattenuated = odd;
        attenuated = even;
    end;

end

