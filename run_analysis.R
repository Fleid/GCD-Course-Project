###### Dependecies



###### Loading the data sets

# 'activity_labels.txt': Links the class labels with their activity name
activityLabels <- read.csv("UCI HAR Dataset/activity_labels.txt",sep=" ",header=FALSE, col.names = c("ActivityLabelID","ActivityLabelName"))

# 'features.txt': List of all features.
featureLabels <- read.csv("UCI HAR Dataset/features.txt",sep=" ",header=FALSE, col.names = c("FeatureLabelID","FeatureLabelName"))

#'test/X_test.txt': Test set.
testX <- read.fwf(file="UCI HAR Dataset/test/X_test.txt",widths=rep(16,561), col.names=featureLabels$FeatureLabelName)
#'test/y_test.txt': Test labels.
testY <- read.csv("UCI HAR Dataset/test/Y_test.txt",sep=" ",header=FALSE, col.names = "ActivityLabelID")
#'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
testSubject <- read.csv("UCI HAR Dataset/test/subject_test.txt",sep=" ",header=FALSE, col.names = "SubjectID")


#'train/X_train.txt': Training set.
trainX <- read.fwf(file="UCI HAR Dataset/train/X_train.txt",widths=rep(16,561), col.names=featureLabels$FeatureLabelName)
#'train/y_train.txt': Training activity labels.
trainY <- read.csv("UCI HAR Dataset/train/Y_train.txt",sep=" ",header=FALSE, col.names = "ActivityLabelID")
#'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
trainSubject <- read.csv("UCI HAR Dataset/train/subject_train.txt",sep=" ",header=FALSE, col.names = "SubjectID")

###### Merging each files into a single one
testX$ActivityLabelID <- testY$ActivityLabelID
testX$SubjectID <- testSubject$SubjectID

trainX$ActivityLabelID <- trainY$ActivityLabelID
trainX$SubjectID <- trainSubject$SubjectID

###### Merging the training and the test sets to create one data set
allX <- rbind(testX,trainX)

###### Extracting only the measurements on the mean and standard deviation for each measurement
msX <- allX[,grep("(\\.std\\.)|(\\.mean\\.)|(ActivityLabelID)|(SubjectID)",names(allX))]

###### Uses descriptive activity names to name the activities in the data set
msXa <- merge(msX,activityLabels,by.x="ActivityLabelID",by.y="ActivityLabelID")
  
##### Appropriately labels the data set with descriptive variable names.

###### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(reshape2)
tidyX <- melt(msXa, id=c("SubjectID","ActivityLabelID","ActivityLabelName"),measures.vars=grep(".std.|.mean.",names(msXa)))
finalX <- dcast(tidyX, SubjectID + ActivityLabelName ~ variable,mean)

###### Writing the data set to a file

write.table(finalX,file="tidyX.txt",append=FALSE,row.names=FALSE,col.names=TRUE)


