function output = masked_distance_transform(mask,surface)
% distance transform using lung mask
ms_n = bwdist(logical(mask));
ms_n = -1 + (1 ./ (1 + ms_n));

ms_p = bwdist(~logical(mask));
ms_p = 1 - (1 ./ (1 + ms_p));

ms = ms_n + ms_p;

% apply dilated lung surface mask
J = imdilate(surface,strel("sphere",12));
output = ms .* single(J);

end

