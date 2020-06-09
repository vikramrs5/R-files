str(readingskills1)
DTree=readingskills1
summary(DTree)
str(DTree)
library(caTools)
sample_dt=sample.split(DTree,SplitRatio = 0.8)
sample_dt
train_dt=subset(DTree,sample_dt=="TRUE")
train_dt
test_dt=subset(DTree,sample_dt=="FALSE")
test_dt


library(tree)
dt_model=tree(score~.,data = train_dt)
plot(dt_model)
text(dt_model)
library(rpart)
library(rpart.plot)
dt_model1=rpart(score~.,data = train_dt)
rpart.plot(dt_model1)
dt_model1_p=rpart(score~.,data = train_dt,method = "class")
dt_pred=predict(dt_model1_p,test_dt,type = "class")
dt_pred
table(test_dt[])
