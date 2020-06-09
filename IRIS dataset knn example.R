iris
str(iris)
View(iris)
dim(iris)
###K-Nearest Neighbors
data_norm=function(x){((x-min(x))/(max(x)-min(x)))}
iris_norm=as.data.frame(lapply(iris[,-5],data_norm))
iris_train=iris_norm[1:120,]
iris_test=iris_norm[121:150,]
library(class)
iris_pred=knn(iris_train,iris_test,iris[1:120,5],k=7)
accuracy=table(iris_pred,iris[121:150,5])
sum(diag(accuracy/sum(accuracy)))
library(ggplot2)
iris$Species=as.factor(iris$Species)
qplot(Sepal.Length,Sepal.Width,data = iris,col=Species)

###SVM-Support Vector Machine
svm_iris=iris
s=sample(150,120)
iris_train1=svm_iris[s,]
iris_train1
iris_test1=svm_iris[-s,]
iris_test1
library(e1071)
svm_my_analysis=svm(Species~.,data = iris_train1,kernel="linear")
summary(svm_my_analysis)
library(rgl)
plot3d(Petal.Width,Sepal.Width,Petal.Length,col=Species,size=10)

