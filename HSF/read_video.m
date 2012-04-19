function V = read_video(params)


    % Relevant params list
    %----------------------------------------------------------------------
    % params.nrows - video row size
    % params.ncols - video column size
    % params.nframes - number of frames to extract from videos
    % params.nvids - number of videos to load
    % params.videodir - directory containing videos
    %----------------------------------------------------------------------
    
    % Parameters
    nrows = params.nrows;
    ncols = params.ncols;
    nframes = params.nframes;
    nvids = params.nvids;
    videodir = params.videodir;
    
    % Read videos and re-scale
    V = zeros(nrows, ncols, nframes, nvids);
    listing = dir([videodir '/*.seq']);
    for i = 1:min(length(listing),nvids)
        
        % Load video
        disp(['Loading video ' num2str(i) ' / ' num2str(min(length(listing),nvids))]);
        vid = seqIo([videodir '/' listing(i).name], 'toImgs');
        
        disp('Rescaling video...');
        % Re-scale
        for j = 1:params.nframes;
            im = vid(:,:,:,j);
            im = imresize(im, [nrows ncols]);
            V(:,:,j,i) = double(rgb2gray(im));
            V(:,:,i) = V(:,:,i) / 255;
        end     
    end
    
    % Flatten video
    V = reshape(V, nrows * ncols * nframes, nvids)';
    
end

