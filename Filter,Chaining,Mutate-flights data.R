install.packages("dplyr")
library(dplyr)
install.packages("hflights")
library(hflights)
data("hflights")
View(hflights)
flight=tbl_df(hflights)
flight

#filter
filter(flight,Month==1|DayofMonth==2)
#select
select(flight,DepTime,ArrTime)
#chaining %>%
flight %>%
   select(DepTime,ArrTime) %>%  
   filter(ArrTime>1500)
#mutate : creating a new variable--cannot be used when using group_by
flight =flight %>%mutate(Speed=Distance/AirTime*60)
str(flight)
#group_by and Summarize 
flight %>%
  group_by(Dest) %>%
  summarise(avg_delay=mean(ArrDelay,na.rm = TRUE))
flight %>%
  group_by(Month,DayofMonth) %>%
  tally(sort = TRUE)  
b=flight %>%
  select(Month,DayofMonth) %>%
  filter(Month==8 ,DayofMonth==4)
View(b)  
