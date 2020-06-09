mylog_reg1=Logistics_Regression

#Removing the unwanted columns that is not required for logistic regression
mylog_reg1=mylog_reg1[,-5]
mylog_reg1=mylog_reg1[,-5]
mylog_reg1=mylog_reg1[,-6]
mylog_reg1=mylog_reg1[,-6]

#viewing the final data that is required for logistic regression
View(mylog_reg1)
mylog_reg1$COA=ifelse(mylog_reg1$COA=="1",1,0)
mylog_reg1$COA=factor(mylog_reg1$COA,levels = c(0,1))
summary(mylog_reg1)
str(mylog_reg1)

#Train and Test
library(caTools)
sample_logreg=sample.split(mylog_reg1,SplitRatio = 0.8)
sample_logreg
train_logreg=subset(mylog_reg1,sample_logreg=="TRUE")
train_logreg
test_logreg=subset(mylog_reg1,sample_logreg=="FALSE")
test_logreg

model_lreg=glm(COA~.,train_logreg,family = 'binomial')
summary(model_lreg)

##PREDICTION and ACCURACY
lreg_pr=predict(model_lreg,test_logreg,type = "response")
lreg_pr
tab=table(actualvalue=test_logreg$COA,predictedvalue=lreg_pr>0.5)
tab
accuracy_test=sum(diag(tab))/sum(tab)
accuracy_test

#ROCR
library(ROCR)
ROCRpredict_lreg=prediction(lreg_pr,test_logreg$COA)
ROCRperformance_lreg=performance(ROCRpredict_lreg,"acc")
plot(ROCRperformance_lreg)
ROCRperformance_lreg=performance(ROCRpredict_lreg,"fpr","tpr")
plot(ROCRperformance_lreg,colorize=TRUE,print.cutoffs.at=seq(0.1,by=0.1))

##GGPLOT CONCEPTS
library(ggplot2)
library(ggridges)
library(ggExtra)
p=ggplot(mylog_reg1,aes(`Daily Time Spent on Site`,`Daily Internet Usage`,color=COA))+geom_point()
p
# voilin plot
ggplot(mylog_reg1,aes(`Daily Time Spent on Site`,`Daily Internet Usage`,fill=COA))+geom_violin(width=1.4)+
  theme_light()
#violin + Boxplot
ggplot(mylog_reg1,aes(`Daily Time Spent on Site`,`Daily Internet Usage`,fill=COA))+geom_violin(width=1.4)+geom_boxplot()
theme_light()
#density2D
ggplot(mylog_reg1,aes(COA,`Daily Internet Usage`))+stat_density2d(geom = "tile",aes(fill=..density..),contour = FALSE)+geom_point()

