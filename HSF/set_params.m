% Script for setting the paths and parameters
%--------------------------------------------------------------------------

% Paths
VIDEO_DIR = './video';
SEQ_DIR1 = './video_toolbox/images';
SEQ_DIR2 = './video_toolbox/matlab';
MINFUNC = './minFunc';
addpath(VIDEO_DIR, SEQ_DIR1, SEQ_DIR2, MINFUNC);

% Reading in video
params.nrows = 120; % 120 for video. 128 for images
params.ncols = 160; % 160 for video, 64 for images
params.nframes = 1000; % 1000 for video, 1 for images
params.nvids = 5;
params.videodir = VIDEO_DIR;

% Extracting patches
params.rfSize = [6 6 10]; % [6 6 10] for video, [6 6 1] for images
params.npatches = 10000;

% Whitening and dictionary learning
params.nfeats = 128;
params.gamma = 0.1;
params.compress = 1;

% Feature extraction
params.layer = 1;
params.imSize = [128 64 1];
params.regSize = [16 16 1];
params.stride = 4;
params.alpha = 0.25;

%--------------------------------------------------------------------------

% 2nd layer parameters
params2.nrows = 16;
params2.ncols = 16;
params2.nframes = params.nfeats;

% 2nd layer patches
params2.rfSize = [2 2 params.nfeats];
params2.npatches = 10000;

% 2nd layer whitening and dictionary learning
params2.nfeats = 256;
params2.gamma = 1e-6;
params2.compress = 0;

% 2nd layer feature extraction
params2.layer = 2;
params2.imSize = [16 16 params.nfeats];
params2.regSize = [8 8 params.nfeats];
params2.stride = 2;
params2.alpha = 0.25;

