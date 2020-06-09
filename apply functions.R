m1 <- matrix(c <- (1:12),nrow = 6)
m1
#apply
app_m1=apply(m1,2,mean)  # 1-row,2-column
app_m1

my_class <- c("a","b","c","d","e","f")
my_class
## lapply= list apply
my_class <- lapply(my_class,toupper)
my_class
## sapply = vector apply or column apply.
my_analysis=cars
my_lapply=lapply(my_analysis,max)
my_lapply
my_sapply=sapply(my_analysis,max)
my_sapply

#tapply = to check calculations for an individual variable
data("iris")
my_tapply=tapply(iris$Sepal.Length,iris$Petal.Length,mean)
my_tapply

#vapply
my_vapply=vapply(iris$Sepal,mean)
