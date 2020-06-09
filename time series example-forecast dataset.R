install.packages("forecast")
library(forecast)
Time_series=forecast_example
View(Time_series)
nrow(Time_series)
plot(Time_series,col="Blue")
##test and train
library(caTools)
sample_ts=sample.split(Time_series,SplitRatio = 0.8)
sample_ts
train_ts=subset(Time_series,sample_ts=="TRUE")
train_ts
test_ts=subset(Time_series,sample_ts=="FALSE")
test_ts
##moving average

ma_1=forecast(ma(Time_series,order = 2))
plot(ma_1)

#ses
exp=ses(train_ts,3,initial = "simple")
plot(exp)
