# GettingAndCleaningDataCourseProject
Source of the original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The code contained in the file run_analysis.R it works as follows:

Download and unzip the dataset

- Reads features.txt
- Reads activity_labels.txt
- Reads the training set
- Extracts only the measurements on the mean and standard deviation for each measurement
- Reads the test set
- Extracts only the measurements on the mean and standard deviation for each measurement
- Merges the training and the test sets to create one data set
- Appropriately labels the data set with descriptive variable names
- Creates a independent tidy data set with the average of each variable for each activity and each subject. 


