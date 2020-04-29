rm(list = ls())
op <- options()

# Load Data
# bank.data <- read.csv(file = file.choose(), stringsAsFactors = TRUE, header = TRUE, sep = ",")
bank.data <- read.csv(file = "cohort2020-set-a.csv", stringsAsFactors = TRUE, header = TRUE, sep = ',', na.strings = c("", "NA"))
      
# Explore Data
View(bank.data)
nrow(bank.data[!complete.cases(bank.data),])
summary(bank.data)

# -----  ---- #

# ----- Fix missing values ----- #
# RefNum
bank.data$RefNum = NULL # no use for reference number

# Age 
boxplot(bank.data$age)
hist(bank.data$age)

# Job
#barplot(summary(bank.data$job), las=2) # plot graph to identify outliers or noise
#levels(bank.data$job) <- c(levels(bank.data$job), "other") # add 'other' as possible value
#bank.data$job[is.na(bank.data$job)] <- "other"
bank.data = bank.data[!is.na(bank.data$job),]
summary(bank.data[!is.na(bank.data$job),])

# marital

# Education - primary: 1, secondary: 2, tertiary: 3
levels(bank.data$education)
bank.data$education <- as.integer(as.factor(bank.data$education))
bank.data = bank.data[!is.na(bank.data$education),]
summary(bank.data[!is.na(bank.data$education),])

# Contact
bank.data$contact = NULL # no use for contact feature which was mostly empty 

# Housing
# yes - housing_y, no - houing_n
levels(bank.data$housing)
bank.data = bank.data[!is.na(bank.data$housing),] # remove rows with N/A in housing

lst <- bank.data$housing
lvl <- levels(lst)
new_housing = setNames(data.frame(do.call(rbind,lapply(lst, function(x) as.integer(lvl %in% x)) )), c("housing_n", "housing_y"))
View(data.frame(old=bank.data$housing, new=new_housing))

bank.data = cbind(bank.data, new_housing)

# Loan
bank.data = bank.data[!is.na(bank.data$loan),] # remove rows with N/A in loan

lst <- bank.data$loan
lvl <- levels(lst)
new_loan = setNames(data.frame(do.call(rbind,lapply(lst, function(x) as.integer(lvl %in% x)) )), c("loan_n", "loan_y"))
View(data.frame(old=bank.data$loan, new=new_loan))

bank.data = cbind(bank.data, new_loan)

# month
# no missing values
#summary(bank.data$month)
levels(bank.data$month)
#hist(as.numeric(as.factor(bank.data$month)))

bank.data$month <- match(as.factor(bank.data$month), tolower(month.name))

#day
# no missing values
# outliers - dates that do not exist / are not possible Eg Feb 30, 2019
library(lubridate)
#View(bank.data[days_in_month(bank.data$month)  < bank.data$day, c("day", "month")]) # view all noisy dates
bank.data$day[bank.data$day > 28 & bank.data$month == 2] = 28 # fix noisy dates

# Duration
# no missing values
hist(bank.data$duration)
boxplot(bank.data$duration)

# Deposit
# contains outliers and missing values. Outliers were left alone missing values replaced with median
hist(bank.data$deposit)
boxplot(bank.data$deposit)
View(bank.data[bank.data$deposit > 2 * 10 ^ 5,])
length(bank.data$job[bank.data$deposit > 49000 & !is.na(bank.data$deposit)])
bank.data$deposit[is.na(bank.data$deposit)] = median(bank.data$deposit[!is.na(bank.data$deposit)])

# balance
# contains outliers... not sure what to do with them ... left them alone
boxplot(bank.data$balance)

# tried to do some analysis to figure out if the outliers have any meaning or not 
# by comparing deposits and balances
#dep_bal = bank.data[bank.data$deposit > 30000, c("deposit", "balance")]
#dep_bal_ratio = (dep_bal$deposit / dep_bal$balance) * 100
#View(dep_bal_ratio)

# END OF MISSING VALUES
nrow(bank.data[!complete.cases(bank.data),])

kable(summarize(bank.data))
