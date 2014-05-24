Coursera - Getting and Cleaning Data May 2014 - Course Project - Code Book
==========================================================================
## Raw data

Human Activity Recognition Using Smartphones Dataset

Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.

Smartlab - Non Linear Complex Systems Laboratory

DITEN - Università degli Studi di Genova.

Via Opera Pia 11A, I-16145, Genoa, Italy.

activityrecognition@smartlab.ws

www.smartlab.ws

A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Variables in raw data

In the original dataset observations for 30 volunteers were split into test (30%) and train (70%) datasets.For each subject, measurements were taken in fixed-width
sliding windows of 2.56 sec and 50% overlap while wearing a smartphone Samsung
Galaxy S II on the waist.

Under the experiment, six activities were observed: WALKING, WALKING_UPSTAIRS,
WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING. 561 features were generated for
every observation. 

## Transformations
We performed the following transformations:

1. Merged test and train data sets and attached feature names to appropriate 
column names and subject and activity identifiers to appropriate rows.

2. Limited the list of features to means and standard deviations of each 
measurements by subsetting the columns that contain "mean" or "std" as part of 
the original name.

3. Replaced numerical codes with descriptive activity names, per activity_label.txt in the original dataset.

4. Ensured that the column labels (i.e. feature names) have desciptive names, in
particular, eliminated all human-error duplicates in names.

5. Produced a separate dataset tidydata.txt containing only the averages of each variable for each activity and each subject.
