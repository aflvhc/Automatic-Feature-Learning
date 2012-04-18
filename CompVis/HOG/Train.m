function [posfeat negfeat modellin modelinter] = Train(posimgfolder, negimgfolder)
posfeat = HOGFeaturesScript(posimgfolder);
negfeat = HOGFeaturesScript(negimgfolder);

d1 = ones(size(posfeat, 1), 1);
d2 = -1 * ones(size(negfeat, 1), 1);
label = [d1;d2];
data  = [posfeat;negfeat];

modellin = svmtrain(label, data, '-s 0 -t 0');
modelinter = svmtrain(label, data, '-s 0 -t 4');
return;