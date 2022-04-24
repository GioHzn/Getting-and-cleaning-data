# setwd("G:/Coursera/Foundations_using_R_Specialization/Getting and cleaning data/Assignment_Final")
# Downloading the files
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "Dataset.zip", method = "curl")
unzip("Dataset.zip")


# 1. Merges the training and the test sets to create one data set.
 ## Read files and bind them together
Data <- rbind(read.table("UCI HAR Dataset/train/X_train.txt"), read.table("UCI HAR Dataset/test/X_test.txt"))
Label <- rbind(read.table("UCI HAR Dataset/train/y_train.txt"), read.table("UCI HAR Dataset/test/y_test.txt"))
Subject <- rbind(read.table("UCI HAR Dataset/train/subject_train.txt"), read.table("UCI HAR Dataset/test/subject_test.txt"))



# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# Contains the names of the column
features <- read.table("UCI HAR Dataset/features.txt") # dim = 561 x 2
# Select column with Mean or stdv
MeanStdv <- grep("mean\\(\\)|std\\(\\)", features[, 2])
# Subset selected columns within the Data
Data <- Data[, MeanStdv]
# Correct Colnames and remove character such as "()" and "-", and capitalized letters
names(Data) <- gsub("\\(\\)", "", features[MeanStdv, 2])
names(Data) <- gsub("-", "", names(Data))
names(Data) <- tolower(names(Data))


# 3. Uses descriptive activity names to name the activities in the data set
activity <- read.table("UCI HAR Dataset/activity_labels.txt") # dim 6 x 2
# Making the observations more readable by removing "_" and subsetting all capitals with lower
activity[, 2] <- gsub("_", "")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
# combining the activity labels with the Label object
A_Label <- activity[Label[, 1], 2]
Label[, 1] <- A_Label
#Rename column to "Activity"
names(Label) <- "Activity"


# 4. Appropriately labels the data set with descriptive variable names. 
names(Subject) <- "Subject"
# Note the order or binding
CleanData <- cbind(Subject, Label, Data)
write.table(CleanData, "Clean_Data.txt")


# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
library(dplyr)
DataAverage <- CleanData %>% group_by(Subject, Activity) %>% summarise_all(mean)
write.table(DataAverage, "Data_Average.txt")
