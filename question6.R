install.packages("ggplot2")
library(ggplot2)
library(magrittr)
theme_set(theme_light())

data <- bank.data %>% select(deposit_date, deposit)
period_one <- data %>% filter(data$deposit_date >= as.Date("2019-01-01") & data$deposit_date <= as.Date("2019-03-31"))
period_two <- data %>% filter(data$deposit_date >= as.Date("2019-04-01") & data$deposit_date >= as.Date("2019-06-30"))

ggplot(period_one, aes(x=deposit_date)) +
  geom_line(aes(y=deposit)) + labs(y="Quater 1 Deposits", x="Deposit Date")

ggplot(period_two, aes(x=deposit_date)) +
  geom_line(aes(y=deposit)) + labs(y="Quater 2 Deposits", x="Deposit Date")



