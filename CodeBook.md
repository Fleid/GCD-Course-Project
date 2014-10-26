# Getting and Cleaning Data Course Project
#### Source and reference

1. [Dataset][2] and [original web source][3]
2. [Coursera reference website][1]

#### Data

**(From the original source)**

One observation (one row) of the dataset represents a measurement from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.

**(Added during this analysis)**

The data was originally split in 2 datasets (training data and test data, for machine learning experiments) and multiple files, it is now merged again. The data has been merged, subsetted, cleaned and labeled in one dataset. 

**The final file holds one row for each activity and each subject, and displays the average of the variable at that point.**

#### Variables in the final datasets

Average of each variable for each activity and each subject:

Variable | Description 
------------ | -------------
SubjectID	| Id of the subjectActivityLabelName	| Label of the activityfBodyAcc.mean...X	| Mean of the variable by subject and activityfBodyAcc.mean...Y	| Mean of the variable by subject and activityfBodyAcc.mean...Z	| Mean of the variable by subject and activityfBodyAcc.std...X	| Mean of the variable by subject and activityfBodyAcc.std...Y	| Mean of the variable by subject and activityfBodyAcc.std...Z	| Mean of the variable by subject and activityfBodyAccJerk.mean...X	| Mean of the variable by subject and activityfBodyAccJerk.mean...Y	| Mean of the variable by subject and activityfBodyAccJerk.mean...Z	| Mean of the variable by subject and activityfBodyAccJerk.std...X	| Mean of the variable by subject and activityfBodyAccJerk.std...Y	| Mean of the variable by subject and activityfBodyAccJerk.std...Z	| Mean of the variable by subject and activityfBodyAccMag.mean..	| Mean of the variable by subject and activityfBodyAccMag.std..	| Mean of the variable by subject and activityfBodyBodyAccJerkMag.mean..	| Mean of the variable by subject and activityfBodyBodyAccJerkMag.std..	| Mean of the variable by subject and activityfBodyBodyGyroJerkMag.mean..	| Mean of the variable by subject and activityfBodyBodyGyroJerkMag.std..	| Mean of the variable by subject and activityfBodyBodyGyroMag.mean..	| Mean of the variable by subject and activityfBodyBodyGyroMag.std..	| Mean of the variable by subject and activityfBodyGyro.mean...X	| Mean of the variable by subject and activityfBodyGyro.mean...Y	| Mean of the variable by subject and activityfBodyGyro.mean...Z	| Mean of the variable by subject and activityfBodyGyro.std...X	| Mean of the variable by subject and activityfBodyGyro.std...Y	| Mean of the variable by subject and activityfBodyGyro.std...Z	| Mean of the variable by subject and activitytBodyAcc.mean...X	| Mean of the variable by subject and activitytBodyAcc.mean...Y	| Mean of the variable by subject and activitytBodyAcc.mean...Z	| Mean of the variable by subject and activitytBodyAcc.std...X	| Mean of the variable by subject and activitytBodyAcc.std...Y	| Mean of the variable by subject and activitytBodyAcc.std...Z	| Mean of the variable by subject and activitytBodyAccJerk.mean...X	| Mean of the variable by subject and activitytBodyAccJerk.mean...Y	| Mean of the variable by subject and activitytBodyAccJerk.mean...Z	| Mean of the variable by subject and activitytBodyAccJerk.std...X	| Mean of the variable by subject and activitytBodyAccJerk.std...Y	| Mean of the variable by subject and activitytBodyAccJerk.std...Z	| Mean of the variable by subject and activitytBodyAccJerkMag.mean..	| Mean of the variable by subject and activitytBodyAccJerkMag.std..	| Mean of the variable by subject and activitytBodyAccMag.mean..	| Mean of the variable by subject and activitytBodyAccMag.std..	| Mean of the variable by subject and activitytBodyGyro.mean...X	| Mean of the variable by subject and activitytBodyGyro.mean...Y	| Mean of the variable by subject and activitytBodyGyro.mean...Z	| Mean of the variable by subject and activitytBodyGyro.std...X	| Mean of the variable by subject and activitytBodyGyro.std...Y	| Mean of the variable by subject and activitytBodyGyro.std...Z	| Mean of the variable by subject and activitytBodyGyroJerk.mean...X	| Mean of the variable by subject and activitytBodyGyroJerk.mean...Y	| Mean of the variable by subject and activitytBodyGyroJerk.mean...Z	| Mean of the variable by subject and activitytBodyGyroJerk.std...X	| Mean of the variable by subject and activitytBodyGyroJerk.std...Y	| Mean of the variable by subject and activitytBodyGyroJerk.std...Z	| Mean of the variable by subject and activitytBodyGyroJerkMag.mean..	| Mean of the variable by subject and activitytBodyGyroJerkMag.std..	| Mean of the variable by subject and activitytBodyGyroMag.mean..	| Mean of the variable by subject and activitytBodyGyroMag.std..	| Mean of the variable by subject and activitytGravityAcc.mean...X	| Mean of the variable by subject and activitytGravityAcc.mean...Y	| Mean of the variable by subject and activitytGravityAcc.mean...Z	| Mean of the variable by subject and activitytGravityAcc.std...X	| Mean of the variable by subject and activitytGravityAcc.std...Y	| Mean of the variable by subject and activitytGravityAcc.std...Z	| Mean of the variable by subject and activitytGravityAccMag.mean..	| Mean of the variable by subject and activitytGravityAccMag.std..	| Mean of the variable by subject and activity

#### Transformations

###### Loading the data sets 

Almost all files are quite easy to load (read.csv), and we name the columns during the operation. For example:

```
activityLabels <- read.csv("UCI HAR Dataset/activity_labels.txt",sep=" ",header=FALSE, col.names = c("ActivityLabelID","ActivityLabelName"))

featureLabels <- read.csv("UCI HAR Dataset/features.txt",sep=" ",header=FALSE, col.names = c("FeatureLabelID","FeatureLabelName"))

...
```

The 2 exceptions are the 2 large files (test, train) holding all measurements on 561 columns. Despite appearances, these files are in fact fixed width files, to be loaded with read.fwf indicating the presence of 561 columns 16 characters wide (```widths=rep(16,561)```):

```
testX <- read.fwf(file="UCI HAR Dataset/test/X_test.txt",widths=rep(16,561), col.names=featureLabels$FeatureLabelName)
```

###### Merging each files into a single one
The 3 separate files for each set are merged into a single one by adding columns to the main set:

```
testX$ActivityLabelID <- testY$ActivityLabelID
testX$SubjectID <- testSubject$SubjectID

trainX$ActivityLabelID <- trainY$ActivityLabelID
trainX$SubjectID <- trainSubject$SubjectID
```

###### Merging the training and the test sets to create one data set
Since we have preserved the format of each set, we can append them safely:

```
allX <- rbind(testX,trainX)
```

###### Extracting only the measurements on the mean and standard deviation for each measurement
We filter the set to keep only the columns containing "mean." or "std." or the IDs we will need later in their name with grep:

```
msX <- allX[,grep(".std|.mean|ActivityLabelID|SubjectID",names(allX))]
```


###### Uses descriptive activity names to name the activities in the data set
We merge our data set with the activity labels we loaded earlier on their IDs:

```
msXa <- merge(msX,activityLabels,by.x="ActivityLabelID",by.y="ActivityLabelID")
```

###### Appropriately labels the data set with descriptive variable names
At this point our data set is already labelled appropriately:

```
> colnames(msXa)

 [1] "ActivityLabelID"                 "tBodyAcc.mean...X"               "tBodyAcc.mean...Y"               "tBodyAcc.mean...Z"              
 [5] "tBodyAcc.std...X"                "tBodyAcc.std...Y"                "tBodyAcc.std...Z"                "tGravityAcc.mean...X"           
 [9] "tGravityAcc.mean...Y"            "tGravityAcc.mean...Z"            "tGravityAcc.std...X"             "tGravityAcc.std...Y"            
[13] "tGravityAcc.std...Z"             "tBodyAccJerk.mean...X"           "tBodyAccJerk.mean...Y"           "tBodyAccJerk.mean...Z"          
[17] "tBodyAccJerk.std...X"            "tBodyAccJerk.std...Y"            "tBodyAccJerk.std...Z"            "tBodyGyro.mean...X"             
[21] "tBodyGyro.mean...Y"              "tBodyGyro.mean...Z"              "tBodyGyro.std...X"               "tBodyGyro.std...Y"              
[25] "tBodyGyro.std...Z"               "tBodyGyroJerk.mean...X"          "tBodyGyroJerk.mean...Y"          "tBodyGyroJerk.mean...Z"         
[29] "tBodyGyroJerk.std...X"           "tBodyGyroJerk.std...Y"           "tBodyGyroJerk.std...Z"           "tBodyAccMag.mean.."             
[33] "tBodyAccMag.std.."               "tGravityAccMag.mean.."           "tGravityAccMag.std.."            "tBodyAccJerkMag.mean.."         
[37] "tBodyAccJerkMag.std.."           "tBodyGyroMag.mean.."             "tBodyGyroMag.std.."              "tBodyGyroJerkMag.mean.."        
[41] "tBodyGyroJerkMag.std.."          "fBodyAcc.mean...X"               "fBodyAcc.mean...Y"               "fBodyAcc.mean...Z"              
[45] "fBodyAcc.std...X"                "fBodyAcc.std...Y"                "fBodyAcc.std...Z"                "fBodyAcc.meanFreq...X"          
[49] "fBodyAcc.meanFreq...Y"           "fBodyAcc.meanFreq...Z"           "fBodyAccJerk.mean...X"           "fBodyAccJerk.mean...Y"          
[53] "fBodyAccJerk.mean...Z"           "fBodyAccJerk.std...X"            "fBodyAccJerk.std...Y"            "fBodyAccJerk.std...Z"           
[57] "fBodyAccJerk.meanFreq...X"       "fBodyAccJerk.meanFreq...Y"       "fBodyAccJerk.meanFreq...Z"       "fBodyGyro.mean...X"             
[61] "fBodyGyro.mean...Y"              "fBodyGyro.mean...Z"              "fBodyGyro.std...X"               "fBodyGyro.std...Y"              
[65] "fBodyGyro.std...Z"               "fBodyGyro.meanFreq...X"          "fBodyGyro.meanFreq...Y"          "fBodyGyro.meanFreq...Z"         
[69] "fBodyAccMag.mean.."              "fBodyAccMag.std.."               "fBodyAccMag.meanFreq.."          "fBodyBodyAccJerkMag.mean.."     
[73] "fBodyBodyAccJerkMag.std.."       "fBodyBodyAccJerkMag.meanFreq.."  "fBodyBodyGyroMag.mean.."         "fBodyBodyGyroMag.std.."         
[77] "fBodyBodyGyroMag.meanFreq.."     "fBodyBodyGyroJerkMag.mean.."     "fBodyBodyGyroJerkMag.std.."      "fBodyBodyGyroJerkMag.meanFreq.."
[81] "SubjectID"                       "ActivityLabelName"  
```

###### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

To do that operation we'll use the ```reshape2``` library. 

The first step is to ```melt``` data into an unpivoted format having one row for each {activity/subject/variable} combinations. 

Then the ```dcast``` command allows to pivot again, calculating the ```mean``` of each of the variable by group of each ```SubjectID + ActivityLabelName```:

```
library(reshape2)
tidyX <- melt(msXa, id=c("SubjectID","ActivityLabelID","ActivityLabelName"),measures.vars=grep(".std.|.mean.",names(msXa)))
finalX <- dcast(tidyX, SubjectID + ActivityLabelName ~ variable,mean)
```

This way we can attain the final expected format:

```
   SubjectID  ActivityLabelName tBodyAcc.mean...X tBodyAcc.mean...Y ...
1          1             LAYING         0.2215982      -0.040513953  ...
1          1            WALKING               ...
...
```

[1]: https://class.coursera.org/getdata-008/
[2]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "Direct link download (ZIP)"
[3]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones "Data collected from the accelerometers from the Samsung Galaxy S"