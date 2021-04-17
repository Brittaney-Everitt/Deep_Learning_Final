%determine the number of missed  nuclei 
%retrieve the ground truth nuceli 
testCSV = load('testCSV.mat');

[~,numImages] = size(testCSV.testCSV);

num_nuclei = 0;

%loop through the number of nuclei in each testing image 
for i=1:numImages
    %retreive the nucleli locations 
    markedNuclei = testCSV.testCSV{i};
    [nuclei_row,nuclei_col] = size(markedNuclei);
    num_nuclei=num_nuclei+nuclei_row;
end 

disp('Num Nuclei');
disp(num_nuclei)

%add in manually counted missing nuclei 
missed = 76; 

%calculate the percent missed 
percent_missed = missed/num_nuclei;

disp('Percent of nuclei missed');
disp(percent_missed)