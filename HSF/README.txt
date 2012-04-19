Hierarchal Sparse Filtering
----------------------------

INSTRUCTIONS:

1) Download the Caltech Pedestrian Videos from http://www.vision.caltech.edu/Image_Datasets/CaltechPedestrians/files/data-USA/ and place videos in the 'video' folder with names 'V000.seq', 'V001.seq', 'V002.seq', etc

2) Place the human detection dataset in the 'humans' folder under the appropriate directories (train/pos, train/neg, test/pos, test/neg)

3) Open up the script 'set_params.m' and adjust parameters as desired

4) To train a 2 layer network on human detection images, run 'train_network.m'. To train a 2 layer network on video, run 'train_network_video.m'.

INCLUDES:

- minFunc: http://www.di.ens.fr/~mschmidt/Software/minFunc.html
- Piotr's image and video matlab toolbox: http://vision.ucsd.edu/~pdollar/toolbox/doc/index.html
- sparse filtering http://cs.stanford.edu/~jngiam/

NOTES:

- run some extra workers (ex: matlabpool open 8). The code for extracting patches and features was designed to run in parallel.
- to display the learned bases: display_network(D.codes'). Only works for 1st layer.
- using more patches/blocks and bases should improve performance


