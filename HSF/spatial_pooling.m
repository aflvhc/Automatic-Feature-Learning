function features = spatial_pooling(XC, nrows, ncols, nmaps, gridsize)

    numtiles = gridsize(1) * gridsize(2);
    features = zeros(size(XC, 1), numtiles * nmaps);
    Q = zeros(numtiles, nmaps);
    r = round(nrows/gridsize(1));
    c = round(ncols/gridsize(1));
    
    for i = 1:size(XC, 1) 
        patches = reshape(XC(i,:), [nrows ncols nmaps]);
        index = 1;
        for j = 1:gridsize(2)
            for k = 1:gridsize(1)
                Q(index, :) = sum(sum(patches((k-1) * r + 1: k * r, (j-1) * c + 1: j * c, :), 1), 2);
                index = index + 1;
            end
        end
        features(i,:) = Q(:)';
    end




end

