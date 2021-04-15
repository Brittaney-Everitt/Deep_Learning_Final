%creates the training patches 

%data stored in a structure 
trainCSV = load('trainCSV.mat');
trainImages = load('trainImages.mat');

%Training Image Patches -------------------------------
%directory to save patches too 
folder = '/Users/brittaneyeveritt/Documents/GitHub/Deep-Learning-Project/TrainingPatchesOrdered/';

%Load the masks into MATLAB
path = '/Users/brittaneyeveritt/Documents/GitHub/Deep-Learning-Project/TrainingNucleiMasks/*.png';
path2 = '/Users/brittaneyeveritt/Documents/GitHub/Deep-Learning-Project/TrainingNucleiMasks/';
images = dir(path);      
numfiles = length(images);   
%extract names of the images 
for i=1:numfiles
   filename = images(i).name;
   file = fullfile(path2,filename);
   image = imread(file);
   allMasks{i} = imbinarize(image);
end

%create the labels vector 
allLabels = [];
allImageNames = strings(1,1);

%Create patches for every image and add the label to the patch 
for k = 1:numfiles
    
    disp(k)

    %get current image 
    imagePatch1 = trainImages.trainImages{k};

    %get current mask
    imageMask = allMasks{k};

    %overlapping 15 pixel intervals 
    %75x75 pixels per image 
    [j,i] =  size(imagePatch1);
    count = 0;
    for row = 1:15:j 
        %account for border
        patchRow = min(row + 75 - 1, j);
        for col = 1:15:i 
            %account for border
            patchCol = min(col + 75 -1, i);

            %extract patch of the cytology image 
            patch = imagePatch1(row:patchRow, col:patchCol);

            %extract path from the mask 
            maskPatch = imageMask(row:patchRow, col:patchCol);

            %check if image patch is 75x75, then save the patch 
            [patch_i, patch_j] = size(patch);
            if (patch_i == 75 & patch_j == 75)
                if k==1 | k==2 | k==3 | k==4 | k==5 | k==6 | k==7 | k==8 | k==9
                    if count < 10
                        filename = fullfile(folder,sprintf('%s%d_%s%d%s','train_patch_0',k,'000',count,'.png'));
                    elseif count >= 10 & count < 100
                        filename = fullfile(folder,sprintf('%s%d_%s%d%s','train_patch_0',k,'00',count,'.png'));
                    elseif count >= 100 & count < 1000
                        filename = fullfile(folder,sprintf('%s%d_%s%d%s','train_patch_0',k,'0',count,'.png'));
                    else
                        filename = fullfile(folder,sprintf('%s%d_%d%s','train_patch_0',k,count,'.png'));
                    end
                else
                    if count < 10
                        filename = fullfile(folder,sprintf('%s%d_%s%d%s','train_patch_',k,'000',count,'.png'));
                    elseif count >= 10 & count < 100
                        filename = fullfile(folder,sprintf('%s%d_%s%d%s','train_patch_',k,'00',count,'.png'));
                    elseif count >= 100 & count < 1000
                        filename = fullfile(folder,sprintf('%s%d_%s%d%s','train_patch_',k,'0',count,'.png'));
                    else
                        filename = fullfile(folder,sprintf('%s%d_%d%s','train_patch_',k,count,'.png'));
                    end
                end 

                %check if it is the first one
                if allImageNames(1,1) == ""
                    allImageNames(1,1) = filename;
                else 
                    allImageNames = [allImageNames;filename];
                end 

                %check if the patch 1 at the centre
                if (maskPatch(37,37) == 1)
                    label = 1;
                    allLabels = [allLabels;label];

                else %if the image has no 1s
                    label = -1; 
                    allLabels = [allLabels;label];

                end 

                imwrite(patch, filename);

                %count the number of patches 
                count = count+1;

            end  

        end 
    end 
end 

CSV = [allImageNames,allLabels];

%write the labels to a csv file 
writematrix(CSV,'trainingPatchLabelsOrdered.csv') 
