### Getting and cleaning data final assignment ###

## Download data set

gdcfile <- "gdc_data.zip"

if (!file.exists(gdcfile)) {
      data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(data_url, gdcfile)
}
if (!file.exists("UCI HAR Dataset/")) {
      unzip(gdcfile)
}



## Merge training & test sets to create 1 dataset

# read flat files into data sets
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# merge datasets
MyX_Data <- rbind(x_train, x_test)
MyY_Data <- rbind(y_train, y_test)
MySubjects <- rbind(sub_train, sub_test)

## Load labels and features
Features <- read.delim("UCI HAR Dataset/features.txt", sep = " ", header = FALSE)
vecFeatures <- as.character(Features[,2])
Labels <- read.delim("UCI HAR Dataset/activity_labels.txt", sep = " ", header = FALSE)
vecLabels <- as.character(Labels[,2]) 

## Lablels to datasets
colnames(MyX_Data) <- vecFeatures

## Extract variables for mean and std

data_sel <- grep("-(mean|std).*", as.character(vecFeatures))

seleccion <- MyX_Data[ ,data_sel]

## Appropriately labels the data set with descriptive variable names. 

colnames(MySubjects) <- "Subject"

colnames(MyY_Data) <- "Activity"

seleccion_ls <- cbind(MySubjects, MyY_Data, seleccion)

seleccion_ls$Subject <- as.factor(seleccion_ls$Subject)

seleccion_ls$Activity <- factor(seleccion_ls$Activity, levels = Labels[,1], labels = Labels[,2])

## Create independent tidy data set

library(reshape2)

selecc_melted <- melt(seleccion_ls, id = c("Subject", "Activity"))

selecc_tidy <- dcast(selecc_melted, Subject + Activity ~ variable, mean)

write.table(selecc_tidy, "act_mean_by_subj.txt", row.names = FALSE, quote = FALSE)
