---
title: "CodeBook"
author: "GioHzn"
date: "24-4-2022"
output: html_document
---

## Getting and Cleaning Data Assignment Codebook
### 1. General information regarding the dataset
This dataset contains data of 30 subjects who performed six activities (walking, walking upstairs, walking downstairs, sitting, standing, and laying) while wearing a smartphone (Samsung Galaxy S II) on the waist. 

This dataset was donated by Davide Anguita et. al. (2012)
For more information about the dataset refer to:
"http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#"

The Dataset contains 28 .txt files with data. For this Assignment 8 of these have been used:
1. X_train
2. y_train
3. subject_train
4. X_test
5. y_test
6. subject_test
7. features
8. activity_labels

### 2. Step taken in cleaning the data
The dataset was downloaded using the link provided within the assignment description:
"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

The dataset was saved under "Dataset.zip" unzipped resulting in a directory "UCI HAR Dataset"
The following data was read and combined (by rows) and named the following:
* X_train.txt and X_test.txt             -> Data
* y_train.txt and y_test.txt             -> Label
* subject_train.txt and subject_test.txt -> Subject

Data: contains the measured raw data per observation
Label: contains the coded-activity label for each observation (e.g. 1-6)
Subject: contains the subject per observation

Next the column names were extracted from the "features.txt" file.
Within these column names, the ones containing either "mean" or "stdv" were selected
and added to the "Data" set. Any characters such as "()" / "-" were removed from the 
column names and all letter were set to lowercase.

The "Label" set contains numeric data instead of descriptive, while the "activity_labels.txt" file contains the legend for the "label" set.
As such, the activity names were extracted from the "activity_labels.txt" file.
Activity names were then cleaned by removing "_" characters, and letters were set to lowercase.
Afterwards, activity labels were then added to the "Label" dataset.
Lastly, the column name of the "Label" data was set to "Activity"

As a last step to take before combing the 3 datasets, the colname of the "Subject" set was changed to "Subject" to be more descriptive.
Then "Subject", "Label" and "Data" sets were combined (in that order) creating the "CleanData" set.

This set was saved separately under "Clean_Data.txt"

Additionally, using the dplyr package, an other tidy dataset was generated containing the mean values of all variables per activity per subject and saved under "Data_Average.txt"

