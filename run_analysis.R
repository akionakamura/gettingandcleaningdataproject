## by Thiago Akio Nakamura
## Project for the Coursera's Getting and Cleaning Data course
## March 2015
## 
## Main script that outputs the final result in tidy_data.txt
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

rm(list = ls())

# Load or install required packages
if (!require("data.table")) {
    install.packages("data.table", dependencies = TRUE)
}

if (!require("reshape2")) {
    install.packages("reshape2", dependencies = TRUE)
}
require("data.table")
require("reshape2")

if(!file.exists("UCI HAR Dataset")){
    fileURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
    download.file(url=fileURL, destfile="dataset.zip", method = "curl")
    unzip("dataset.zip")
}


# Load data
message("Loading training data...")
train.x <- read.table("./UCI HAR Dataset/train/X_train.txt")
train.subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train.y <- read.table("./UCI HAR Dataset/train/y_train.txt")

message("Loading testing data...")
test.x <- read.table("./UCI HAR Dataset/test/X_test.txt")
test.subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test.y <- read.table("./UCI HAR Dataset/test/y_test.txt")

# Load meta-data
message("Loading meta data...")
activity.label <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

# Convert activity value for its name as factors
message("Converting factors...")
test.y <- mapvalues(as.factor(test.y[[1]]), from = as.character(1:6), to = as.character(activity.label[,2]))
train.y <- mapvalues(as.factor(train.y[[1]]), from = as.character(1:6), to = as.character(activity.label[,2]))

# Convert subject to factor
test.subject <- as.factor(test.subject[[1]])
train.subject <- as.factor(train.subject[[1]])

# Naming the variables
message("Setting proper names...")
names(test.x) <- as.character(features[,2])
names(train.x) <- as.character(features[,2])

# Union of the activity, subject and features
message("Merging data...")
full.test <- data.frame(activity = test.y, subject = test.subject, test.x)
full.train <- data.frame(activity = train.y, subject = train.subject, train.x)

# Merge training and testing data
full.data <- rbind(full.train, full.test)
features <- names(full.data)

# Delete unecessary variable
message("Deleting unnecessary variables...")
rm(list = c("activity.label",
            "full.test", "full.train", 
            "test.x", "train.x",
            "test.subject", "train.subject", 
            "test.y", "train.y"))

# Select only mean and sdt measurements
message("Selecting only desired measurements...")
mean.idx <- grep("mean", features)
std.idx <- grep("std", features)
selected.data <- full.data[, c(1, 2, mean.idx, std.idx)]

# Create new data frame with the mean of each variable for each activity and each subject
message("Creating new data frame...")
data.melt <- melt(selected.data, id = c("activity", "subject"))
data.mean <- dcast(data.melt, subject + activity ~ variable, mean)

# Writing final tidy data
message("Writing final tidy data...")
write.table(data.mean, file = "./tidy_data.txt", row.names = F)


