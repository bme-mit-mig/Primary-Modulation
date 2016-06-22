function CenterOfMass = cog(A)
% COG  calculates the center of gravity of an image
% the coordinates are indexed 1:n

%These next 4 lines produce a matrix C whose rows are
% the pixel coordinates of the image A

C=cellfun(@(n) 1:n, num2cell(size(A)),'uniformoutput',0);
[C{:}]=ndgrid(C{:});
C=cellfun(@(x) x(:), C,'uniformoutput',0);
C=[C{:}]; 

%This line computes a weighted average of all the pixel coordinates. 
%The weight is proportional to the pixel value.

CenterOfMass=A(:).'*C/sum(A(:),'double');
end