rm(list = ls())

# Load Data
# sch.data <- read.csv(file = file.choose(), stringsAsFactors = TRUE, header = TRUE, sep = ",")
sch.data <- read.csv(file = "cohort2020-set-a.csv", stringsAsFactors = TRUE, header = TRUE, sep = ',', na.strings = c("", "NA"))

# Explore Data
View(sch.data)
nrow(sch.data[!complete.cases(sch.data),])

# 1 A
summary(sch.data)
hist(as.numeric(as.character(sch.data$job)))
hist(sch.data$age)
hist(sch.data$duration)
hist(sch.data$deposit)
hist(sch.data$balance)


# Fix missing values
sch.data$contact = NULL # get rid of contact was useless 
sch.data$RefNum = NULL

# Job
levels(sch.data$job) <- c(levels(sch.data$job), "other")
sch.data$job[is.na(sch.data$job)] <- "other"

# Education - primary: 1, secondary: 2, tertiary: 3
levels(sch.data$education)
sch.data$education <- as.integer(as.factor(sch.data$education))
sch.data$education[is.na(sch.data$education)] <- 0

# Housing
# yes - housing_y, no - houing_n
levels(sch.data$housing)
#sch.data$housing_y <- sch.data$housing[sch.data$housing == 'yes']
sch.data = sch.data[!is.na(sch.data$housing),] # remove rows with N/A in housing
sch.data$housing_y[sch.data$housing == 'yes'] = 1
sch.data$housing_y[is.na(sch.data$housing_y)] = 0
sch.data$housing_n[sch.data$housing == 'no'] = 1
sch.data$housing_n[is.na(sch.data$housing_n)] = 0

# Loan
sch.data = sch.data[!is.na(sch.data$loan),] # remove rows with N/A in loan
sch.data$loan_y[sch.data$loan == 'yes'] = 1
sch.data$loan_y[is.na(sch.data$loan_y)] = 0
sch.data$loan_n[sch.data$loan == 'no'] = 1
sch.data$loan_n[is.na(sch.data$loan_n)] = 0

#day
# no missing values

# month
summary(sch.data$month)
levels(sch.data$month)
hist(as.numeric(as.factor(sch.data$month)))

sch.data$month <- match(as.factor(sch.data$month), tolower(month.name))

# Duration
# no missing values

#Deposit
hist(sch.data$deposit)
boxplot(sch.data$deposit)

#length(sch.data$job[sch.data$deposit > 49000 & !is.na(sch.data$deposit)])
sch.data$deposit[is.na(sch.data$deposit)] = median(sch.data$deposit[!is.na(sch.data$deposit)])

# deposit_N = 
# IW = (minimum(sch.data$deposit) - maximum(sch.data$deposit)) / deposit_N


# END OF MISSING VALUES
nrow(sch.data[!complete.cases(sch.data),])

# Question 2
# convert duration from seconds to minutes (60s -> 1 min)
# 3.20

minutes = function (seconds) {
  period = seconds_to_period(sch.data$duration)
  return(minute(period) + 0.01 * second(period))
}

sch.data$duration = minutes(sch.data$duration)

# Proof
# new_duration = minutes(sch.data$duration)
# View(data.frame(old=sch.data$duration, new=new_duration))


#Question 3
hist(sch.data$age)

library(classInt)

ages = sch.data$age

# frequency
f <- classIntervals(ages, 3, style = 'quantile')

# width
w <- classIntervals(ages, 3, style = 'equal')

copy.data = sch.data
copy.data$age = f
View(data.frame(old_age=sch.data$age, new_age=copy.data$age))

#Q4

#Q5
library(lubridate)

# make a date string
#string = paste(5, 3, year(today), sep = "-")

# make a date
#something <- mdy(paste(5, 3, year(today), sep = "-"))

today = Sys.Date()

sch.data$day[sch.data$day > 29 & sch.data$month == 2] = 28

sch.data$deposit_date <- mdy(paste(sch.data$month, sch.data$day, "2019", sep = "-")) 

# temp <- today() - sch.data$deposit_date[1]
sch.data$last_deposit <- today() - sch.data$deposit_date

#END










#7a highest average deposit for each job type
Job <- levels(sch.data$job)
Average_deposit <- c(0,0)
job_deposits <- data.frame(Job, Average_deposit)

for(x in 1:(length(Job))){
  temp <- sum(sch.data[sch.data$job == Job[x], 10])/nrow(sch.data) #sum the deposits for each job type
  job_deposits$Average_deposit[x] <- temp
}
job_deposits[with(job_deposits, order(-job_deposits$Average_deposit)),] #sort in decending order by average deposit


#7b dominant educational level for each job type
Educational_level <- c(0,0)
dominant_ed <- data.frame(Job, Educational_level)

modefunc <- function(v) {
  a <- unique(v)
  a[which.max(tabulate(match(v, a)))]
}

for(x in 1:(length(Job))){
  temp <- sch.data[sch.data$job == Job[x], 4]
  dominant_ed$Educational_level[x] <- modefunc(temp)
}
dominant_ed[with(dominant_ed, order(dominant_ed$Job)),]


#7c % of people who have neither mortgage nor personal loan
no_loan <- sch.data[(sch.data$housing == "no") & (sch.data$loan == "no"),]
nrow(no_loan) / nrow(sch.data) * 100


#7d age group with the highest average balance
#summary(sch.data$age)
hist(sch.data$age)
boxplot(sch.data$age)
bins <- 3
abs.max <- max(sch.data$age)
abs.min <- min(sch.data$age)
new.max <- abs.max + bins 
width <- (new.max - abs.min) / bins

sch.data$age <- cut(sch.data$age, breaks = seq(abs.min, new.max, width), labels = c("young", "mid-life", "old"), right = FALSE)
age_groups = levels(sch.data$age)
balance <- c(0,0,0)
age_balance <- data.frame(age_groups, balance)

for(x in 1:(length(age_groups))){
  temp <- sum(sch.data[sch.data$age == age_groups[x], 11])/nrow(sch.data) #sum the deposits for each job type
  age_balance$balance[x] <- temp
}

