library(dplyr)
library(reshape2)

# Download file if not ixist

if(!file.exists("dataset.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "dataset.zip")
}

#Unzip file
if(!file.exists("./UCI HAR Dataset/features.txt")){
  unzip("dataset.zip")
}


ColNames<- read.table(file="./UCI HAR Dataset/features.txt")
activityLabels <- read.table(file="./UCI HAR Dataset/activity_labels.txt")
colnames(activityLabels)<-c("id","activity")



testSet <- read.table(file="./UCI HAR Dataset/test/X_test.txt")
trainingSet <- read.table(file="./UCI HAR Dataset/train/X_train.txt")

unionSet <-rbind(testSet,trainingSet)

colnames(unionSet)<-ColNames[,2]
unionSubset <- unionSet[c(grep("std\\(\\)", colnames(unionSet)),grep("mean\\(\\)", colnames(unionSet)))]



subjectTestSet <- read.table(file="./UCI HAR Dataset/test/subject_test.txt")
subjectTrainingSet <- read.table(file="./UCI HAR Dataset/train/subject_train.txt")

unionSubject <- rbind(subjectTestSet,subjectTrainingSet)

unionSubset$subject <- unionSubject[,1]
colnames(unionSubset$subject)<-"subject"




activityTestSet <- read.table(file="./UCI HAR Dataset/test/y_test.txt")
activityTrainingSet <- read.table(file="./UCI HAR Dataset/train/y_train.txt")
unionActivity <-rbind(activityTestSet,activityTrainingSet)
unionSubset$activity_id <- unionActivity[,1]

unionSubset <- merge(activityLabels,unionSubset,sort=FALSE,by.y = "activity_id",by.x = "id")

write.table(unionSubset, "cleaned_data_set.txt",row.name=FALSE)


Melt <- melt(unionSubset,id = c("subject","activity"),measure.var=colnames(unionSet[c(grep("std\\(\\)", colnames(unionSet)),grep("mean\\(\\)", colnames(unionSet)))]))

tidyData <- dcast(Melt,subject+activity~variable, mean)

write.table(tidyData, "tidyData.txt",row.name=FALSE)