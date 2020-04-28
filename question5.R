library(lubridate)

# make a date string
#string = paste(5, 3, year(today), sep = "-")

# make a date
#something <- mdy(paste(5, 3, year(today), sep = "-"))

today = Sys.Date()

sch.data$deposit_date <- mdy(paste(sch.data$month, sch.data$day, "2019", sep = "-")) 

# temp <- today() - sch.data$deposit_date[1]
sch.data$last_deposit <- today() - sch.data$deposit_date

#END