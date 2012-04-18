function [] = TestInternal(PosImgPath)
mypath = which('HaarScript');
ind = find(mypath == '\', 1, 'last');
mypath = mypath(1:ind);

% write information for all positive images
numpossamp = 0;
finfo = dir(PosImgPath);
n = size(finfo, 1);
f = fopen('posinfo.txt', 'w');
for i = 1:n
    if(~finfo(i).isdir)
        try
            img = imread([PosImgPath '\' finfo(i).name]);
            [nr nc dim] = size(img); 
            fprintf(f, '%s 1 %d %d %d %d\n', [PosImgPath '\' finfo(i).name], 0, 0, nc, nr);
            numpossamp = numpossamp + 1;
        catch
        end
    end
end
fclose(f);
numpossamp = num2str(numpossamp);
return;