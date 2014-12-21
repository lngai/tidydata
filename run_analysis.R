# Read the source Files

X_Train_data<-read.table("train/X_train.txt",header=FALSE,sep="")
X_Test_data<-read.table("test/X_test.txt",header=FALSE,sep="")
y_Train_data<-read.table("train/y_train.txt",header=FALSE,sep="")
y_Test_data<-read.table("test/y_test.txt",header=FALSE,sep="")
sub_train<-read.table("train/subject_train.txt",header=FALSE,sep="")
sub_test<-read.table("test/subject_test.txt",header=FALSE,sep="")
activity_labels<-read.table("activity_labels.txt",header=FALSE,sep="")


#Read the Column Name of each Measurement
feature<-read.table("features.txt",header=FALSE,sep="")
featureslist<-feature$V2
featureslist<-make.unique(as.character(featureslist))

#Name the Column Names of both Testing and Training Data
colnames(X_Train_data)<-featureslist
colnames(X_Test_data)<-featureslist
colnames(y_Train_data)<-"activity"
colnames(y_Test_data)<-"activity"
colnames(sub_train)<-"subject"
colnames(sub_test)<-"subject"


#Merge the data rows
X_Comb_data<-rbind(X_Train_data,X_Test_data)
y_Comb_data<-rbind(y_Train_data,y_Test_data)
sub_Comb_data<-rbind(sub_train,sub_test)

#Merge the data colums
full_com_data<-cbind(sub_Comb_data,y_Comb_data,X_Comb_data)

#Extract the Measurement with Means and Standard Deviation
full_extract<-select(full_com_data,subject,activity,matches(".(mean()|std())"))

# Replace the Activity Code with the Activity Description
mgsub <- function(pattern, replacement, x, ...) {
  if (length(pattern)!=length(replacement)) {
    stop("pattern and replacement do not have the same length.")
  }
  result <- x
  for (i in 1:length(pattern)) {
    result <- gsub(pattern[i], replacement[i], result, ...)
  }
  result
}

full_extract$activity<-mgsub(activity_lables$V1,activity_labels$V2,full_extract)

#Create the Tidy Data Set using the function Group By and Summarise_each to get the mean
groupby_data<-group_by(full_extract,subject,activity)

#calculate the means of each meansurement.
tidy_data<-summarise_each(groupby_data,funs(mean))

#Save the tidy data into the txt file tidydata.txt
write.table(tidy_data,file="tidydata.txt", row.names=FALSE)
