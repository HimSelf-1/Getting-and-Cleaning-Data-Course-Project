## run_analysis.R
## rm(list=ls())  # clean the workspace  
setwd("C:/Users/Dave/Getting_and_Cleaning_Data_Course_Project/Getting-and-Cleaning-Data-Course-Project")
if(!file.exists("./accelerometer")) {dir.create("./accelerometer")}  ## create data directory if it does not exist
dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataset_url, destfile = "./accelerometer/accelerometer.zip")  ## save in working directory
unzip(zipfile = "./accelerometer/accelerometer.zip", exdir = "./accelerometer")  ## unzip the file into your R directory
path_read_files <- file.path("./accelerometer","UCI HAR Dataset")
files <- list.files(path_read_files, recursive = TRUE)  ## get a list of the files in 'UCI HAR Dataset' folder
files    
## read in the data into tables : subject files
subject_train <- read.table(file.path(path_read_files,"train","subject_train.txt"), header = FALSE) 
subject_test <- read.table(file.path(path_read_files,"test","subject_test.txt"), header = FALSE)  
## read in the data into tables : Activity files
activity_train <- read.table(file.path(path_read_files,"train","Y_train.txt"), header = FALSE)
activity_test <- read.table(file.path(path_read_files,"test","Y_test.txt"), header = FALSE)
## read in the data into tables : Feature
feature_train <- read.table(file.path(path_read_files,"train","X_train.txt"), header = FALSE)
feature_test <- read.table(file.path(path_read_files,"test","X_test.txt"), header = FALSE)
table(subject_test);table(subject_train)
## subject_test  ## contains an identifier of the subject who carried out the experiment and the number of experiments involved in
##   2   4   9  10  12  13  18  20  24 
## 302 317 288 294 320 327 364 354 381 
## subject_train  ## contains an identifier of the subject who carried out the experiment and the number of experiments involved in
##   1   3   5   6   7   8  11  14  15  16  17  19  21  22  23  25  26  27  28  29  30 
## 347 341 302 325 308 281 316 323 328 366 368 360 408 321 372 409 392 376 382 344 383 
table(activity_test);table(activity_train)
## activity_test
##   1   2   3   4   5   6 
## 496 471 420 491 532 537 
## activity_train
##    1    2    3    4    5    6 
## 1226 1073  986 1286 1374 1407 
str(feature_test)
str(feature_train)
## 1.	Merge the training and the test sets to create one data set
        ## merge like data into a single file
subject_df <- rbind(subject_train,subject_test)
activity_df <- rbind(activity_train,activity_test)
features_df <- rbind(feature_train,feature_test)
        ## assign names to variables from provided data set
names(subject_df) <- c("subject")
names(activity_df) <- c("activity")
featureNames <- read.table(file.path(path_read_files,"features.txt"),head = FALSE) ## read descriptive feature names from "features.txt"
names(features_df) <- featureNames$V2  ## use column 2 names to rename variables
features_df
        ## merge columns to get data frame for all data
data_s_a <- cbind(subject_df,activity_df)  ## step one, merge two into one
total_data <- cbind(features_df,data_s_a)  ## step two, merge the last file with other data


##  2.	Extract only the measurements on the mean and standard deviation for each measurement
filter_on_names_of_int <- featureNames$V2[grep("mean\\(\\)|std\\(\\)",featureNames$V2)]  ## locate strings with mean() or std()contained in name of features
## attributes(filter_on_names_of_int)
names_of_int <- c(as.character(filter_on_names_of_int), "subject", "activity")  ## subset based on names of interest
data_of_int <- subset(total_data, select = names_of_int)
str(data_of_int)
head(data_of_int$activity,30)
## 3.	Uses descriptive activity names to name the activities in the data set
activityNames <- read.table(file.path(path_read_files,"activity_labels.txt"),head = FALSE) ## read descriptive activity names from "activity_labels.txt"
names(activityNames)
## [1] "V1" "V2"
data_of_int$activity <- factor(data_of_int$activity)  ## factor variable 'activity' in 'data_of_int'
data_of_int$activity <- factor(data_of_int$activity,labels=as.character(activityNames$V2))  ## overwrite 'activity' in 'data_of_int' with descriptive activity names
head(data_of_int$activity,28)  ## check ouput  -- record 28 should be SITTING - output is validated

## 4.	Appropriately labels the data set with descriptive variable names
        ## already in this R Script:
                ## re-labeled 'activity' in 'data_of_int' with descriptive activity name
                ## and read descriptive feature names from "features.txt"
                ## and assigned names to variables from provided data set :"subject" & "activity"
names(data_of_int)  ## check column names to see what current state is with goal of what can be done to make variable names more descriptive
##  [1] "tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"           "tBodyAcc-mean()-Z"           "tBodyAcc-std()-X"           
##  [5] "tBodyAcc-std()-Y"            "tBodyAcc-std()-Z"            "tGravityAcc-mean()-X"        "tGravityAcc-mean()-Y"       
##  [9] "tGravityAcc-mean()-Z"        "tGravityAcc-std()-X"         "tGravityAcc-std()-Y"         "tGravityAcc-std()-Z"        
## [13] "tBodyAccJerk-mean()-X"       "tBodyAccJerk-mean()-Y"       "tBodyAccJerk-mean()-Z"       "tBodyAccJerk-std()-X"       
## [17] "tBodyAccJerk-std()-Y"        "tBodyAccJerk-std()-Z"        "tBodyGyro-mean()-X"          "tBodyGyro-mean()-Y"         
## [21] "tBodyGyro-mean()-Z"          "tBodyGyro-std()-X"           "tBodyGyro-std()-Y"           "tBodyGyro-std()-Z"          
## [25] "tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"      "tBodyGyroJerk-mean()-Z"      "tBodyGyroJerk-std()-X"      
## [29] "tBodyGyroJerk-std()-Y"       "tBodyGyroJerk-std()-Z"       "tBodyAccMag-mean()"          "tBodyAccMag-std()"          
## [33] "tGravityAccMag-mean()"       "tGravityAccMag-std()"        "tBodyAccJerkMag-mean()"      "tBodyAccJerkMag-std()"      
## [37] "tBodyGyroMag-mean()"         "tBodyGyroMag-std()"          "tBodyGyroJerkMag-mean()"     "tBodyGyroJerkMag-std()"     
## [41] "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"           "fBodyAcc-mean()-Z"           "fBodyAcc-std()-X"           
## [45] "fBodyAcc-std()-Y"            "fBodyAcc-std()-Z"            "fBodyAccJerk-mean()-X"       "fBodyAccJerk-mean()-Y"      
## [49] "fBodyAccJerk-mean()-Z"       "fBodyAccJerk-std()-X"        "fBodyAccJerk-std()-Y"        "fBodyAccJerk-std()-Z"       
## [53] "fBodyGyro-mean()-X"          "fBodyGyro-mean()-Y"          "fBodyGyro-mean()-Z"          "fBodyGyro-std()-X"          
## [57] "fBodyGyro-std()-Y"           "fBodyGyro-std()-Z"           "fBodyAccMag-mean()"          "fBodyAccMag-std()"          
## [61] "fBodyBodyAccJerkMag-mean()"  "fBodyBodyAccJerkMag-std()"   "fBodyBodyGyroMag-mean()"     "fBodyBodyGyroMag-std()"     
## [65] "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()"  "subject"                     "activity" 

## from 'features_info.txt' file:
        ## time domain signals (prefix 't' to denote time - prefix
names(data_of_int)<-gsub("^t", "time", names(data_of_int))  ## metacharacter ^ represents start of line
        ## Note the 'f' to indicate frequency domain signals
names(data_of_int)<-gsub("^f", "frequency", names(data_of_int))  ## metacharacter ^ represents start of line
        ## Acc is short for accelerometer
names(data_of_int)<-gsub("Acc", "Accelerometer", names(data_of_int))
        ## Gyro is short for gyroscope
names(data_of_int)<-gsub("Gyro", "Gyroscope", names(data_of_int))
        ## Mag is short for magnitude
names(data_of_int)<-gsub("Mag", "Magnitude", names(data_of_int))
        ## BodyBody can be made to body_force_calculated to be more descriptive
names(data_of_int)<-gsub("BodyBody", "Body_Force_Calculated", names(data_of_int))
        ## mean(): Mean value
names(data_of_int)<-gsub("mean\\(\\)", "Mean_value", names(data_of_int))  ## \\ used to escape special characters
        ## std(): Standard deviation
names(data_of_int)<-gsub("std\\(\\)", "Standard_deviation", names(data_of_int)) ## \\ used to escape special characters
## names(data_of_int)



## 5.	From the data set in step 4, creates a 
##      second, independent tidy data set with the average of each variable for each activity and each subject.

## install.packages("plyr")  ## install package 'plyr'
library(plyr)   ## load package 'plyr'
# aggregate data frame data_of_int by each activity and subject, returning means for numeric variables
df <-aggregate(. ~subject + activity, data_of_int, mean)
df<-df[order(df$subject,df$activity),]   ## order/sort the results by subject and then activity
write.table(df, file = "tidydataset.txt",row.name=FALSE)

