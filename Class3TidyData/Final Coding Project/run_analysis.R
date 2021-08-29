#You should create one R script called run_analysis.R that does the following. 

#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Loading libraries
library(tidyverse)
library(dplyr)

#Check if the file exists
file <- "getdata_projectfiles_UCI HAR Dataset.zip"
if(!file.exists(file)){
        url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(url, file, method = "curl")
}
#Check if the directory exists
if(!file.exists("UCI HAR Dataset")){
        unzip(file)
}

#Assign ALL the dataframes
feature <- read.table("UCI HAR Dataset/features.txt", col.names = c("num", "descriptive"))
activitylabel <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activity_code", "activity"))
subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))
xtest <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = c(feature$descriptive))
ytest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = c("activity_code"))
subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = c(feature$descriptive))
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c("activity_code"))

#Merge train and test datasets to make a big dataset. This isn't technically a merge, more of an append.
X <- rbind(xtrain, xtest)
y <- rbind(ytrain, ytest)

MasterSubject <- rbind(subjecttest, subjecttrain)

MasterMerge <- cbind(MasterSubject, X, y)

#Select only columns that have mean and stdev

CleanData <- MasterMerge %>% select(subject, activity_code, contains("means"), contains("std"))

#Descriptive activity names

CleanData$activity_code <- activitylabel[CleanData$activity_code, 2]



#Make the varnames nice and pretty
names(CleanData)[2] = "activity"
names(CleanData)<-gsub("Acc", "accelerometer", names(CleanData))
names(CleanData)<-gsub("Gyro", "gyroscope", names(CleanData))
names(CleanData)<-gsub("BodyBody", "body", names(CleanData))
names(CleanData)<-gsub("Mag", "magnitude", names(CleanData))
names(CleanData)<-gsub("^t", "time", names(CleanData))
names(CleanData)<-gsub("^f", "frequency", names(CleanData))
names(CleanData)<-gsub("tBody", "timebody", names(CleanData))
names(CleanData)<-gsub("-mean()", "mean", names(CleanData), ignore.case = TRUE)
names(CleanData)<-gsub("-std()", "standard deviation", names(CleanData), ignore.case = TRUE)
names(CleanData)<-gsub("-freq()", "frequency", names(CleanData), ignore.case = TRUE)

#Create another dataframe with the average of each activity and each subject

OutputData <- CleanData %>%
        group_by(subject, activity) %>%
        summarize_all(funs(mean))

write.table(OutputData, "OutputData.txt", row.names = FALSE)
