---
title: "README"
author: "Thiago Akio Nakamura"
date: "March 19, 2015"
output: html_document
---

# Getting and Cleaning Data

## Course Project

The purpose of this project is to demonstrate our ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. The data collected is from the accelerometers from the Samsung Galaxy S smartphone. The orifinal description taken from its website (click [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) for details):

The R script called run_analysis.R does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### The `run_analysis.R` script
The `run_analysis.R` script can be run directly. Before actually processing the data, the script performs the following tasks:

* Checks and install required packages, then loads them.
* Download and unzips the data, if the default data directory is not found.
* Reads the necessary files from the original dataset to start processing the data set.
* After processing the data, the output tidy data will be written on `tidy_data.txt` in the current directory.

For more details, read the CodeBook.md.

### Dependencies

```run_analysis.R``` file will help you to install the dependencies automatically. It depends on ```reshape2``` and ```plyr```.