function XC = extract_subfeatures(X, D, params)


    % Relevant params list
    %----------------------------------------------------------------------
    % params.rfSize - receptive field size (rows, cols, frames)
    % params.regSize - subregion size to convolve with dictionary
    % params.alpha - rectification parameter
    %----------------------------------------------------------------------
    
    % Parameters
    rfSize = params.rfSize;
    regSize = params.regSize;
    alpha = params.alpha;
    
    % Initalizations
    k = size(D.codes, 1);
    prows = regSize(1) - rfSize(1) + 1;
    pcols = regSize(2) - rfSize(2) + 1;
    f = k * prows * pcols;
    XC = zeros(size(X, 1), f);
    
    % Main loop
    for i = 1:size(X, 1)
        
        %if ~mod(i, ceil(size(X,1)/50)); fprintf('.'); end
        
        % Extract overlapping sub-patches into rows of 'patches'
        ims = regSize(1) * regSize(2); patches = [];
        for j = 1:regSize(3)
            patches = [patches; im2col(reshape(X(i,(j-1)*ims+1:j*ims), [regSize(1) regSize(2)]), [rfSize(1) rfSize(2)])];
        end
        patches = patches';
        
        % Remove DC component
        patches = bsxfun(@minus, patches, mean(patches));
    
        % Contrast normalization
        patches = bsxfun(@rdivide, bsxfun(@minus, patches, mean(patches,2)), sqrt(var(patches,[],2)+10));
        
        % Whitening
        patches = bsxfun(@minus, patches, D.mean) * D.whiten;
        
        % Soft activation
        xc = patches * D.codes';
        xc = tanh(xc);
        patches = max(xc - alpha, 0);
        
        % Localized normalization
        sd = std(patches, [], 2);
        patches = bsxfun(@rdivide, bsxfun(@minus, patches, mean(patches, 2)), max(mean(sd), sd));
        
        % Features
        patches = reshape(patches, prows, pcols, k);
        features = patches(:)';
        XC(i,:) = features;
    end
    %disp(' ');


end

