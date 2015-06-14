library(tidyr)
library(plyr)
library(reshape2)
library(dplyr)

# 1. Merges the training and the test sets to create one data set.

traindata <- read.table( "./data/X_train.txt")    # dataframe with measurement values for training
trainlabels <- read.table( "./data/Y_train.txt")  # dataframe for training activities 
colnames(trainlabels) <- "Activity"              # name activities column for reference
trainsubjects <- read.table( "./data/subject_train.txt") # dataframe for training subjects 
colnames(trainsubjects) <- "Subject"        # name subjects  column for reference
traindata1 <-cbind(trainsubjects,trainlabels, traindata) #dataframe for training data

testdata <- read.table( "./data/X_test.txt")    # dataframe with measurement values for testing       
testlabels <- read.table( "./data/Y_test.txt")   # dataframe for testing activities  
colnames(testlabels) <- "Activity"      # name activities column for reference
testsubjects <- read.table( "./data/subject_test.txt") # dataframe for testing subjects
colnames(testsubjects) <- "Subject"     # name subjects  column for reference       
testdata1 <-cbind(testsubjects,testlabels, testdata) #dataframe for training data

wholedata <- rbind(traindata1,testdata1)  #dataframe with testing and trainin data

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table( "./data/features.txt")   # data frame with variable names
iprev <- grep("mean()",features[,2])            # Get index of variables related to mean
i <- iprev+2                     # adjust index to consider first two columns
jprev <- grep("std()",features[,2])         # Get index of features related to std. dev.
j <- jprev+2                  # adjust index to consider first two columns
ij <- c(1,2,c(i,j))            # vector of index witn 1 and 2 added to consider first 2 columns
wholedatameansd <- wholedata[,ij]  # data frame with  first two columns and columns related to mean and std. dev.

# 3. Uses descriptive activity names to name the activities in the data set

activity <- read.table( "./data/activity_labels.txt", header = TRUE) # data frame with activity names
dataactnames<- merge(activity, wholedatameansd)  # merge names into main data frame 
dataactnames$Activity <- NULL         # eliminate redundant first column 

# 4. Appropriately labels the data set with descriptive variable names. 

ijprev<-c(iprev,jprev)            # vector of  index of variables related to mean and std. dev.
varnam <- c(as.character(features[,2][ijprev])) # vector with name of variables used
varnames<- c("Activity", "Subject", varnam)     # The names of first 2 colummns added
colnames(dataactnames)<-varnames       # assigning column names

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# The solution found requires that from the data set obtained so far generate an "untidy" data set for proceesing

melted <- melt(dataactnames, id.vars=c("Activity", "Subject"))  # in order to get average treat variables as observations
            # ref: http://www.r-bloggers.com/using-r-quickly-calculating-summary-statistics-from-a-data-frame/
resave <- ddply(melted, c("Activity", "Subject", "variable"), summarise,
                mean = mean(value))        # Calculate average for each case
tableavg <- tbl_df(resave)             
titableavg <- spread(tableavg, variable, mean)  #Tidying back data frame putting variables back in columns
tidytableavg <- tbl_df(titableavg)

# write.table(tidytableavg, file = "tidytableavg.txt", row.name=FALSE) # write txt file for submitting to Coursera
# For looking at final data frame in R use: dataavg <- read.table("tidytableavg.txt", header=TRUE) ; View(dataavg)
