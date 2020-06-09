library(ggplot2)
library(ggthemes)
library(lubridate)
library(dplyr)
library(tidyr)
library(DT)
library(scales)
traffic_data=Timeseries
traffic_data$Time <- as.POSIXct(traffic_data$Time, format = "%Y/%M/%D %H:%M:%S")
traffic_data$Time1<- format(as.POSIXct(traffic_data$Time, format = "%Y/%M/%D %H:%M:%S"), format="%H:%M:%S")
traffic_data=traffic_data[,-2]
View(traffic_data)
traffic_data$Day <- ymd(traffic_data$Day)
traffic_data$day1<- factor(day(traffic_data$Day))
traffic_data$month1<- factor(month(traffic_data$Day))
traffic_data$year1<- factor(year(traffic_data$Day))
traffic_data$dayofweek<- factor(wday(traffic_data$Day))
traffic_data$Time1<- hms(traffic_data$Time1)
traffic_data$hour<- factor(hour(traffic_data$Time1))
traffic_data$minute<- factor(minute(traffic_data$Time1))

day_group1 <- traffic_data %>%group_by(day1)
datatable(day_group1)

ggplot(day_group1, aes(hour,`Traffic Density`,fill=day1)) + 
  geom_bar( stat = "identity") +
  ggtitle("Traffic density each Day") +
  theme(legend.position = "none") +
  scale_y_continuous(labels = comma)

ggplot(day_group1, aes(hour,`Traffic Density`, fill = minute)) + 
  geom_bar( stat = "identity") +
  ggtitle("Traffic Density in hour vs Minute") +
  scale_y_continuous(labels = comma) 

day19=filter(traffic_data,day1==19)

ggplot(day19, aes(hour,`Traffic Density`, fill = minute)) + 
  geom_bar( stat = "identity") +
  ggtitle("Traffic Density by hour VS minute") +
  scale_y_continuous(labels = comma) 

ggplot(day19, aes(hour,`Car/Jeep/Van`, fill =`Traffic Density`)) + 
  geom_bar( stat = "identity") +
  ggtitle("Traffic Density by hour VS minute") +
  scale_y_continuous(labels = comma) 


### Saving edited data in R to the system.
traffic_data1=Timeseries
traffic_data1$Time <- as.POSIXct(traffic_data1$Time, format = "%Y/%M/%D %H:%M:%S")
traffic_data1$Time1<- format(as.POSIXct(traffic_data1$Time, format = "%Y/%M/%D %H:%M:%S"), format="%H:%M:%S")
traffic_data1=traffic_data1[,-2]
library(WriteXLS)
write.csv(traffic_data1,"traffic_data")
getwd()
####end code.

#changing character columns to numeric values to do linear regression.
traffic_data=traffic_data[,-1]
