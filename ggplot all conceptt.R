#ggplot 
library(ggplot2)
library(ggridges)
#DISTRIBUTION
# voilin plot
ggplot(iris,aes(Sepal.Length,Sepal.Width,fill=Species))+geom_violin(width=1.4)+
theme_light()
#violin + Boxplot
ggplot(iris,aes(Sepal.Length,Sepal.Width,fill=Species))+geom_violin(width=1.4)+geom_boxplot()
  theme_light()
#density
ggplot(iris,aes(Sepal.Length,group=Species,fill=Species,alpha=100))+geom_density(adjust=1.5,fill=Species)+
theme_dark()+theme(legend.position = "none",panel.background = element_rect("black"))
#density Mirroring
ggplot(iris,aes(Sepal.Length,y=..density..),fill=Species)+geom_density(adjust=1.5)+theme_dark()+theme(legend.position = "none",panel.background = 
element_rect("black"))+geom_density(iris,mapping=aes(Sepal.Length,y=..density..,fill=Species,alpha=0.5))

p=ggplot(iris,aes(x=x))+geom_density(aes(x=iris$var1,y=-..density..),fill=iris$Species)+geom_label(aes(x=4.5,y=-0.25,label="variable1"),color="red")+theme_dark()+xlab("value of x")
p


#density2D
ggplot(mtcars,aes(mpg,disp))+stat_density2d(geom = "tile",aes(fill=..density..),contour = FALSE)+geom_point()

#Boxplot
ggplot(mpg,aes(class,hwy))+geom_boxplot(color="blue",fill="black",alpha=0.5,notch = TRUE,outlier.colour = "red",)

#Ridge Line Plot
install.packages("ggridges")
library(ggridges)
ggplot(gapminder,aes(year,continent))+geom_density_ridges()
gapminder = read.csv('http://bit.ly/2cLzoxH')
View(gapminder)
ggplot(gapminder, aes(y=as.factor(year),
                      x=lifeExp)) +
  geom_density_ridges(alpha=0.5) +
  scale_y_discrete(expand = c(0.01, 0)) +  
  scale_x_continuous(expand = c(0, 0))+
  theme(axis.text=element_text(size=20))
ggplot(gapminder, aes(y=as.factor(year),
                      x=lifeExp,
                      fill=continent)) +
  geom_density_ridges(alpha=0.25) +
  scale_y_discrete(expand = c(0.01, 0)) +  
  scale_x_continuous(expand = c(0, 0))

#histogram
install.packages("ggExtra")
library(ggExtra)
p=ggplot(mtcars,aes(wt,mpg,color=cyl,size=cyl))+geom_point()
p1=ggMarginal(p,type = "histogram")
p1
#correlation
install.packages("GGally")
library(GGally)
ggcorr(iris,method = c("everything","pearson"))

#3D
library(magick)
library(rgl)
i=iris
i$Species=as.factor(i$Species)
plot3d(iris[,1],iris[,2],iris[,3],col=i$Species,type = "s",radius = 0.2)
plot3d(spin3d(axis = c(0,1,1),rpm = 20),duration=10)

#Word cloud

