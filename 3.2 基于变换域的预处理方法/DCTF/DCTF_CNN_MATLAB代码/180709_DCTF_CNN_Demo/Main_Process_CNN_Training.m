clear
clc

DCTF_Feature_setPath = 'DCTF_Features/DCTF32_IQ1_D10_30dB_T/';
DCTF_Feature_Data = imageDatastore(DCTF_Feature_setPath,...
    'IncludeSubfolders',true,'LabelSource','foldernames');

labelCount = countEachLabel(DCTF_Feature_Data);

img = readimage(DCTF_Feature_Data,1);

Figure_Size = size(img);
Device_Nunber = size(labelCount);

train_NumFiles = 80;
[train_DCTF_Data,val_DCTF_Data] = splitEachLabel(DCTF_Feature_Data,train_NumFiles,'randomize');

layers = [
    imageInputLayer([Figure_Size(1,1) Figure_Size(1,2) 1])
    
    convolution2dLayer(3,16,'Padding',1)
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding',1)
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,64,'Padding',1)
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(Device_Nunber(1,1))
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm',...
    'MaxEpochs',50, ...
    'ValidationData',val_DCTF_Data,...
    'ValidationFrequency',30,...
    'Verbose',false,...
    'Plots','training-progress');

[trainedNet, traininfo] = trainNetwork(train_DCTF_Data,layers,options);

str_Network_Parth= strcat ('Store_Results\Test_CNN.mat');   % get file name

save(str_Network_Parth);

predictedLabels = classify(trainedNet,val_DCTF_Data);
valLabels = val_DCTF_Data.Labels;

accuracy = sum(predictedLabels == valLabels)/numel(valLabels)
