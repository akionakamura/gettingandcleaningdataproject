---
title: "CodeBook"
author: "Thiago Akio Nakamura"
date: "March 19, 2015"
output: html_document
---

This code book describes the variables, the data, and any transformations or work that was performed to clean up the original data in order to achieve the desired result.

## Data source
The data collected is from the accelerometers from the Samsung Galaxy S smartphone.

* Click [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) for the original data.
* Click [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) for the original information about the data.

### General information about the data

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## Data Transformation

The following files from the original dataset are directly read as `data.frame`s by the `read.table` function:

* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'train/subject_train.txt': Subject who performed the activity for each sample on the training set.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.
* 'test/subject_train.txt':  Subject who performed the activity for each sample on the testing set.

The transformations can be summarized in 5 steps:

1. The `subject` and `activity` were encoded `as.factor`. The `activity` levels were `mapvalue`'d accordingly with the 'features.txt' content.
2. Two new `data.frame`'s were created uniting the `activity` and `subject` variable to the training and testing features values sets.
3. The new training and testing set were merged directly with `rbind`.
4. With `grep` only those features with 'mean' or 'std' in their names, as well as `subject` and `activity`, were selected to create a new data frame.
5. This last data frame was `melt`'d by both `subject` and `activity` and then `dcast`'d to obtain the mean of each variable (81) for each `subject` (30) and each `activity` (6), resulting in a 180 by 81 final tidy data set.