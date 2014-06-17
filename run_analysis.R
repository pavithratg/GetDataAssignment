## run_analysis.R does following

## 1. Getting data from web
if(!file.exists("UCI HAR Dataset")){
    fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileurl,destfile="UCI-HAR-dataset.zip",method="curl")
    unzip("UCI-HAR-dataset.zip")
}

## 2. Merging the training and the test sets to create one data set
features <- read.table("./UCI HAR Dataset/features.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names=features[,2])
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names=features[,2])
X <- rbind(X_test, X_train)

## 3. Extracting only the measurements on the mean and standard deviation for each measurement
relevantFeatures <- features[grep("(mean|std)\\(", features[,2]),]
meanAndStd <- X[,relevantFeatures[,1]]

## 4. Using descriptive activity names to name the activities in the data set
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c("activity"))
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = c("activity"))
y <- rbind(y_test, y_train)

labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
for (i in 1:nrow(labels)) {
    code <- as.numeric(labels[i, 1])
    name <- as.character(labels[i, 2])
    y[y$activity == code, ] <- name
}

## 5. Appropriately labelling the data set with descriptive variable names
XWithLabels <- cbind(y, X)
meanAndStdWithLabels <- cbind(y, meanAndStd)

## 6. Creating a second, independent tidy data set with 
## the average of each variable for each activity and each subject
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))
subject <- rbind(subject_test, subject_train)
averages <- aggregate(X, by = list(activity = y[,1], subject = subject[,1]), mean)

write.csv(averages, file="result.txt", row.names=FALSE)