% Load human detection dataset
humans_dir = './humans';
addpath(genpath(humans_dir));
imsize = [128 64];

% Listings
train_pos = dir([humans_dir '/train/pos/*.jpg']);
train_neg = dir([humans_dir '/train/neg/*.jpg']);
test_pos = dir([humans_dir '/test/pos/*.jpg']);
test_neg = dir([humans_dir '/test/neg/*.jpg']);

% Initalize
train = zeros(length(train_pos) + length(train_neg), imsize(1) * imsize(2));
test = zeros(length(test_pos) + length(test_neg), imsize(1) * imsize(2));
train_L = [ones(length(train_pos), 1); zeros(length(train_neg), 1)];
test_L = [ones(length(test_pos), 1); zeros(length(test_neg), 1)];

% Load images
disp('Loading training set...');
for i = 1:length(train_pos)
    im = double(imread(train_pos(i).name)) / 255;
    train(i,:) = reshape(im, [1 imsize(1) * imsize(2)]);
end
for i = 1:length(train_neg)
    im = double(imread(train_neg(i).name)) / 255;
    train(i + length(train_pos),:) = reshape(im, [1 imsize(1) * imsize(2)]);
end

disp('Loading testing set...');
for i = 1:length(test_pos)
    im = double(imread(test_pos(i).name)) / 255;
    test(i,:) = reshape(im, [1 imsize(1) * imsize(2)]);
end
for i = 1:length(test_neg)
    im = double(imread(test_neg(i).name)) / 255;
    test(i + length(test_pos),:) = reshape(im, [1 imsize(1) * imsize(2)]);
end
    
