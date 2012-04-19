function [trainX, testX] = standard(trainXC, testXC)

    epsilon = 0.01;
    trainX_mean = mean(trainXC);
    trainX_sd = sqrt(var(trainXC) + epsilon);
    trainX = bsxfun(@rdivide, bsxfun(@minus, trainXC, trainX_mean), trainX_sd);
    trainX = [trainX, ones(size(trainX,1),1)];
    if exist('testXC','var')
        testX = bsxfun(@rdivide, bsxfun(@minus, testXC, trainX_mean), trainX_sd);
        testX = [testX, ones(size(testX,1),1)];
    end


