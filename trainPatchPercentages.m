%test percentage of train patches with positive labels 

[numRows,~] = size(trainingPatchLabelsOrdered);

label = table2array(trainingPatchLabelsOrdered);

count = 0;
for i = 1:numRows
    if label(i,1) == 1
        count=count+1;
    end 
end 

percent = count/numRows;

disp('Percentage of positive labels')
disp(percent)

