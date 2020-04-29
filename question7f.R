install.packages("tidyverse")
library(tidyverse)
neg <- cohort2020.set.a %>% filter(cohort2020.set.a$balance < 0)
View(neg)
neg <- neg %>% filter(neg$marital == "married")
View(neg)
percent <- nrow(neg)/nrow(cohort2020.set.a) *100
View(percent)
