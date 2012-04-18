function [acclin accinter] = Test(posimgfolder, negimgfolder, modellin, modelinter)
posfeat = HOGFeaturesScript(posimgfolder);
negfeat = HOGFeaturesScript(negimgfolder);

d1 = ones(size(posfeat, 1), 1);
d2 = -1 * ones(size(negfeat, 1), 1);
label = [d1;d2];
data  = [posfeat;negfeat];

[templbl acclin] = svmpredict(label, data, modellin);
[templbl accinter] = svmpredict(label, data, modelinter);
return;