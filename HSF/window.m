function [subregions, rowinds, colinds] = window(im, params)


    % Relevant params list
    %----------------------------------------------------------------------
    % params.stride - stride length
    % params.regSize - subregion size to convolve with dictionary
    % params.imSize - size of the image
    %----------------------------------------------------------------------
    
    % Parameters
    stride = params.stride;
    regSize = params.regSize;
    imSize = params.imSize;
    
    % Initalization
    im = reshape(im, [imSize(1) imSize(2) imSize(3)]);
    rowinds = 1:stride:size(im, 1) - regSize(1);
    colinds = 1:stride:size(im, 2) - regSize(2);
    subregions = zeros(length(rowinds) * length(colinds), regSize(1) * regSize(2) * regSize(3));
    index = 1;
    
    % Extract subregions
    for i = 1:stride:size(im, 1) - regSize(1);
        for j = 1:stride:size(im, 2) - regSize(2);
            sr = im(i:i+regSize(1)-1,j:j+regSize(2)-1,:);
            subregions(index,:) = sr(:)';
            index = index + 1;
        end
    end
            
end

