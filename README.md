# Getting-and-Cleaning-Data-Course-Project
Source dataset https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

*  One R script called run_analysis.R created for:
*  Merges the training and the test sets to create one data set.
*  Extracts only the measurements on the mean and standard deviation for each measurement.
*  Uses descriptive activity names to name the activities in the data set
*  Appropriately labels the data set with descriptive activity names.
*  Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Notes

*  Only variables containing mean() & std() are used.
*  Requires the plyr & reshape2 packages.
*  See Codebook.md for details on result and the variables
*  See Run_analysis.R for all coding logic

## Tested on

platform       x86_64-w64-mingw32          
arch           x86_64                      
os             mingw32                     
system         x86_64, mingw32             
status                                     
major          3                           
minor          3.1                         
year           2016                        
month          06                          
day            21                          
svn rev        70800                       
language       R                           
version.string R version 3.3.1 (2016-06-21)
nickname       Bug in Your Hair 
