  setwd("C:/COursera Getting and Cleansing Data Projects/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/")
getwd()
# Read in the data from files
features     = read.table('./features.txt',header=FALSE); #imports features.txt
head(features)
features
activityType = read.table('./activity_labels.txt',header=FALSE); #imports activity_labels.txt
head(activityType)
subjectTrain = read.table('./train/subject_train.txt',header=FALSE); #imports subject_train.txt
head(subjectTrain)
xTrain       = read.table('./train/x_train.txt',header=FALSE); #imports x_train.txt
head(xTrain)
yTrain       = read.table('./train/y_train.txt',header=FALSE); #imports y_train.txt
head(yTrain)
colnames(activityType)  = c('activityId','activityType');
colnames(subjectTrain)  = "subjectId";
colnames(xTrain)        = features[,2]; 
colnames(yTrain)        = "activityId";

trainingData = cbind(yTrain,subjectTrain,xTrain);

subjectTest = read.table('./test/subject_test.txt',header=FALSE); #imports subject_test.txt
xTest       = read.table('./test/x_test.txt',header=FALSE); #imports x_test.txt
yTest       = read.table('./test/y_test.txt',header=FALSE); #imports y_test.txt

colnames(subjectTest) = "subjectId";
colnames(xTest)       = features[,2]; 
colnames(yTest)       = "activityId";
testData = cbind(yTest,subjectTest,xTest);
head(testData)

finalData = rbind(trainingData,testData);
colNames  = colnames(finalData); 

logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));
logicalVector==TRUE
finalData = finalData[logicalVector==TRUE];
finalData = merge(finalData,activityType,by='activityId',all.x=TRUE);
finalData
