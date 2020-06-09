Titaniclog=Titanic
str(Titaniclog)
head(Titaniclog)
#Converting the Age Variable into Numeric
Titaniclog$Age=as.numeric(Titaniclog$Age)
is.na(Titaniclog)
Titaniclog$Age[is.na(Titaniclog$Age)]=median(Titaniclog$Age,na.rm = TRUE)
#Removing unwanted Variables for the Analysis
Titaniclog=Titaniclog[,-4]
Titaniclog=Titaniclog[,-8]
Titaniclog=Titaniclog[,-9]
Titaniclog=Titaniclog[,-1]
summary(Titaniclog)
nonvars = c("Embarked","Sex")
Titaniclog = Titaniclog[,!(names(Titaniclog) %in% nonvars)]
str(Titaniclog)
#Train and Test
library(caTools)
sample_titaniclog=sample.split(Titaniclog,SplitRatio = 0.8)
sample_titaniclog
train_titaniclog=subset(Titaniclog,sample_titaniclog=="TRUE")
train_titaniclog
test_titaniclog=subset(Titaniclog,sample_titaniclog=="FALSE")
test_titaniclog
#Building Model
model_lreg=glm(Survived~.,train_titaniclog,family = 'binomial')
summary(model_lreg)
##PREDICTION and ACCURACY
lreg_pr=predict(model_lreg,test_titaniclog,type = "response")
lreg_pr
tab=table(actualvalue=test_titaniclog$Survived,predictedvalue=lreg_pr>0.35)
tab
accuracy_test=sum(diag(tab))/sum(tab)
accuracy_test
#ROCR
library(ROCR)
ROCRpredict_lreg=prediction(lreg_pr,test_titaniclog$Survived)
ROCRperformance_lreg=performance(ROCRpredict_lreg,"acc")
plot(ROCRperformance_lreg)
ROCRperformance_lreg=performance(ROCRpredict_lreg,"fpr","tpr")
plot(ROCRperformance_lreg,colorize=TRUE,print.cutoffs.at=seq(0.1,by=0.1))
##GGPLOT CONCEPTS
library(ggplot2)
library(ggridges)
library(ggExtra)
#Scatter Plot
p=ggplot(Titaniclog,aes(Pclass,Age,color=Survived))+geom_point()
p
#violin + Boxplot
ggplot(Titaniclog,aes(Fare,Age,fill=Survived))+geom_violin(width=1.4)+geom_boxplot()
theme_light()


