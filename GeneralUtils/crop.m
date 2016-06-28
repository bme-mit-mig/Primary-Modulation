function result = crop( m, h, w )
% crop  Trims the image m.
%   the resulting image will have w width and h height

% for default square matrices
if ~exist('w','var')
    w = h;
end

result = m(floor((size(m, 1)-h)/2+1):floor((size(m, 1)+h)/2),...
           floor((size(m, 2)-w)/2+1):floor((size(m, 2)+w)/2));


end

