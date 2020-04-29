hist(bank.data$age)
boxplot(bank.data$age)
bins <- 4
abs.max <- max(bank.data$age)
abs.min <- min(bank.data$age)
new.max <- abs.max + bins 
width <- (new.max - abs.min) / bins

age.temp = cut(bank.data$age, breaks = seq(abs.min, new.max, width), labels = c("Young Adult","Adults", "Mid-life", "Elderly"), right = FALSE)
bank.data$age <- age.temp