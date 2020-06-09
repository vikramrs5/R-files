getwd()
setwd("/Users/vikramraj/Desktop/R Studio")
getwd()
wdbc=read.table(file.choose(),sep=',')
View(wdbc)
wdbc=wdbc[,-1]
#####normalize formula
data_norm=function(x){((x-min(x))/(max(x)-min(x)))}
wdbc_norm=as.data.frame(lapply(wdbc[,-1],data_norm))
#####normalize formula
summary(wdbc_norm[,1:4])
library(caTools)
split_wdbc=sample.split(wdbc_norm,SplitRatio = 0.8)
wdbc_train=wdbc_norm[1:450,]
wdbc_test=wdbc_norm[451:569,]
library(class)
wdbc_pred=knn(wdbc_train,wdbc_test,wdbc[1:450,1],k=21)
table(wdbc_pred,wdbc[451:569,1])
library(ggplot2)
wdbc$V2=as.factor(wdbc$V2)
qplot(V3,V4,data = wdbc,col=V2)
