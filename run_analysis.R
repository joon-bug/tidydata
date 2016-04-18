##This script must be run in the same folder as the downloaded unzipped UCI HAR Dataset

setwd("UCI HAR Dataset")
setwd("test")
library(dplyr)
library(tidyr)

#reading the test set data along with the test set subjects and activities
testset<-read.table("x_test.txt")
testsetsubjects<-read.table("subject_test.txt")
testsetactivity<-read.table("y_test.txt")

#repeat for trainset
setwd("..")
setwd("train")
trainset<-read.table("x_train.txt")
trainsetsubjects<-read.table("subject_train.txt")
trainsetactivity<-read.table("y_train.txt")

#Step 1 - combine the train and test sets
combinedset<-rbind(testset,trainset)
combinedsubjects<-rbind(testsetsubjects,trainsetsubjects)
combinedactivities<-rbind(testsetactivity,trainsetactivity)

#Step 2 - Extract only means and standard deviations for each feature
setwd("..")
features<-read.table("features.txt")
extract<-c(grep("std",features$V2),grep("mean",features$V2))
combinedset<-select(combinedset,extract)
featuresextract<-filter(features,V1 %in% extract)

combinedset$subject<-combinedsubjects
combinedset$activity<-combinedactivities

#convert subject and activity variables into integers from a dataframe
combinedset$subject <- as.integer(unlist(combinedset$subject))
combinedset$activity <- as.integer(unlist(combinedset$activity))

#Step 3 read in the activity labels, and replace the current integer indicators
#for the actual text descriptions of the activities. This is done using merge
#and then the integer column will be removed using select.
activitylabels<-read.table("activity_labels.txt")
combinedset<-merge(combinedset,activitylabels,by.x = "activity", by.y = "V1")
combinedset<-select(combinedset,-1)
combinedset<-rename(combinedset,Activity=V2.y)

#step 4&5 - name the variables with descriptive names and create a tidy set
tidyset<-gather(combinedset,Feature,Time,-subject,-Activity)
tidyset<-mutate(tidyset,featureid=extract_numeric(Feature))
tidyset<-merge(tidyset,featuresextract,by.x="featureid",by.y="V1")
tidyset<-rename(tidyset,featurename=V2)
tidyset<-select(tidyset,-featureid,-Feature)
tidyset<-group_by(tidyset,subject,Activity,featurename)
tidysummary<-summarize(tidyset,Value=mean(Time))
write.table(tidysummary,file="tidydata.txt")