function D = pca_whitening(patches, params)


    % Relevant params list
    %----------------------------------------------------------------------
    % params.gamma - whitening regularization parameter
    % params.rfSize - receptive field size (rows, columns, frames)
    % params.compress - aggregate temporal dimension
    %----------------------------------------------------------------------
    
    % Parameters
    gamma = params.gamma;
    rfSize = params.rfSize;
    
    % Whitening
    D.mean = mean(patches);
    patches = bsxfun(@minus, patches, D.mean);
    C = cov(patches);
    [V,E] = svd(C);
    r = rfSize(1) * rfSize(2);
    if params.compress
        D.whiten = sqrt(size(patches, 1) - 1) * V * sqrtm(inv(E + eye(size(E)) * gamma)) * V(1:r,:)';
    else
        D.whiten = sqrt(size(patches, 1) - 1) * V * sqrtm(inv(E + eye(size(E)) * gamma)) * V';
    end
    
end

