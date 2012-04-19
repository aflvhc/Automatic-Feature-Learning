function D = dictionary(patches, params)


    % Relevant params list
    %----------------------------------------------------------------------
    % params.nfeats - dictionary size
    % params.gamma - whitening regularization parameter
    % params.rfSize - receptive field size (rows, columns, frames)
    % params.compress - aggregate temporal dimension
    %----------------------------------------------------------------------
    
    % Parameters
    nfeats = params.nfeats;
    rfSize = params.rfSize;
    
    % Apply PCA whitening
    disp('Applying PCA Whitening...');
    D = pca_whitening(patches, params);
    nX = bsxfun(@minus, patches, D.mean) * D.whiten;
    
    % Train dictionary
    disp('Training Dictionary...');
    D.codes = sparseFiltering(nfeats, nX');
    
    % Temporal pool over mean and whitening matricies
    if params.compress
        disp('Temporal Pooling....');
        D.whiten = reshape(D.whiten, [rfSize(1) rfSize(2) rfSize(3) rfSize(1) rfSize(2)]);
        D.whiten = squeeze(sum(D.whiten, 3));
        D.whiten = reshape(D.whiten, [rfSize(1) * rfSize(2) rfSize(1) * rfSize(2)]);
        D.whiten = bsxfun(@rdivide, D.whiten, sqrt(sum(D.whiten.^2,2)) + 1e-20);

        D.mean = reshape(D.mean, [1 rfSize(1) rfSize(2) rfSize(3)]);
        D.mean = squeeze(sum(D.mean, 4));
        D.mean = reshape(D.mean, [1 rfSize(1) * rfSize(2)]);
        D.mean = bsxfun(@rdivide, D.mean, sqrt(sum(D.mean.^2,2)) + 1e-20);
    end
    
end

