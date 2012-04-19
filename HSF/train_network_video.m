% Train 2-layer network using video

% Read in data
humans_preproc;

% Set parameters and paths
set_params;

% Read in video
V = read_video(params);

% LAYER 1
%--------------------------------------------------------------------------

% Extract patches
patches = extract_patches(V, params);

% Train dictionary
D = dictionary(patches, params);

% Extract features
disp('Extracting features...');
[trainXC, trainB] = extract_features(train, D, params);
[testXC, testB] = extract_features(test, D, params);

% LAYER 2
%--------------------------------------------------------------------------

% Extract patches
patches2 = extract_patches(trainB, params2);

% Train dictionary
D2 = dictionary(patches2, params2);

% Extract features
disp('Extracting features...');
trainXC2 = extract_features(trainB, D2, params2);
testXC2 = extract_features(testB, D2, params2);

% CLASSIFICATION
%--------------------------------------------------------------------------

% Normalize data
[trainXF, testXF] = standard([trainXC trainXC2], [testXC testXC2]);

% Train SVM
disp('Training SVM...');
C = 0.0625;
theta = train_svm(trainXF, train_L+1, C);

% Classify
[foo, yhat] = max(testXF * theta, [], 2);
acc = sum(test_L+1 == yhat) / length(yhat);
disp(['Accuracy: ' num2str(acc * 100) '%']);
