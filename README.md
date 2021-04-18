# Nuclei Detection - Classifying cervical cytology smears using a supervised learning approach 

This repository is the official implementation of Nuclei Detection - Classifying cervical cytology smears using a supervised learning approach. 

This is a reproducibility study of the deep learning method in the paper by Phoulady et _al._ titled "A New Cervical Cytology Dataset for Nucleus Detection and Image Classification (Cervix93) and Methods for Cervical Nucleus Detection". Link to the paper: https://arxiv.org/abs/1811.09651. Full reference: Phoulady HA, Mouton PR: A new cervical cytology dataset for nucleus detection and image classification (cervix93) and methods for cervical nucleus detection. arXiv preprint arXiv:181109651 2018. 

This repository is written by Brittaney Everitt (student number 10211957) for the final project in CISC 867 Deep Learning. 

## Repository Details 

**EDF directory** → Full frame cytology smears from the Cervix93 Cytology dataset. This dataset is from the following Github: https://github.com/parham-ap/cytology_dataset. It contains 93 real extended depth of field images (at 40x magnification) of size 1280x960 pixels. The manually marked nuclei coordinates are recorded in a csv file for each image in the dataset. 

**Pre-processsing Directory**

  1. **distanceCalc.m** → A MATLAB script which creates nuclei masks for the training data based on a distance  measure to the manually marked nuclei coordinates. 

  2. **imagePatches.m** → A MATLAB script which creates 75x75 pixels image patches for all of the training images. A csv file is also created which contains labels for each patch if it contains a nucleus or not. 

  3. **labels.csv** → A csv file provided by Phoulady et _al._ from the following Github: https://github.com/parham-ap/cytology_dataset/tree/master/dataset. The csv file has labels to determine which whole slide cytology images are in the training (0) and testing sets (1). 

  4. **preProcessData.m** → A MATLAB script which loads in the images and the manually marked nuclei coordinates in each image and splits the data into training and testing sets based on the label in the labels.csv file. The image data and array of nuclei coordinates for each image are stored in a MATLAB structure array. 

  5. **testCSV.mat** → MATLAB structure array of nuclei corrdinates for each image in the test set. 

  6. **testImages.mat** → MATLAB structure array of the whole slide images in the test set.

  7. **testingMasksDistanceMeasures.m** → A MATLAB script which creates nuclei masks for the testing data based on a distance measure to the manually marked nuclei coordinates. 
  
  8. **testingPatchCreation.m** → A MATLAB script which creates 75x75 pixels image patches for all of the testing images. A csv file is also created which contains labels for each patch if it contains a nucleus or not. 

  9. **testingPatchLabelsOrdered.csv** → A csv file which contains the labels for each patch created from the testing images. 

  10. **testingPatchPercentages.m** → A MATLAB script which calculates the percentage of positively labelled patches in the test set. 

  11. **trainCSV.mat** → MATLAB structure array of nuclei corrdinates for each image in the train set.

  12. **trainImages.mat** → MATLAB structure array of the whole slide images in the train set.

  13. **trainPatchPercentages.m** → A MATLAB script which calculates the percentage of positively labelled patches in the train set. 

  14. **trainingPatchLabelsOrdered.csv** → A csv file which contains the labels for each patch created from the training images. 


**PredictionTestLabels.csv** → Predicted labels of each image patch in the testing set. This is output from the deep learning model. 

**countNuclei.m** → A MATLAB script which calculates the percentage of missed nuclei from the testing output of the model. The variable "missed" in the script was calculated manually. To reproduce this experiment, the hitMap.m file must be run and 24 images with marked predicted nuclei (in red) and ground truth nuclei coordinates (in blue) must be produced. Count the number of ground truth coordinates that are not "hit" by any red targets. If a red target was on the same circular nuclei as a blue (ground truth) target, the nuclei was counted as a "hit" nuclei. If no red targets were on the same circular nuclei as a blue (ground truth) target, the nuclei was counted as a miss. See the results section for an example. 

**hitMap.m** → A MATLAB script to create the hitmaps for testing data. Each image has predicted nuclei markers, from the output of the deep learning model, and ground truth nuclei coordinates on each cytology whole slide image. The middle of the patch is coordinates (37,37). Patch labels are created based on this center coordinate. If the patch center is labelled as a nucleu, this coordinate in the whole slide image is labelled as a "hit"

**main.ipynb** → The Jupyter notebook where the training and testing data is loaded in, deep CNN model is implemented and trained, and results are analyzed


## Requirements

MATLAB version R2020b Update 2 (or a more recent version) is needed to run the image pre-processing. 

Python3 is required to run the code. 

To set up the environment- 

Create a virtual environment in a local repository:

```setup
virtualenv env
```
Then activate the virtual environment: 
```setup
source env/bin/activate
```
Install Jupyter notebook: 
```setup
pip install jupyter_http_over_ws 
jupyter serverextension enable --py jupyter_http_over_ws
```
Open a Jupyter notebook in the environment: 
```setup
jupyter notebook --NotebookApp.allow_origin='https://colab.research.google.com' \
  --port=9090 --no-browser
```
The url can be used to set up a local runtime in google colab. The **main.ipynb** can then be run to train and test the model. 

## Pre-Procesing 
In order to reproduce this work, the whole slide cytology images must be processed into 75x75 pixel image patches and labels must be created for each patch. MATLAB scripts should be run following this checklist: 

  1. Run the **preProcessData.m** script to load in data and split the data into test and train sets. The output from this code is the creation of MATLAB structure arrays which should be manually saved in the the local directory: **testCSV.mat, testImages.mat, trainCSV.mat, and trainImages.mat.** These MATLAB structure arrays are saved and available in this repository and can be loaded into later MATLAB pre-processing scripts as necessary. 
  2. Nuclei masks must then be created. Run the **testingMasksDistanceMeasures.m** script to create masks for the images in the testing set. Run the **distanceCalc.m** script to create the nuclei masks for images in the training set. 
  3. Once nuclei masks are created for every image, the image patches and labels can be created. Run **imagePatches.m** to create patches and labels (for each patch) for each image in the training set. Run **testingPatchCreation** to create patches and labels (for each patch) for each image in the testing set. The output of of each file is the image patches and a csv file containing all of the labels of each image patch in the set. 
  4. The number of image patches created in each set, and the percentage of postively labelled patches (labelled as nuclei) in the train and test set can be calculated by running the **trainPatchPercentages.m** file and the **testingPatchPercentages.m** file respectively. 

## Training

Code to train and test the model can be found in the **main.ipynb** file. Image patches from both the train and test set, along with their respective labels saved in a .csv file, are needed to train and test the model. 

The training and testing image patch datasets used to train and test the model are too big to be uploaded into the GitHub. Please contact me if you would like the data. The image patches for both the training and testing sets can be created by following the Pre-Processing guide and running the MATLAB scripts. 
 

## Results

The model achieves the following results on the testing set:

| Results      |  Precision |  Recall |  F1-Score |
| ------------ | ---------- | ------- | --------- |  
| Overall      |    88%     |   84%   |    86%    | 
| Nuclei Class |    77%     |   69%   |    73%    |  


A whole slide test image. Blue represents ground truth nuclei and red represents nuclei patches that were labelled positive from the output of the DL network. This image was created in the hitMap.m script. In this example image, there are 10 manually counted "hit" nuclei and 3 missed nuclei at the image border. There are a total of 13 nuclei in this image. The **countNuclei.m** can be run to calculate the percentage of missed nuclei from the testing output of the model. 

<img width="307" alt="patch" src="https://user-images.githubusercontent.com/47262723/115133722-4c7dd780-9fd8-11eb-96b2-123fa18c4b15.png">



