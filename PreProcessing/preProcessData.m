%This code loads in the images and the ground truth nuclei coordinates
%for each image. This code also splits the data into testing and training
%datasets based on the split in the labels.csv file 


%load the images into MATLAB
path = '/Users/brittaneyeveritt/Documents/GitHub/Deep-Learning-Project/EDF/*.png';
path2 = '/Users/brittaneyeveritt/Documents/GitHub/Deep-Learning-Project/EDF/';
images = dir(path);      
numfiles = length(images);   
%extract the images 
for i=1:numfiles
   filename = images(i).name;
   file = fullfile(path2,filename);
   image = imread(file);
   allImages{i} = image;
end


%extract csv information about the nuclei 
csvPath = '/Users/brittaneyeveritt/Documents/GitHub/Deep-Learning-Project/EDF/*.csv';
allFiles = dir(csvPath);      
numfiles1 = length(allFiles);   
%extract names of the images 
for i=1:numfiles1
   filename1 = allFiles(i).name;
   csvfile = fullfile(path2,filename1);
   csv = csvread(csvfile);
   allCsv{i} = csv;
end

%load in the labels
labels1 = readtable('/Users/brittaneyeveritt/Documents/GitHub/Deep-Learning-Project/labels.csv');
labels = table2cell(labels1);


%separate images into test and training set 
countTrain = 1;
countTest = 1;
for i=1:93
    %training data
    if labels{i,3} == 0
        trainImages{countTrain} = allImages{i};
        trainCSV{countTrain} = allCsv{i};
        countTrain = countTrain + 1; 
        
    %testing data 
    else %if it equals 1
        testImages{countTest} = allImages{i};
        testCSV{countTest} = allCsv{i};
        countTest = countTest + 1; 
    end 
    
end
    












