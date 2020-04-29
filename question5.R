# make a date string
#string = paste(5, 3, year(today), sep = "-")

# make a date
#something <- mdy(paste(5, 3, year(today), sep = "-"))

bank.data$deposit_date <- mdy(paste(bank.data$month, bank.data$day, "2019", sep = "-")) 

# temp <- today() - bank.data$deposit_date[1]
bank.data$last_deposit <- today() - bank.data$deposit_date

#END