function [posdesc negdesc] = Train(posimgpath, negimgpath)
posdesc = SIFT_desc(posimgpath);
negdesc = SIFT_desc(negimgpath);
return;