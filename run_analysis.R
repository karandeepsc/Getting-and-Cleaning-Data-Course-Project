# Step 1. Merge training and the test data sets to create one data set.
# Step 2. Extract only the measurements on the mean and standard deviation for each measurement 
# Step 3. Uses descriptive activity names to name the activities in the data set.
# Step 4. Appropriately label the data set with descriptive variable names. 
# Step 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Step 0 - Download data set
DownloadDataSet("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")

# Step 1 
LoadMergeData = function() {
  path<<-paste(getwd(),"/data/UCI HAR Dataset/", sep = "")
  train.dat = read.csv(paste(path,"train/X_train.txt",sep=""), sep="", header=FALSE)
  train.dat[,ncol(train.dat)+1] = read.csv(paste(path,"train/Y_train.txt",sep=""), sep="", header=FALSE)
  train.dat[,ncol(train.dat)+1] = read.csv(paste(path,"train/subject_train.txt",sep=""), sep="", header=FALSE)
  test.dat = read.csv(paste(path,"test/X_test.txt",sep=""), sep="", header=FALSE)
  test.dat[,ncol(test.dat)+1] = read.csv(paste(path,"test/Y_test.txt",sep=""), sep="", header=FALSE)
  test.dat[,ncol(test.dat)+1] = read.csv(paste(path,"test/subject_test.txt",sep=""), sep="", header=FALSE)
  rbind(train.dat, test.dat)
}

# Step 2
ExtractData=function(measurements){
  features <- read.csv(paste(path,"features.txt", sep=""), sep="", header=FALSE)
  cols.in.scope <<- grep(".*-mean.*|.*-std.*", features[,2])
  var.count = ncol(measurements)
  cols.in.scope <<- c(cols.in.scope, var.count-1, var.count)
  measurements<-measurements[,cols.in.scope]
  measurements
}

# Step 3
SetActivityNames = function(measurements){
  activity.Labels = read.csv(paste(path,"activity_labels.txt", sep=""), sep="", header=FALSE)
  activity.ID = 1
  for (ActivityLabel in activity.Labels$V2) {
    measurements$activity <- gsub(activity.ID, ActivityLabel, measurements$activity)
    activity.ID <- activity.ID + 1
  }  
  measurements
}

# Step 4
DescriptiveVariables = function(measurements){
features[,2] <- gsub('-meanFreq()', '.mean.freq', features[,2]) # substitutes "-meanFreq()" with ".mean.freq"
  features[,2] <- gsub('-mean()', '.mean', features[,2]) # substitutes "-mean" with ".mean"
  features[,2] <- gsub('-std()', '.std', features[,2]) # substitutes "-std" with ".std"
  features[,2] <- gsub('[-]', '.', features[,2]) # substitutes "-" with "."
  features[,2] <- gsub('[()]', '', features[,2]) # removes "()"  
  colnames(measurements) <- c(features$V2, "Activity", "Subject")
  colnames(measurements) <- tolower(colnames(measurements))  
  measurements
}

# Step 5 
MakeTidy = function(measurements){
  measurements$activity <- as.factor(measurements$activity)
  measurements$subject <- as.factor(measurements$subject)
  countnndc = ncol(measurements)-2 # the count of colums with non nominal data
  nndc = c(1:countnndc) # the colums with non nominal data
  tidy <- aggregate(measurements[,nndc], by=list(activity = measurements$activity, subject=measurements$subject), mean, na.rm=TRUE)
  tidy
}
