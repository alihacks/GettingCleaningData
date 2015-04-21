## Assignment for Getting and cleaning data
The script in this repository:
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## To execute
Requires R data table package
Run the script run_analysis.R, it will download the dataset, extract it and perform the analysis to generate mean and sd for each subject and activity in a file named tidy_data_mean_sd.csv

See Codebook.md for the codebook on the data produced