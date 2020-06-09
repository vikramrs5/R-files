str(Titanic_Data)
Titanic_log1=Titanic_Data
summary(Titanic_log1)
head(Titanic_log1)
Titanic_log1$Age=as.numeric(Titanic_log1$Age)
is.na(Titanic_log1)
Titanic_log1$Age[is.na(Titanic_log1$Age)]=median(Titanic_log1$Age,na.rm = TRUE)
summary(Titanic_log1)
str(Titanic_log1)
###ggplot
library(ggplot2)
ggplot2
qplot(Pclass,Sex,data = Titanic_log1,col=Survived)
###catools
library(caTools)
split_tt=sample.split(Titanic_log1,SplitRatio = 0.8)
split_tt
train_tt=subset(Titanic_log1,split_tt=="TRUE")
train_tt
test_tt=subset(Titanic_log1,split_tt=="FALSE")
test_tt
model_tt=glm(Survived~.,train_tt,family = 'binomial')
summary(model_tt)
###prediction
tt_pred=predict(model_tt,test_tt,type = "response")
tt_pred
table(actualval=test_tt$Survived,predictval=tt_pred>0.55)
accuracy=(42+13)/65
accuracy
###rocr
library(ROCR)
ROCRpredict=prediction(tt_pred,test_tt$Survived)
ROCRperfor=performance(ROCRpredict,"acc")
plot(ROCRperfor)
ROCRperfor=performance(ROCRpredict,"fpr","tpr")
plot(ROCRperfor,colorize=TRUE,print.cutoffs.at=seq(0.1,by=0.1))
