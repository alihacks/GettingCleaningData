# This script:
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# We need the data table library for processing
library(data.table)

# Get the data needed, unzip
zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "UCI_Dataset.zip"
dirName <- "./UCI HAR Dataset/"


 download.file(zipUrl, destfile = zipFile, method = "curl")
 unzip(zipFile)  

tableTestX <- read.table(paste(dirName,"test/X_test.txt", sep=""),header=FALSE)
tableTestY <- read.table(paste(dirName,"test/y_test.txt", sep=""),header=FALSE)
tableTestSubject <- read.table(paste(dirName,"test/subject_test.txt", sep=""),header=FALSE)

tableTrainX <- read.table(paste(dirName,"train/X_train.txt", sep=""),header=FALSE)
tableTrainY <- read.table(paste(dirName,"train/y_train.txt", sep=""),header=FALSE)
tableTrainSubject <- read.table(paste(dirName,"train/subject_train.txt", sep=""),header=FALSE)

# Get the metadata
tableLabels <- read.table(paste(dirName,"activity_labels.txt", sep=""),colClasses="character", header=FALSE)
tableFeatures <- read.table(paste(dirName,"features.txt", sep=""),colClasses="character", header=FALSE)

# Appropriately label the data sets. Column names come from 2nd col of features file
colnames(tableTestX)<-tableFeatures$V2
colnames(tableTrainX)<-tableFeatures$V2
# Define column names for single column sets manually
setnames(tableLabels,c("Number","Label"))
setnames(tableTestY,"Activity")
setnames(tableTrainY, "Activity")
setnames(tableTestSubject, "Subject")
setnames(tableTrainSubject, "Subject")

# Name the activities according to labels
tableTestY$Activity <- factor(tableTestY$Activity,levels=tableLabels$Number, labels=tableLabels$Label)
tableTrainY$Activity <- factor(tableTrainY$Activity,levels=tableLabels$Number, labels=tableLabels$Label)


# Merge the training and test sets
tableTest <- cbind(tableTestX, tableTestY, tableTestSubject)
tableTrain <- cbind(tableTrainX, tableTrainY, tableTrainSubject)
tableAll <- data.table(rbind(tableTest,tableTrain)) # Append both sets into one

# Calculate the mean and the sd per subject and activity
tableAggregates <- tableAll[,lapply(.SD,mean),by="Subject,Activity"]

# Write output file
write.table(tableAggregates, file="tidy_data_mean_sd.csv",sep=",", row.names=FALSE)

