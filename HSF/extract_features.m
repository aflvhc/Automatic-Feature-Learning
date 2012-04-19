function [XC, L] = extract_features(X, D, params)


    % Relevant params list
    %----------------------------------------------------------------------
    % params.imSize - size of the image
    % params.stride - stride length
    % params.rfSize - receptive field size (rows, cols, frames)
    % params.regSize - subregion size to convolve with dictionary
    % params.alpha - rectification parameter
    % params.layer - layer 1 or 2
    %----------------------------------------------------------------------
    
    % Parameters
    rfSize = params.rfSize;
    regSize = params.regSize;
    layer = params.layer;
    
    % Initalize
    XC = zeros(size(X, 1), 21 * size(D.codes, 1));
    prows = regSize(1) - rfSize(1) + 1;
    pcols = regSize(2) - rfSize(2) + 1;
    if layer == 1
        L = zeros(size(X, 1), 16 * 16 * size(D.codes, 1));
    end
    
    % Main Loop
    parfor i = 1:size(X, 1)
        
        if ~mod(i, ceil(size(X,1)/50)); fprintf('.'); end
        
        % Extract subregions of the image
        [subregions, rowinds, colinds] = window(X(i,:), params);
        features = zeros(prows * pcols * size(D.codes, 1), size(subregions, 1));
        
        for j = 1:size(subregions, 1)     
            
            % Extract features
            features(:, j) = extract_subfeatures(subregions(j,:), D, params);
            
        end
        
        % Reshape into spatial region
        index = 1;
        field = zeros(prows * length(rowinds), pcols * length(colinds), size(D.codes, 1));
        for j = 1:length(rowinds)
            for k = 1:length(colinds)
                field(prows*(j-1) + 1:prows*j, pcols*(k-1) + 1: pcols*k, :) = reshape(features(:, index), [prows pcols size(D.codes, 1)]);
                index = index + 1;
            end
        end
        
        % Pooling
        base = spatial_pooling(field(:)', prows * length(rowinds), pcols * length(colinds), size(D.codes, 1), [4 4]);
        middle = spatial_pooling(field(:)', prows * length(rowinds), pcols * length(colinds), size(D.codes, 1), [2 2]);
        top = spatial_pooling(field(:)', prows * length(rowinds), pcols * length(colinds), size(D.codes, 1), [1 1]);
        XC(i,:) = [base middle top];
        
        if layer == 1
            L(i,:) = spatial_pooling(field(:)', prows * length(rowinds), pcols * length(colinds), size(D.codes, 1), [16 16]);
        end
     
    end
    disp(' ');

end

