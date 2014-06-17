Description - Course Project - Getting And Cleaning Data
========================================================

R script `run_analysis.R` does the following: 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for 
   each activity and each subject.
   
Description - How the script works

1. Downloads and uncompresses the dataset to the working directory, if not already exists.

2. Creates 3 data frames features, X_test and X_train from UCI HAR Dataset/features.txt, UCI HAR Dataset/test/X_test.txt and UCI HAR Dataset/train/X_train.txt, data files respectively.

3. `rbind` two data frames, X_test and X_train, to Merge the training and the test sets to create one data set

4. Gets only the std and mean features from features data frame by subsetting it and stores the resulting data frame in meanAndStd variable, to extract only the measurements on the mean and standard deviation for each measurement.

5. Creates 2 data frames y_test and y_train using UCI HAR Dataset/test/y_test.txt and UCI HAR Dataset/train/y_train.txt data files respectively, assign activity as the column name for each of them, merges y_test and y_train data frames and creates a new data frame called y. Creates labels data frame using UCI HAR Dataset/activity_labels.txt data file. Loads the activity labels, and replace indices with names, hence uses descriptive activity names to name the activities in the data set.

6. Combines y with both XWithLabels and meanAndStd using `cbind` to ppropriately labelling the data set with descriptive activity names.

7. Using X, calculates an aggregate using mean for averaging, averages over activity and subject, save the result to a text file, hence Creates a second, independent tidy data set with the average of each variable for each activity and each subject.