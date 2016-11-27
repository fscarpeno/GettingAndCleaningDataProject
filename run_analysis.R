#Funcion for Getting and Cleaning Data Course Project 
#Perform the following actions
#1 Load the data
#2 Bind training data to test data
#3 Join the data set, and filter the results of means and deviations
#4 Groups the results by subject and activity and calculates the mean. The results will be ordered pro subject and activity.
#5 Write results in a table
#6 Write codebook of the results table with column names, data types and maximum, minimum, mean, deviation and levels
# Input parameters
	#RootPath is the path where the data from the projector is unzipped
	#Outputpath is the path to leave the calculated data
	#codeBookPath is the path to leave the codeBook
	#sepTable is separator character in result Table

runAnalysis <- function(rootPath, outputPath, codeBookPath, sepTable){

	setwd(rootPath)

	##activity_labels.txt
	activityLabels <- read.csv("activity_labels.txt", sep="",
		header=FALSE)
	names(activityLabels) <- c("IdActivity", "NameActivity")
	#activityLabels 

	##features.txt
	features<- read.csv("features.txt", sep="",
		header=FALSE)
	names(features) <- c("IdFeature", "NameFeature")
	#features

	#X
	xTrain <- read.csv("train/X_train.txt" , sep="", header=FALSE)
	#head(xTrain,2)
	xTest <- read.csv("test/X_test.txt" , sep="", header=FALSE)
	#head(xTest ,2)
	X <- rbind(xTrain, xTest)
	rm(list=c("xTrain", "xTest"))
	names(X) <-  features$NameFeature
	#head(X, 3)

	#Y
	yTrain <- read.csv("train/Y_train.txt" , sep="", header=FALSE)
	#head(yTrain,2)
	yTest <- read.csv("test/Y_test.txt" , sep="", header=FALSE)
	#head(yTest ,2)
	Y <- rbind(yTrain, yTest)
	rm(list=c("yTrain", "yTest"))
	names(Y) <-  "IdActivity"

	#subject
	subjectTrain <- read.csv("train/subject_train.txt" , sep="", header=FALSE)
	#head(subjectTrain ,2)
	subjectTest <- read.csv("test/subject_test.txt" , sep="", header=FALSE)
	#head(subjectTest,2)
	subject<- rbind(subjectTrain, subjectTest )
	rm(list=c("subjectTrain", "subjectTest"))
	names(subject) <-  "Subject"


	#Filter MEAN or STD fields
	dataSet <- cbind(Y,subject,X[,grep("MEAN|STD", names(X), ignore.case=TRUE)])
	#head(dataSet,3)

	library(dplyr)

	dataMeans <- group_by(dataSet, Subject, IdActivity) %>%
		summarise_each(funs(mean)) %>%
			arrange(Subject, IdActivity)

	#JOIN Activity
	dataMeans <- left_join(dataMeans, activityLabels, by="IdActivity")
	#head(dataMeans, 3)

	#WRITE Output
	write.table(dataMeans, sep=sepTable, file=outputPath, row.names=FALSE)
	View(dataMeans)

	##CODEBOOK
	fields <- names(dataMeans)
	classes <- sapply(dataMeans, class)
	maxs <- sapply(dataMeans, function(x)
		if(class(x)=="numeric"||class(x)=="integer")
			max(x)
		else
			""
		 )
	mins <- sapply(dataMeans, function(x)
		if(class(x)=="numeric"||class(x)=="integer")
			min(x)
		else
			""
		 )

	means <- sapply(dataMeans, function(x)
		if(class(x)=="numeric"||class(x)=="integer")
			mean(x)
		else
			""
		 )
	sds <- sapply(dataMeans, function(x)
		if(class(x)=="numeric"||class(x)=="integer")
			sd(x)
		else
			""
		 )
	levels <- sapply(dataMeans, function(x)
		if(class(x)=="factor")
			paste(levels(x), collapse = ", ")
		else
			""
		 )
	codeBook <- data.frame(fields, classes, mins, maxs , means, sds, levels )
	write.table(codeBook , sep=sepTable, file=codeBookPath, row.names=FALSE)

}
