function result = SIFT_desc(path)
% write information for all positive images
result = [];
finfo = dir(path);
n = size(finfo, 1);
for i = 1:n
    if(~finfo(i).isdir)
        try
            img = imread([path '\' finfo(i).name]);
            [temp desc] = sift(img);
            result = [result; desc];
        catch
        end
    end
    display(i);
end
return;