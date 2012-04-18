function feat = HOGFeaturesScript(path)
finfo = dir(path);
n = size(finfo, 1);
feat = [];
for i = 1:n
    if(~finfo(i).isdir)
        try
            img = imread([path '\' finfo(i).name]);
            if(size(img, 3) > 1)
                img = rgb2gray(img);
            end
            img = im2double(img);
            feat = [feat ; (HOG(img))'];
            display(i);
        catch
        end
    end
end
return;