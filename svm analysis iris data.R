iris
View(iris)
plot(iris)
s=sample(150,120)
iris_train=iris[s,]
iris_train
iris_test=iris[-s,]
iris_test
library(e1071)
svm_my_analysis=svm(Species~.,data = iris_train,kernel="linear")
summary(svm_my_analysis)
library(rgl)
iris$Species=as.factor(c(iris$Species))
plot3d(iris$Petal.Width,iris$Sepal.Width,iris$Petal.Length,col=iris$Species,size=10)

library(WriteXLS)
write.csv(iris,"irisdata.csv")
getwd()

iri=function(x){subset(x,iris$Species=="setosa")}
iri(iris)
colMeans(iri[,-5])
