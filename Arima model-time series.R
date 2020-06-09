Arima_model=Book1
Arima_model$Time=substr(Arima_model$Time,12,16)
Arima_model
Arima_model$Time=as.POSIXct(Arima_model$Time,format="%H:%M")
Arima_model$Time=format(Arima_model$Time,"%H:%M")

hour(Arima_model$Time)
minute(Arima_model$Time)
install.packages("hms")
library(hms)###hour minute seconds library
Arima_model$Time <-hms(Arima_model$Time)

str(Arima_model)
Arima_model
sum(is.na(Arima_model))

# library need for time series analysis
install.packages('xts')
library(xts)
Timeseries =xts(Arima_model[,-1],order.by = Arima_model[,1])
as.Date(Arima_model[,1])

plot(Arima_model)
abline(reg=lm(Arima_model~time(Arima_model$Time)))
start(Arima_model)
end(Arima_model)
