install.packages("tidyverse")
library(tidyverse)
neg <- bank.data %>% filter(bank.data$balance < 0)
neg = bank.data[bank.data$ba]
View(neg)
neg <- neg %>% filter(neg$marital == "married")
View(neg)
percent <- nrow(neg)/nrow(bank.data) *100
View(percent)
