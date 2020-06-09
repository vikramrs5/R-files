my_log=Kaggle_logistics
my_log$type=ifelse(my_log$type=="Yes",1,0)
my_log$type=factor(my_log$type,levels = c(0,1))
summary(my_log)
library(caTools)
split_t=sample.split(my_log,SplitRatio = 0.8)
split_t
train=subset(my_log,split_t=="TRUE")
train
Test=subset(my_log,split_t=="FALSE")
Test
model_1=glm(type~.,train,family = 'binomial')
summary(model_1)
#### PREDICTION
res_pr=predict(model_1,Test,type="response")
res_pr
table(actualvalue=Test$type,predictedvalue=res_pr>0.55)
(57+13)/(83)
library(ROCR)
par(mfrow=c(1,2))
ROCRpred_1=prediction(res_pr,Test$type)
ROCRperf_1=performance(ROCRpred_1,"acc")
plot(ROCRperf_1)
ROCRperf_1=performance(ROCRpred_1,"fpr","tpr")
plot(ROCRperf_1,colorize=TRUE,print.cutoffs.at=seq(0.1,by=0.1))

