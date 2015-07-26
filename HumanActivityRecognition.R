#---------------------------------------------------------------------------------------------------
# Coursera - John Hopkins Bloomberg School of Public Health 
# Getting and Cleaning Data
#---------------------------------------------------------------------------------------------------
# Description:      Course Project - Samsung Human Activity Recognition
# Student:          Salvador J Nunez
# Created:          2015-07-24
#---------------------------------------------------------------------------------------------------

##---------------------------------------------------------------------------
## Setup
##---------------------------------------------------------------------------
##load packages
library(data.table)

##confirm that the working directory is correct
getwd()

##load labels
feature_labels = read.table("./features.txt")
activity_labels = read.table("./activity_labels.txt")

##rename columns
colnames(feature_labels) = c("feature_id", "feature_label")
colnames(activity_labels) = c("activity_id", "activity_label")


##---------------------------------------------------------------------------
## Training
##---------------------------------------------------------------------------
train_dir = "./train" ##set dir 
train_files = c(dir(train_dir)) ##load file paths
train_text = train_files[grep(".txt",train_files)] ##filter text files only
train_labels = gsub(".txt","",train_text) ## set dataset names

##load data tables 
for (i in 1:length(train_text)){
  assign(train_labels[i], read.table(paste0(train_dir,"/",train_text[i])))
} 

##rename columns
colnames(subject_train) = c("subject")
colnames(y_train) = c("activity_id")
colnames(X_train) = feature_labels$feature_label

##merge data sets
y_train = merge(y_train, activity_labels, by = "activity_id")
train_data_set = cbind(subject_train, y_train, X_train)
train_data_set$type = "train"


##---------------------------------------------------------------------------
## Testing
##---------------------------------------------------------------------------
test_dir = "./test" ##set dir 
test_files = c(dir(test_dir)) ##load file paths
test_text = test_files[grep(".txt",test_files)] ##filter text files only
test_labels = gsub(".txt","",test_text) ## set dataset names

##load data tables 
for (i in 1:length(test_text)){
  assign(test_labels[i], read.table(paste0(test_dir,"/",test_text[i])))
} 

##rename columns
colnames(subject_test) = c("subject")
colnames(y_test) = c("activity_id")
colnames(X_test) = feature_labels$feature_label

##merge data sets
y_test = merge(y_test, activity_labels, by = "activity_id")
test_data_set = cbind(subject_test, y_test, X_test)
test_data_set$type = "test"


##---------------------------------------------------------------------------
## Create Master through Union
##---------------------------------------------------------------------------
##union of data sets through rbind
master_data_set = rbind(train_data_set, test_data_set)

# #calculate mean and standard deviations across all numeric columns
# master_variable_summary = data.frame(apply(master_data_set[,4:564],2,mean), apply(master_data_set[,4:564],2,sd))
# colnames(master_variable_summary) = c("mean","sd")

#select mean and std feature measurements only
mean_std_vector = c(grep("mean()",feature_labels$feature_label, fixed = TRUE), grep("std()",feature_labels$feature_label))
mean_std_vector = mean_std_vector + 3 ##shift for unrelated columns
mean_std_vector = c(mean_std_vector, 1, 2, 3, 565)
mean_std_vector = sort(mean_std_vector)
mean_std_data_set = master_data_set[,mean_std_vector]
mean_std_data_set$type = NULL
mean_std_data_set$activity_id = NULL


#calculate mean by subject and activity through data.table package
mean_std_data_set = data.table(mean_std_data_set)
keycols = c("subject", "activity_label")
setkeyv(mean_std_data_set, keycols)
subject_activity_summary = mean_std_data_set[, lapply(.SD,mean), by = key(mean_std_data_set)]


##---------------------------------------------------------------------------
## Write Tidy Output
##---------------------------------------------------------------------------
write.table(subject_activity_summary, file = "subject_activity_summary.txt", row.names = FALSE, sep="\t")


