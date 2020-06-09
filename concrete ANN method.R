Concrete_Data
concrete_ANN=Concrete_Data
summary(concrete_ANN)
str(concrete_ANN)
norm=function(x){((x-min(x))/(max(x)-min(x)))}
concrete_ANN_norm=as.data.frame(lapply(concrete_ANN,norm))
summary(concrete_ANN_norm)
library(caTools)
split_conc=sample.split(concrete_ANN_norm,SplitRatio = 0.8)
split_conc
train_ANN=subset(concrete_ANN_norm,split_conc=="TRUE")
train_ANN
test_ANN=subset(concrete_ANN_norm,split_conc=="FALSE")
test_ANN
library(neuralnet)
## model
concrete_model=neuralnet(formula = strength~.,data = train_ANN)
plot(concrete_model)
model_result=compute(concrete_model,test_ANN)
pred_strength=model_result$net.result
accuracy_perc=cor(pred_strength,test_ANN$strength)
accuracy_perc
concrete_model_1=neuralnet(formula = strength~.,data = train_ANN,hidden = 5)
plot(concrete_model_1)
model_result_1=compute(concrete_model_1,test_ANN)
pred_strength_1=model_result_1$net.result
accuracy_perc_1=cor(pred_strength_1,test_ANN$strength)
accuracy_perc_1
