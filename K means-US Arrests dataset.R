USArrests
View(USArrests)
str(USArrests)
install.packages("tidyverse") #data manipulation
install.packages("cluster")
install.packages("factoextra")
usarr=USArrests
View(usarr)
library(tidyverse)
library(cluster)
library(factoextra)
library(caTools)

split_usarr=sample.split(usarr,SplitRatio = 0.8)
split_usarr
train_usarr=subset(usarr,split_usarr=="TRUE")
train_usarr=scale(train_usarr)
test_usarr=subset(usarr,split_usarr=="FALSE")
test_usarr=scale(test_usarr)
#model
k_means_usarr=kmeans(train_usarr,centers = 2,nstart = 25)
k_means_usarr
fviz_cluster(k_means_usarr,data =train_usarr )
k3=kmeans(train_usarr,centers = 3,nstart = 25)
k4=kmeans(train_usarr,centers = 4,nstart = 25)
k5=kmeans(train_usarr,centers = 5,nstart = 25)

#plot to compare
p1=fviz_cluster(k_means_usarr,geom = "Points",data = train_usarr)+ggtitle("K=2")
p2=fviz_cluster(k3,geom = "Points",data = train_usarr)+ggtitle("K=3")
p3=fviz_cluster(k4,geom = "Points",data = train_usarr)+ggtitle("K=4")
p4=fviz_cluster(k5,geom = "Points",data = train_usarr)+ggtitle("K=5")
library(gridExtra)
grid.arrange(p1,p2,p3,p4,nrow=2)
#elbow
Elbow1=function(k){kmeans(train_usarr,k,nstart = 10)$tot.withinss}
#k=1 to k=15
k.values=c(1:15)
Elbow_values=map_dbl(k.values,Elbow1)
plot(k.values,Elbow_values,type = "b",xlab = "No.of Clusters K",ylab = "tot.withinss")

