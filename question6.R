library(lubridate)
library(magrittr)
library(dplyr)
data <- bank.data %>% select(month, deposit)
period_one <- data %>% filter(data$month >= 1 & data$month <= 3)
View(period_one)

period_two <- data %>% filter(data$month >= 4 & data$month <= 6)
View(period_two)

deposit_one <- ts(period_one$deposit)
deposit_two <- ts(period_two$deposit)

plot.ts(deposit_one)
plot.ts(deposit_two)

#couldn't get both ts in one display
#should be possible using a matrix but it didn't work