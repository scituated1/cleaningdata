#Prepare Environment

  library(plyr)
  library(dplyr)
  library(tidyr)

#Download files

  if (!file.exists("UCI HAR Dataset")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
    destFile <- "FUCI_Data.zip"
    download.file(fileUrl,destfile = destFile)
    unzip(destFile)
    Date_Downloaded <- date()
  }

#Load Files
  # Load Test Files
  x_test <- read.table("./UCI HAR Dataset/test/x_test.txt", header =  FALSE,)
  activity_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header =  FALSE, col.names= "activity")
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header =  FALSE, col.names = "subject")
  
  # Load Train Files
  x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header =  FALSE)
  activity_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header =  FALSE, col.names= "activity")
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header =  FALSE, col.names = "subject")
  
  # Load Labels
  activities <- read.table("./UCI HAR Dataset/activity_labels.txt", header =  FALSE)
  activity_numbers <- activities[,1]
  activity_labels  <- as.vector(activities[,2])
 
  features <- read.table("./UCI HAR Dataset/features.txt", header =  FALSE)
  
  #label X Columns 
  X_colnames <- t(select(features,V2))
  X_colnames <- make.names(X_colnames, unique = TRUE)
  
  colnames(x_test) <- X_colnames
  colnames(x_train) <- X_colnames
    
  
  #Merge Subject & Activity
  
  Full_test <- cbind(subject_test, activity_test, x_test)
  Full_train <- cbind(subject_train, activity_train, x_train)
  
  All_data  <- rbind(Full_test, Full_train)
  
  #Clean up - remove raw files
  rm(x_test, x_train, subject_test, subject_train, activity_test, activity_train, Full_test, Full_train)
  
  # subset columns - select mean and std. deviation values for subject and activity
  
  Mean_Std_data <- All_data %>%
      select(subject,activity,matches("mean|std")) %>%
      mutate(activity = mapvalues(activity,activity_numbers, activity_labels)) 
  
  # summarize tidy_data by activity and subject
  
  tidy_data <- Mean_Std_data %>%
      group_by(activity,subject) %>%
      summarise_each(funs(mean))
  
  # output summary to new dataset
  
 write.table(tidy_data, file="./project_output.txt", row.names = FALSE, col.names = TRUE)
  