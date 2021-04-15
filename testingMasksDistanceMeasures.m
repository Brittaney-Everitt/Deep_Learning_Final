%distance measures for the testing set 
%this code creates the testing image masks

%data stored in a structure 
testCSV = load('testCSV.mat');
testImages = load('testImages.mat');

%determine number of testing images 
[~,numImages] = size(testImages.testImages);

%foler where the masks will be saved
folder = '/Users/brittaneyeveritt/Documents/GitHub/Deep-Learning-Project/TestingNucleiMasks/';


for k = 1:numImages

    imagePatch1 = testImages.testImages{k}; 
    %calculate the size of the image patch 
    [numRows,numCols] =  size(imagePatch1);

    markedNuclei1 = testCSV.testCSV{k};
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
    filename = fullfile(folder,sprintf('%s_%d%s','positive_pixel_mask_testing',k,'.png'));
    imwrite(positivePixel, filename);
    
end 
