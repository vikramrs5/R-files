sample_dt=sample.split(iris,SplitRatio = 0.8)
sample_dt
train_dt=subset(iris,sample_dt=="TRUE")
train_dt
test_dt=subset(iris,sample_dt=="FALSE")
test_dt
model=rpart(Species~.,data = iris,method = "class")
rpart.plot(model)
p=predict(model,train_dt,type = "class")
table(p,train_dt$Species)
