summary(House_Price_Kaggle)
plot(House_Price_Kaggle)
scatter.smooth(House_Price_Kaggle$sqft_living,House_Price_Kaggle$price,main='SQUARE FEET LIVING VS PRICE',xlab = 'sqft_living',ylab = 'price')
boxplot(House_Price_Kaggle$bedrooms,col = "blue")
boxplot(House_Price_Kaggle$bathrooms,col = "green")
boxplot(House_Price_Kaggle$sqft_living,col = "yellow")
boxplot(House_Price_Kaggle$sqft_lot,col = "light blue")
boxplot(House_Price_Kaggle$floors,col = "red")
boxplot(House_Price_Kaggle$price,col = "violet")
str(House_Price_Kaggle)
par(mfrow=c(1,1))
cc=cor(House_Price_Kaggle)
cc
library(corrplot)
corrplot(cc)
##corrplot
library(GGally)
ggpairs(House_Price_Kaggle)
##model
linearmodel=lm(price~bedrooms+bathrooms+sqft_living+sqft_lot,data = House_Price_Kaggle)
linearmodel
summary(linearmodel)
my_predict=data.frame(bedrooms=4,bathrooms=4,sqft_living=3000,sqft_lot=20000)
my_predict_result=predict(linearmodel,my_predict)
my_predict_result
abline(lm(price~sqft_living,data = House_Price_Kaggle),col="blue")
