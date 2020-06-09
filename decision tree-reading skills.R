#decision tree analysis  using regression

read=readingskills1
read=read[,-1]
str(read)
summary(read)
####train and test data
library(caTools)
sample_dt_rs=sample.split(read,SplitRatio = 0.8)
sample_dt_rs
train_dt_rs=subset(read,sample_dt_rs=="TRUE")
train_dt_rs
test_dt_rs=subset(read,sample_dt_rs=="FALSE")
test_dt_rs
###building a decision tree
library(rpart)
library(rpart.plot)
my_dtmodel=rpart(score~.,data = train_dt_rs,method = "anova")
rpart.plot(my_dtmodel)
p=predict(my_dtmodel,test_dt_rs,type = "vector")
E=table(actualvalue=test_dt_rs$score,predictedvalue=p)
acc_test=sum(diag(E))/sum(E)
acc_test
