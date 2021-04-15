%test percentage of train patches with positive labels 

%load in the table
label = table2array(testingPatchLabelsOrdered);

%remove NAN from the first row caused by the header of the csv
label = label(2:end);

%get the size of the array 
[numRows,~] = size(label);

%count the number of positive labels of the testing patches 
count = 0;
for i = 1:numRows
    if label(i,1) == 1
        count=count+1;
    end 
end 

percent = count/numRows;

disp('Percentage of positive labels')
disp(percent)

%count the number of postivie labels in only the first patch 
count = 0;
for i = 1:4860
    if label(i,1) == 1
        count=count+1;
    end 
end

disp('Number of positive labels in first patch') 
disp(count)