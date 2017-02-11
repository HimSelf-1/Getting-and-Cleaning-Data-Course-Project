# Getting-and-Cleaning-Data-Course-Project
Getting and Cleaning Data Course Project
Peer-graded Assignment: Getting and Cleaning Data Course Project
Analysis files:
==================================================================
Experiments have been carried out with a group of 30 volunteers. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone on their waist. Using its embedded accelerometer and gyroscope, the study captured 3-axial linear acceleration and 3-axial angular velocity. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed to obtain 128 readings/window.. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See the study “Human Activity Recognition Using Smartphones Dataset“ 'features_info.txt' for more details.  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
For each record the study provided:
=====================================
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.
The dataset analized includes the following files:
=========================================
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
The following files are available for the train and test data. Their descriptions are equivalent. 
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

### Getting and Cleaning Data Course Project 
#### The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.
#### The goal is to prepare tidy data that can be used for later analysis
## Explanation of how the script works:   One R script run_analysis.R was created that does the following.

##Step 1.       Merge the training and the test sets to create one data set.
 1.  Create data directory if it does not exist
 2.  Download data:
     ("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
 3.  Read in the data into tables - NOTE:  the suffix _train & _test refer to the group the subjects were placed in
         
* Subject files using *subject_train.txt* & *subject_test.txt* which contains the subject identification

     * *subject_train*
     * *subject_test*
* Activity files using *Y_train.txt* & *Y_test.txt* which contains the activity the subject performed

     * *activity_train*
     * *activity_test*
* Feature files using *X_train.txt* & *X_test.txt* which contains the data from the activities the subjects performed

     * *feature_train*
     * *feature_test*
 4. Merge the training and the test sets to create one data set

* Merge like data into a single file
* *subject_df* using files *subject_train* & *subject_test*
* *activity_df* using files *activity_train* & *activity_test*
* *features_df* using files *feature_train* & *feature_test*

 5. Assign names to variables from provided data set
 
 * *subject_df*  assign **subject**
 * *activity_df* assign **activity**
 6. Read descriptive feature names from *features.txt* into *featureNames*
 
 * Rename variables in *features_df* using the feature names from column 2 of *featureNames*
 7. Merge columns to get a data frame for all data
 
 * 1. *data_s_a* using files *subject_df* & *activity_df*
 * 2. *total_data* using files *features_df* & *data_s_a*
 
##Step 2.	Extract only the measurements on the mean and standard deviation for each measurement.
 1. *filter_on_names_of_int* from file *featureNames* with contain strings with mean() or std() in name of features
 2. Subset into *names_of_int* based on **subject** & **activity** from *filter_on_names_of_int*
    
    *data_of_int* is a subset of *total_data* based on *names_of_int*
 
##Step 3.	Use descriptive activity names to name the activities in the data set

 1. Read descriptive activity names from *activity_labels.txt* into *activityNames*
 2. Factor variable **activity** in *data_of_int*
 3. Overwrite **activity** in *data_of_int* with descriptive activity names

##Step 4.	Label the data set with descriptive variable names.

Already completed in the R Script:
                
* Re-labeled 'activity' in 'data_of_int' with descriptive activity name
* Read descriptive feature names from "features.txt"
* Assigned names to variables from provided data set :"subject" & "activity"

Based on the *features_info.txt* file, the following replacements were made:

* Time domain signals are prefixed with a 't'; strings beginning with a 't' replaced with 'time'
* Frequency domain signals are prefixed with an 'f'; strings beginning with an 'f' replaced with 'frequency'
* Strings containing 'Acc' were replaced with 'Accelerometer'
* Strings containing 'Gyro' were replaced with 'Gyroscope'
* Strings containing 'Mag' were replaced with 'Magnitude'
* Strings containing 'BodyBody' were replaced with 'Body_Force_Calculated'
* Strings containing 'mean()' were replaced with 'Mean_value'
* Strings containing 'std()' were replaced with 'Standard_deviation'

##Step 5.	From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

* Load library 'plyr'
* 1. Aggregate data *frame data_of_int* by each **activity** and **subject** into *df*, returning means for numeric variables
* 2. Order/sort the results in *df* by subject and then activity
* 3. Save  the tidy data *df* into *tidydataset.txt*


## data table *data_of_int* with all variables along with units

* contains 10,299 obs. of 68 variables
* subject and activity variables are interger values
* subject is an unique id for each member of the group of 30 volunteers
* Each subject performed six activities : WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
* Variables prefixed with time have units of seconds, and those with frequency are in Hertz (Hz)
* all variables prefixed with time or frequency are numeric measurement values from the experiment:

## data table *df* with all variables and summaries calculated mean along with units

* contains 180 obs. of 68 variables
* subject and activity variables are interger values
* subject is an unique id for each member of the group of 30 volunteers
* Each subject performed six activities : WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
* Variables prefixed with time have units of seconds, and those with frequency are in Hertz (Hz)
* all variables prefixed with time or frequency are the numeric mean of the experiment measurements.