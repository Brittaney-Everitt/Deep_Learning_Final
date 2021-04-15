%This function creates the image masks for the training data using distance measures 

%data stored in a structure 
trainCSV = load('trainCSV.mat');
trainImages = load('trainImages.mat');

%determine number of training images 
[~,numImages] = size(trainImages.trainImages);

%foler where the masks will be saved
folder = '/Users/brittaneyeveritt/Documents/GitHub/Deep-Learning-Project/TrainingNucleiMasks/';

%loop through each image to create a mask for each image
for k = 1:numImages

    imagePatch1 = trainImages.trainImages{k}; 
    %calculate the size of the image patch 
    [numRows,numCols] =  size(imagePatch1);

    markedNuclei1 = trainCSV.trainCSV{k};
    %calculate the number of manually marked nuclei 
    [nucleiRow,nucleiColumn] = size(markedNuclei1);

    %pixels that are positive within 15 pixels to a manually marked nucleus 
    positivePixel = zeros(numRows, numCols);

    %loop through and get each pixel in the image 
    for row = 1:numRows 
        for col = 1:numCols

            %loop through each manually marked pixel in the list 
            for nuclei=1:nucleiRow

                %if it is not a positive pixel
                if (positivePixel(row,col) == 0)
                    %calculate distance between pixel coordinate and nuceli
                    distance = pdist([row,col;markedNuclei1(nuclei,1),markedNuclei1(nuclei,2)],'euclidean');

                    %check if distance is less than 15 
                    if (distance < 15) | (distance == 15)
                        %add pixel to positive list of pixels close to a nucleus
                        positivePixel(row,col) = 1;
                    end 
                end 
            end
        end 
    end 
    
    %save the mask image in a folder
    filename = fullfile(folder,sprintf('%s_%d%s','positive_pixel_mask',k,'.png'));
    imwrite(positivePixel, filename);
    
end 

