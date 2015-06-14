# Getting-and-Cleaning-Data-Course-Project
Contains the r-script, readme and cookbook files 

Two groups of data were procesed,  train data and test data, each group has the following files:

- X_t...txt:  the measurements of the features recorded for each activity and each subject


1. -Y_t...txt:  the activities: walking, jumping, etc

1. -subjects_t….txt: the subject id who did the activities 

Each of this files were read as tables (read.table):  test/train data,  test/train labels, test/train subjects , with column names “Activity” and “Subjects” for the unidimensional labels and subjects data frames.

The  three tables for each group (test/train)  were column binded (cbind) in order to get testdata1 and traindata1 data frames.
Both testdata1 and traindata1 were then row binded(rbind) in order to get wholedata data frame that is the one data set required in the step 1 of the Course Project: "Merges the training and the test sets to create one data set"

The name of the variables (features.txt) were read into a data frame  (features), indexes were obtained for variables related to average and standard deviation, using these indexes the corresponding columns to the variables of interest were selected in order to achieve step 2:"Extracts only the measurements on the mean and standard deviation for each measurement"

From the activity labels ("activity_labels.txt") a data frame was created which was merged with the data frame obtained so far in order to name the activities, achieving step 3: "Uses descriptive activity names to name the activities in the data set"

Using the indexes that were obtained in step 2 a vector with the variable names was obtained that was used as the column names of the data frame, this accomplish step 4: "Appropriately labels the data set with descriptive variable names"

The solution found to step 5 required that the data set was "melted" which means transform each variable value into a different observation (http://www.r-bloggers.com/using-r-quickly-calculating-summary-statistics-from-a-data-frame/), getting an untidy dataset that was used to get the means requiered using  ddply command. The data set was made tidy again with the command spread, achieving the final step 5: "From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject"  
