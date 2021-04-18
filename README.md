# Nuclei Detection - Classifying cervical cytology smears using a supervised learning approach 

This repository is the official implementation of Nuclei Detection - Classifying cervical cytology smears using a supervised learning approach. 

This is a reproducibility study of the deep learning method in the paper by Phoulady et _al._ titled "A New Cervical Cytology Dataset for Nucleus Detection and Image Classification (Cervix93) and Methods for Cervical Nucleus Detection". Link to the paper: https://arxiv.org/abs/1811.09651. Full reference: Phoulady HA, Mouton PR: A new cervical cytology dataset for nucleus detection and image classification (cervix93) and methods for cervical nucleus detection. arXiv preprint arXiv:181109651 2018. 

This repository is written by Brittaney Everitt (student number 10211957) for the final project in CISC 867 Deep Learning. 

## Repository Details 

**EDF directory** → Full frame cytology smears from the Cervix93 Cytology dataset. This dataset is from the following Github: https://github.com/parham-ap/cytology_dataset. It contains 93 real extended depth of field images (at 40x magnification) of size 1280x960 pixels. The manually marked nuclei coordinates are recorded in a csv file for each image in the dataset. 

**Pre-processsing Directory**

  1. **distanceCalc.m** → A MATLAB script which creates nuclei masks for the training data based on a distance  measure to the manually marked nuclei coordinates. 

  2. **imagePatches** → A MATLAB script which creates 75x75 pixels image patches for all of the training images. A csv file is also created which contains labels for each patch if it contains a nucleus or not. 

  3. **labels.csv** → A csv file provided by Phoulady et _al._ from the following Github: https://github.com/parham-ap/cytology_dataset/tree/master/dataset. The csv file has labels to determine which whole slide cytology images are in the training (0) and testing sets (1). 

  4. **preProcessData.m** → A MATLAB script which loads in the images and the manually marked nuclei coordinates in each image and splits the data into training and testing sets based on the label in the labels.csv file. The image data and array of nuclei coordinates for each image are stored in a MATLAB structure array. 

  5. **testCSV.mat** → MATLAB structure array of nuclei corrdinates for each image in the test set. 

  6. **testImages** → MATLAB structure array of the whole slide images in the test set.

  7. **testingMasksDistanceMeasures** → A MATLAB script which creates nuclei masks for the testing data based on a distance measure to the manually marked nuclei coordinates. 
  
  8. **testingPatchCreation** → A MATLAB script which creates 75x75 pixels image patches for all of the testing images. A csv file is also created which contains labels for each patch if it contains a nucleus or not. 

  9. **testingPatchLabelsOrdered.csv** → A csv file which contains the labels for each patch created from the testing images. 

  10. **testingPatchPercentages.m** → A MATLAB script which calculates the percentage of positively labelled patches in the test set. 

  11. **trainCSV.mat** → MATLAB structure array of nuclei corrdinates for each image in the train set.

  12. **trainImages.mat** → MATLAB structure array of the whole slide images in the train set.

  13. **trainPatchPercentages.m** → A MATLAB script which calculates the percentage of positively labelled patches in the train set. 

  14. **trainingPatchLabelsOrdered.csv** → A csv file which contains the labels for each patch created from the training images. 


**PredictionTestLabels.csv** → Predicted labels of each image patch in the testing set. This is output from the deep learning model. 

**countNuclei.m** → A MATLAB script which calculates the percentage of missed nuclei from the testing output of the model. 

**hitMap.m** → A MATLAB script to create the hitmaps for testing data. Each image has predicted nuclei markers, from the the output from the deep learning model, and ground truth nuclei coordinates on each cytology whole slide image. 

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
The url can be used to set up a local runtime in google colab. 

The training and testing image patch datasets used in the model are too big to be uploaded into the GitHub. Please contact me if you would like the data. 


## Training

To train the model(s) in the paper, run this command:

```train
python train.py --input-data <path_to_data> --alpha 10 --beta 20
```

>📋  Describe how to train the models, with example commands on how to train the models in your paper, including the full training procedure and appropriate hyperparameters.


## Results

The model achieves the following results:

| Results      |  Precision |  Recall |  F1-Score |
| ------------ | ---------- | ------- | --------- |  
| Overall      |    88%     |   84%   |    86%    | 
| Nuclei Class |    77%     |   69%   |    73%    |  


