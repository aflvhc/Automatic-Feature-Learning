function [] = HaarScript(PosImgPath, NegImgPath, OpenCVBinPath)
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
            fprintf(f, '%s 1 %d %d %d %d\n', ['\' PosImgPath '\' finfo(i).name], 0, 0, nc, nr);
            numpossamp = numpossamp + 1;
        catch
        end
    end
end
fclose(f);
numpossamp = num2str(numpossamp);

% write information for negative files
numnegsamp = 0;
finfo = dir(NegImgPath);
n = size(finfo, 1);
f = fopen('neginfo.txt', 'w');
for i = 1:n
    if(~finfo(i).isdir)
        try
            img = imread([NegImgPath '\' finfo(i).name]);
            fprintf(f, '%s\n', [NegImgPath '\' finfo(i).name]);
            numnegsamp = numnegsamp + 1;
        catch
        end
    end
end
fclose(f); 
numnegsamp = num2str(numnegsamp);

% create vector file
system([OpenCVBinPath '\opencv_createsamples.exe -info "' mypath 'posinfo.txt" -vec "' mypath 'pos.vec" -w 16 -h 32']);

% perform haar training
%system([OpenCVBinPath '\opencv_haartraining.exe -data "' mypath '" -vec "' mypath 'pos.vec" -bg "' mypath 'neginfo.txt" -npos ' numpossamp ' -nneg ' numnegsamp ' -w 64 -h 128']);
return;