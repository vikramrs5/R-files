
data("AirPassengers")
class(AirPassengers)
sum(is.na(AirPassengers))
D_Data=decompose(AirPassengers,"multiplicative")
#decompose : Decomposing a seasonal time series means separating the time series into these three components.(trend,Sesonsal & random)
plot(D_Data)
D_Data$trend
plot(D_Data$trend)
ap=AirPassengers
cycle(ap)

#Train & Test
library(caTools)
Sample_A=sample.split(AirPassengers,SplitRatio = 0.8)
Sample_A
Train_A= subset(AirPassengers,Sample_A=="TRUE")
Train_A
Test_A= subset(AirPassengers,Sample_A=="FALSE")
Test_A

#model
plot(ap)
abline(re=lm(ap~time(ap)))
 
# histogram plot 
set.seed(1234); ap<-rnorm(200)
hist(ap, col="lightblue")
abline(v = mean(ap), col="red", lwd=3, lty=2)

# boxplot
boxplot(ap~cycle(ap),xlab="Date")

# start & end
start(ap)
end(ap)

# forecast
install.packages("forecast")
library(forecast)

#auto arima: which combines unit root tests, minimisation of the AICc and MLE to obtain an ARIMA mode
model=auto.arima(ap)
model
auto.arima(ap,trace = TRUE,ic = "aic",stepwise = FALSE )

#(time-series)
install.packages("tseries")
library(tseries)
library(forecast)
plot.ts(model$residuals)
myforcast=forecast(model,level=95,h=10*12)
plot(myforcast)

