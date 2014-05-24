# Coursera Getting and Cleaning Data May 2014. Course Project

setwd("C:/Users/Tuomas/Documents/Olga/Git/GettingAndCleaningData_Project")
#Get data and load into R
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = "./data/activityGalaxy.zip")
dateDownloaded<-date()
library(utils)
unzip("./data/activityGalaxy.zip",exdir="./data")
list.files ()

# 1.Merge the training and the test sets to create one data set.
var<-read.table("./data/UCI HAR Dataset/features.txt",stringsAsFactors = FALSE)
act.lbl<-read.table("./data/UCI HAR Dataset/activity_labels.txt")

test.msmt<-read.table("./data/UCI HAR Dataset/test/X_test.txt")
test.lbl<-read.table("./data/UCI HAR Dataset/test/y_test.txt")
test.sub<-read.table("./data/UCI HAR Dataset/test/subject_test.txt")
test<-cbind(test.sub,test.lbl,test.msmt)


train.msmt<-read.table("./data/UCI HAR Dataset/train/X_train.txt")
train.lbl<-read.table("./data/UCI HAR Dataset/train/y_train.txt")
train.sub<-read.table("./data/UCI HAR Dataset/train/subject_train.txt")
train<-cbind(train.sub,train.lbl,train.msmt)

data.edited<-rbind(test,train)
names(data.edited)<-c("Subject","Activity",var$V2)


#clean memory
rm(test.msmt,test.lbl,test.sub,test,train.msmt,train.lbl,train.sub,train,var)

# 2.Extract only the measurements on the mean and standard deviation for each 
#   measurement. 
col.mean<-grep("mean",names(data.edited),ignore.case=TRUE)
col.std<-grep("std",names(data.edited),ignore.case=TRUE)
data.edited<-data.edited[,c(1,2,col.mean,col.std)]

# 3.Use descriptive activity names to name the activities in the data set. 
#(aka replace numerical values in the Activity column with labels)
data.edited$Activity<-act.lbl[data.edited$Activity,"V2"]
rm(act.lbl)

# 4.Appropriately label the data set with descriptive activity names. 
#(aka make col names more human readable)
col.dbl<-grep("BodyBody",names(data.edited),ignore.case=TRUE)
col.dbl
#list variables with duplicates
names(data.edited[,col.dbl])
#check if column names without duplicates already exist
match(c("fBodyAccJerkMag-mean()","fBodyAccJerkMag-meanFreq()", 
        "fBodyGyroMag-mean()", "fBodyGyroMag-meanFreq()","fBodyGyroJerkMag-mean()",
        "fBodyGyroJerkMag-meanFreq()","fBodyAccJerkMag-std()","fBodyGyroMag-std()",         
        "fBodyGyroJerkMag-std()"),names(data.edited))
#change column names
colnames(data.edited)[col.dbl]<-c("fBodyAccJerkMag-mean()","fBodyAccJerkMag-meanFreq()", 
        "fBodyGyroMag-mean()", "fBodyGyroMag-meanFreq()","fBodyGyroJerkMag-mean()",
        "fBodyGyroJerkMag-meanFreq()","fBodyAccJerkMag-std()","fBodyGyroMag-std()",         
        "fBodyGyroJerkMag-std()")
col.dbl1<-grep("BodyBody",names(data.edited),ignore.case=TRUE)
col.dbl1

# 5.Create a second, independent tidy data set with the average of each 
#   variable for each activity and each subject. 
data.tidy<-aggregate(. ~ Subject+Activity,data = data.edited,FUN=mean)
write.table(data.tidy,file="tidydata.txt",sep=",")