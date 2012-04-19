function patches = extract_patches(V, params)


    % Relevant params list
    %----------------------------------------------------------------------
    % params.rfSize - receptive field size (rows, cols, frames)
    % params.npatches - number of patches to extract
    % params.nrows - video row size
    % params.ncols - video column size
    % params.nframes - number of frames extracted from video
    %----------------------------------------------------------------------
    
    % Parameters
    rfSize = params.rfSize;
    npatches = params.npatches;
    nrows = params.nrows;
    ncols = params.ncols;
    nframes = params.nframes;

    % Main loop
    patches = zeros(npatches, rfSize(1) * rfSize(2) * rfSize(3));
    disp('Extracting video blocks...');
    parfor i=1:npatches

        if (mod(i,100) == 0) fprintf('Extracting video block: %d / %d\n', i, npatches); end

        % Extract random video block
        r = random('unid', nrows - rfSize(1) + 1);
        c = random('unid', ncols - rfSize(2) + 1);
        f = random('unid', nframes - rfSize(3) + 1);
        patch = reshape(V(mod(i-1,size(V,1))+1,:), [nrows ncols nframes]);
        patch = patch(r:r+rfSize(1)-1,c:c+rfSize(2)-1,f:f+rfSize(3)-1);

        % Remove DC component
        patch = bsxfun(@minus, patch, mean(patch));
        patches(i,:) = patch(:)';
    end

    % Brightness and contrast normalization
    disp('Contrast normalization...');
    patches = bsxfun(@rdivide, bsxfun(@minus, patches, mean(patches,2)), sqrt(var(patches,[],2)+10));

end

