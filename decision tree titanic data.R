titanic_dtree4=titanic_orig
str(titanic_dtree4)
titanic_dtree4=titanic_dtree4[,-1]
summary(titanic_dtree4)
titanic_dtree4$sex=ifelse(titanic_dtree4$sex=="male",1,0)
titanic_dtree4$survived=ifelse(titanic_dtree4$survived=="yes",1,0)


library(caTools)
sample_titdt=sample.split(titanic_dtree4,SplitRatio = 0.8)
sample_titdt
train_titdt=subset(titanic_dtree4,sample_titdt=="TRUE")
train_titdt
test_titdt=subset(titanic_dtree4,sample_titdt=="FALSE")
test_titdt
library(rpart)
library(rpart.plot)
my_titdt_model=rpart(survived~.,data = train_titdt,method = "class")
my_titdt_model
rpart.plot(my_titdt_model)
pred=predict(my_titdt_model,test_titdt,type = "class")
pred
t=table(actualvalue=test_titdt$survived,predictedvalue=pred)
accu_test=sum(diag(t))/sum(t)
accu_test
