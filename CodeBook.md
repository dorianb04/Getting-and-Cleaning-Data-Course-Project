# Code book of the project

## How to get the tiny data set

Execute the R script that is in the file **run_analysis.R**.

## The source data
A full description of the original data is available here : https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.
The zip file containing all the data can be downloaded via this link : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## The R script
The following steps are performed in the code **run_analysis.R** :

-  Dowloading the file if it does not exists.
-  Reading the test and train dataset and mergind them together.
    - Reading sets
    - Merging dataSets
-  Extract only the measurements on the mean and standard deviation for each measurement
-  Merging the dataSet to name each rows by activity
-  Creating the tidy dataSet
