library(tidyverse)
library(ggthemes)
library(GGally)
library(ggExtra)
library(caret)
library(glmnet)
library(corrplot)
library(leaflet)
library(kableExtra)
library(RColorBrewer)
library(plotly)
th <- theme_fivethirtyeight() + theme(axis.title = element_text(), axis.title.x = element_text()) # global theme for ggplot2 objects
set.seed(252)
head(AB_NYC_2019) %>% kable() %>% kable_styling()
summary(AB_NYC_2019)
names_to_delete <- c("id", "host_id")
AB_NYC_2019[names_to_delete] <- NULL
names_to_factor <- c("host_name", "neighbourhood_group", "neighbourhood", "room_type")
AB_NYC_2019[names_to_factor] <- map(AB_NYC_2019[names_to_factor], as.factor)
library(lubridate)

AB_NYC_2019[c("last_review")] <- AB_NYC_2019[c("last_review")] % >% map(~lubridate::ymd(.x))
glimpse(AB_NYC_2019)

