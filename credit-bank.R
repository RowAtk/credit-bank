rm(list = ls())
op <- options()

# Load Data
# sch.data <- read.csv(file = file.choose(), stringsAsFactors = TRUE, header = TRUE, sep = ",")
sch.data <- read.csv(file = "cohort2020-set-a.csv", stringsAsFactors = TRUE, header = TRUE, sep = ',', na.strings = c("", "NA"))
      
# Explore Data
View(sch.data)
nrow(sch.data[!complete.cases(sch.data),])
summary(sch.data)

# -----  ---- #

# ----- Fix missing values ----- #
# RefNum
sch.data$RefNum = NULL # no use for reference number

# Age 
boxplot(sch.data$age)
hist(sch.data$age)

# Job
barplot(summary(sch.data$job), las=2) # plot graph to identify outliers or noise
levels(sch.data$job) <- c(levels(sch.data$job), "other") # add 'other' as possible value
sch.data$job[is.na(sch.data$job)] <- "other"

# marital

# Education - primary: 1, secondary: 2, tertiary: 3
levels(sch.data$education)
sch.data$education <- as.integer(as.factor(sch.data$education))
sch.data$education[is.na(sch.data$education)] <- 0
boxplot(sch.data$education)

# Contact
sch.data$contact = NULL # no use for contact feature which was mostly empty 

# Housing
# yes - housing_y, no - houing_n
levels(sch.data$housing)
#sch.data$housing_y <- sch.data$housing[sch.data$housing == 'yes']
sch.data = sch.data[!is.na(sch.data$housing),] # remove rows with N/A in housing
sch.data$housing_y[sch.data$housing == 'yes'] = 1
sch.data$housing_y[is.na(sch.data$housing_y)] = 0
sch.data$housing_n[sch.data$housing == 'no'] = 1
sch.data$housing_n[is.na(sch.data$housing_n)] = 0

lvl <- levels(sch.data$housing)
lst <- sch.data$housing
setNames(data.frame(sch.data$housing, do.call(rbind,lapply(lst, function(x) as.integer(lvl %in% x)) )), c("housing", lvl))

# Loan
sch.data = sch.data[!is.na(sch.data$loan),] # remove rows with N/A in loan
sch.data$loan_y[sch.data$loan == 'yes'] = 1
sch.data$loan_y[is.na(sch.data$loan_y)] = 0
sch.data$loan_n[sch.data$loan == 'no'] = 1
sch.data$loan_n[is.na(sch.data$loan_n)] = 0

lvl <- levels(sch.data$loan)
lst <- sch.data$loan
setNames(data.frame(sch.data$loan, do.call(rbind,lapply(lst, function(x) as.integer(lvl %in% x)) )), c("loan", lvl))


# month
# no missing values
summary(sch.data$month)
levels(sch.data$month)
hist(as.numeric(as.factor(sch.data$month)))

sch.data$month <- match(as.factor(sch.data$month), tolower(month.name))

#day
# no missing values
# outliers - dates that do not exist / are not possible Eg Feb 30, 2019
library(lubridate)
View(sch.data[days_in_month(sch.data$month)  < sch.data$day, c("day", "month")]) # view all noisy dates
sch.data$day[sch.data$day > 28 & sch.data$month == 2] = 28 # fix noisy dates

# Duration
# no missing values
hist(sch.data$duration)
boxplot(sch.data$duration)

#Deposit
# contains outliers and missing values. Outliers were left alone missing values replaced with median
hist(sch.data$deposit)
boxplot(sch.data$deposit)
View(sch.data[sch.data$deposit > 2 * 10 ^ 5,])
length(sch.data$job[sch.data$deposit > 49000 & !is.na(sch.data$deposit)])
sch.data$deposit[is.na(sch.data$deposit)] = median(sch.data$deposit[!is.na(sch.data$deposit)])

# balance
# contains outliers... not sure what to do with them ... left them alone
boxplot(sch.data$balance)

# tried to do some analysis to figure out if the outliers have any meaning or not 
# by comparing deposits and balances
dep_bal = sch.data[sch.data$deposit > 30000, c("deposit", "balance")]
dep_bal_ratio = (dep_bal$deposit / dep_bal$balance) * 100
View(dep_bal_ratio)

# END OF MISSING VALUES
nrow(sch.data[!complete.cases(sch.data),])
