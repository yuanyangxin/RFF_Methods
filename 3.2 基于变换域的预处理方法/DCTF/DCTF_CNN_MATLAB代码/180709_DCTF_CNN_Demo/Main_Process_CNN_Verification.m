clear
clc

str_Network_Parth= strcat ('Store_Results\Test_CNN.mat');   % get file name
load(str_Network_Parth) 

DCTF_Feature_setPath = 'DCTF_Features/DCTF32_IQ1_D10_30dB_D/';
DCTF_Feature_Data = imageDatastore(DCTF_Feature_setPath,...
    'IncludeSubfolders',true,'LabelSource','foldernames');

labelCount = countEachLabel(DCTF_Feature_Data);

img = readimage(DCTF_Feature_Data,1);

Figure_Size = size(img);
Device_Nunber = size(labelCount);

train_NumFiles = 1;
[train_DCTF_Data,val_DCTF_Data] = splitEachLabel(DCTF_Feature_Data,train_NumFiles,'randomize');

t0=cputime;

predictedLabels = classify(trainedNet,val_DCTF_Data);

t1=cputime-t0

valLabels = val_DCTF_Data.Labels;

accuracy = sum(predictedLabels == valLabels)/numel(valLabels)

Error_matrix = zeros(54,54);

a = size(valLabels);

for n = 1:a(1,1)
    Error_matrix(predictedLabels(n,1),valLabels(n,1)) = Error_matrix(predictedLabels(n,1),valLabels(n,1)) + 1;
end
Error_matrix = sqrt(Error_matrix);
min_table=min(min(Error_matrix));  
max_table=max(max(Error_matrix));
Error_matrix=Error_matrix./(max_table-min_table)*255;  
Error_matrix = 255 - Error_matrix;

% str_write_jpg= strcat ('Error_Matrix.png'); 
% imwrite(uint8(Error_matrix), str_write_jpg);

gray(Error_matrix,1)

