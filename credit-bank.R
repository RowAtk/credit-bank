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

#Question 

# Question 5
# Day: 5
# Month: 3
# Today: 26/4
# Answer: 52 days
