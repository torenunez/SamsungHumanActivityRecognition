# Course Project - Samsung Human Activity Recognition
## Getting and Cleaning Data 
### Coursera - John Hopkins Bloomberg School of Public Health 

This repo was created as part of a project assignment from [this course.](https://www.coursera.org/course/getdata)

Most of the files contained herein are from the unzipped file downloaded from [here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Three additional files are contained within the same repository:  
1. This "README.md"" file.   
..* The unzipped file contained its own "README.txt"" file which explains the contents of the raw data.  
2. The R script: "HumanActivityRecognition.R".   
3. The output of the R script: "subject_activity_summary.txt".  

The R script performs the following operations:  
1. Loads required packages and datasets from the working directory.  
2. Loads and consolidates training data sets.  
3. Loads and consolidates testing data sets.  
4. Performs an union of traning and testin data sets, which have the same structure.  
5. Creates an independent tidy data set with the average of each variable for each activity and each subject for mean and standard deviation measurements.  
6. Writes the tidy data set to "subject_activity_summary.txt".  

