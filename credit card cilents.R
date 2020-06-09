credit_clients2=default_of_credit_card_clients
str(credit_clients2)
summary(credit_clients2)
library(caTools)
credit_clients2$dpnm=factor(credit_clients2$dpnm,levels = c(0,1))
credit_clients2$EDUCATION=factor(credit_clients2$EDUCATION,levels = c(1,2,3,4,5,6))
sample_cc=sample.split(credit_clients2,SplitRatio = 0.8)
sample_cc
train_cc=subset(credit_clients2,sample_cc=="TRUE")
train_cc
test_cc=subset(credit_clients2,sample_cc=="FALSE")
test_cc
library(rpart)
library(rpart.plot)
my_cc_model1=rpart.control(minsplit = 6,minbucket = round(5/3),maxdepth = 6,cp = 0.0014)
my_cc_model=rpart(dpnm~.,data = test_cc,method = "class",
                  control =my_cc_model1)
my_cc_model
rpart.plot(my_cc_model)
printcp(my_cc_model)
pred=predict(my_cc_model,test_cc,type = "class")
pred
t1=table(actualvalue=test_cc$dpnm,predictedvalue=pred)
accu_test=sum(diag(t1))/sum(t1)
accu_test
plotcp(my_cc_model)
