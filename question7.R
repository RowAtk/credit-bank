#7a highest average deposit for each job type
Job <- levels(bank.data$job)
Average_deposit <- rep(0, length(Job))
job_deposits <- data.frame(Job, Average_deposit)

for(x in 1:(length(Job))){
  temp <- sum(bank.data[bank.data$job == Job[x], 10])/nrow(bank.data[bank.data$job == Job[x],]) #sum the deposits for each job type
  job_deposits$Average_deposit[x] <- temp
}
job_deposits = job_deposits[with(job_deposits, order(-job_deposits$Average_deposit)),] #sort in decending order by average deposit
job_deposits$Average_deposit = round(job_deposits$Average_deposit, digits = 2)
View(job_deposits)
View(job_deposits[0:2,])

# Avg = sum(1 job type) / no. all records


#7b dominant educational level for each job type
Educational_level <- rep(0, length(Job))
dominant_ed <- data.frame(Job, Educational_level)

modefunc <- function(v) {
  a <- unique(v)
  a[which.max(tabulate(match(v, a)))]
}

for(x in 1:(length(Job))){
  temp <- bank.data[bank.data$job == Job[x], 4]
  dominant_ed$Educational_level[x] <- modefunc(temp)
}
dominant_ed[with(dominant_ed, order(dominant_ed$Job)),]
View(dominant_ed)

#7c % of people who have neither mortgage nor personal loan
no_loan <- bank.data[(bank.data$housing_n == 1) & (bank.data$loan_n == 1),]
nrow(no_loan) / nrow(bank.data) * 100


#7d age group with the highest average balance
#summary(bank.data$age)
age_groups = levels(bank.data$age)
balance <- rep(0, length(age_groups))
age_balance <- data.frame(age_groups, balance)

for(x in 1:(length(age_groups))){
  temp <- sum(bank.data[bank.data$age == age_groups[x], 11])/nrow(bank.data[bank.data$age == age_groups[x],]) #sum the deposits for each job type
  age_balance$balance[x] <- round(temp, digits = 2)
}

View(age_balance)
View(age_balance[age_balance$balance == max(age_balance$balance), ])
