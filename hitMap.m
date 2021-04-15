%This function creates the hitmaps of the testing data using output from
%the DL model
%use matlab to load in the csv file 

labels = table2array(PredictionTestLabels);

%load in the test data 
testImages = load('testImages.mat');

%retrieve the ground truth nuceli 
testCSV = load('testCSV.mat');

%calculate how many images in the test image set 
[~,numImages] = size(testImages.testImages);

patch_count = 1;

for k=1:numImages

    image = testImages.testImages{k};

    %create empty array to store pixel coordinates 
    positive_pixels = [];

    [j,i] =  size(image);

    %middle of the patch that is labelled as a nuclei is (37,37)
    row_count = 37;

    for row = 1:15:j 
        %account for border
        patchRow = min(row + 75 - 1, j);

        %middle of the patch that is labelled as a nuclei is (37,37)
        col_count = 37;

        for col = 1:15:i 

            %account for border
            patchCol = min(col + 75 -1, i);

            patch = image(row:patchRow, col:patchCol);

            %check if image patch is 75x75, then save the patch 
            [patch_i, patch_j] = size(patch);
            if (patch_i == 75 & patch_j == 75)

                %if the label is positive
                if (labels(patch_count)==1)
                    positive_pixels = [positive_pixels;[row_count,col_count]];
                end 

                %calculate the center of the patch in relation to the image
                %add 15 since the middle pixel shifts by 15
                col_count = col_count + 15;
                patch_count = patch_count +1;
            end 
        end
        %increase the row count of the center 
        row_count = row_count + 15;
    end


    %retreive the nucleli locations 
    markedNuclei = testCSV.testCSV{k};

    %visualize the nuceli on the image
    figure(k);
    imshow(image);

    %calculate the size of the number of found pixels 
    [positive_row,positive_col] = size(positive_pixels);
    axis on
    hold on;
    for pixel=1:positive_row
        %Plot markers on the image
        plot(positive_pixels(pixel,2),positive_pixels(pixel,1), 'r+', 'MarkerSize', 20, 'LineWidth', 2); 
    end

    %add the ground truth to the images 
    %calculate the size of the number of nuclei
    [nuclei_row,nuclei_col] = size(markedNuclei);
    axis on
    hold on;
    for nuclei=1:nuclei_row
        %Plot markers on the image
        plot(markedNuclei(nuclei,2),markedNuclei(nuclei,1), 'b+', 'MarkerSize', 20, 'LineWidth', 2); 
    end

    hold off;
end






