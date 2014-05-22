
#Merging dateset
setwd("./UCI HAR Dataset")
features<-read.table("features.txt")

#training data
setwd("./train")
x.train<-read.table("X_train.txt",header=FALSE)
y.train<-scan("y_train.txt")
colnames(x.train)<-as.character(features[,2])
train<-cbind(activity=y.train,x.train)
setwd("../")

#test data
setwd("./test")
x.test<-read.table("X_test.txt",header=FALSE)
y.test<-scan("y_test.txt")
colnames(x.test)<-as.character(features[,2])
test<-cbind(activity=y.test,x.test)
setwd("../")

#convert number into acitivity labels
activity.label<-read.table("activity_labels.txt",header=FALSE)
train[,1]<-activity.label[match(train$activity,activity.label[,1]),2]
test[,1]<-activity.label[match(test$activity,activity.label[,1]),2]

#make on dataset
dataset<-cbind(kind=rep(c("train","test"),times=c(nrow(train),nrow(test))),
               rbind(train,test))


#extract mean and sd for each mesurement
col.mean.std<-c(grep("mean()",features[,2]),grep("std()",features[,2]))
col.mean.std<-c(1,2,col.mean.std[order(col.mean.std)]+2)

ignore.case<-grep("meanFreq()",features[,2])
ignore.case<-c(1,2,ignore.case[order(ignore.case)]+2)
ignore.case<-match(ignore.case,col.mean.std)

col.mean.std<-c(1,2,col.mean.std[-(ignore.case)])
new.data<-dataset[,col.mean.std]

#average of each variables
mean.test.train<-function(x,y){
  subseted<-subset(x,x$kind==y)
  means<-tapply(subseted[,3],subseted$activity,mean)
  for(i in 4:ncol(x)){
    means<-cbind(means,tapply(subseted[,i],subseted$activity,mean))
  }
  rownames(means)<-activity.label[,2]
  colnames(means)<-colnames(x[,3:ncol(x)])
  means
}

tidy.data<-rbind(mean.test.train(new.data,"test"),
                 mean.test.train(new.data,"train"))

rownames(tidy.data)<-paste(rep(c("train: ","test: "),times=c(6,6)),
                           rownames(tidy.data),sep="")


#output
write.table(tidy.data,"tidy_data.txt")
