# Nuclei Detection - Classifying cervical cytology smears using a supervised learning approach 

This repository is the official implementation of Nuclei Detection - Classifying cervical cytology smears using a supervised learning approach. 

This is a reproducibility study of the deep learning method in the paper by Phoulady et _al._ titled "A New Cervical Cytology Dataset for Nucleus Detection and Image Classification (Cervix93) and Methods for Cervical Nucleus Detection". Link to the paper: https://arxiv.org/abs/1811.09651. Full reference: Phoulady HA, Mouton PR: A new cervical cytology dataset for nucleus detection and image classification (cervix93) and methods for cervical nucleus detection. arXiv preprint arXiv:181109651 2018. 

This repository is written by Brittaney Everitt (student number 10211957) for the final project in CISC 867 Deep Learning. 

## Requirements

MATLAB version R2020b Update 2 (or a more recent version) is needed to run the image pre-processing. 

Python3 is required to run the code. 

To set up the environment: 
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

## Evaluation

To evaluate my model on ImageNet, run:

```eval
python eval.py --model-file mymodel.pth --benchmark imagenet
```

>📋  Describe how to evaluate the trained models on benchmarks reported in the paper, give commands that produce the results (section below).

## Pre-trained Models

You can download pretrained models here:

- [My awesome model](https://drive.google.com/mymodel.pth) trained on ImageNet using parameters x,y,z. 

>📋  Give a link to where/how the pretrained models can be downloaded and how they were trained (if applicable).  Alternatively you can have an additional column in your results table with a link to the models.

## Results

Our model achieves the following performance on :

### [Image Classification on ImageNet](https://paperswithcode.com/sota/image-classification-on-imagenet)

| Model name         | Top 1 Accuracy  | Top 5 Accuracy |
| ------------------ |---------------- | -------------- |
| My awesome model   |     85%         |      95%       |

>📋  Include a table of results from your paper, and link back to the leaderboard for clarity and context. If your main result is a figure, include that figure and link to the command or notebook to reproduce it. 


## Contributing

>📋  Pick a licence and describe how to contribute to your code repository. 
