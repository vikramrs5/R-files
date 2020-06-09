View(Kaggle_logistics)
str(Kaggle_logistics)
summary(Kaggle_logistics)
my_lreg=Kaggle_logistics
my_lreg$type=ifelse(my_lreg$type=="Yes",1,0)
my_lreg$type=factor(my_lreg$type,levels = c(0,1))
summary(my_lreg)
library(caTools)
split_train_test=sample.split(my_lreg,SplitRatio = 0.8)
split_train_test
train=subset(my_lreg,split_train_test=="TRUE")
train
test=subset(my_lreg,split_train_test=="FALSE")
test
my_lreg_eqn=glm(type~.,train,family = 'binomial')
my_lreg_eqn
summary(my_lreg_eqn)
my_lreg_cal=glm(type~.-bp,train,family = 'binomial')
summary(my_lreg_cal)
my_lreg_cal=glm(type~.-age,train,family = 'binomial')
summary(my_lreg_cal)
my_lreg_cal=glm(type~.-skin,train,family = 'binomial')
summary(my_lreg_cal)
test_pred=predict(my_lreg_eqn,test,type="response")
test_pred
table(actualvalue=test$type,predictedvalue=test_pred>0.55)
(54+13)/(83)
library(ROCR)
ROCRpred=prediction(test_pred,test$type)
ROCRperf=performance(ROCRpred,"fpr","tpr")
plot(ROCRperf,colorize=TRUE,print.cutoffs.at=seq(0.1,by=0.1))
