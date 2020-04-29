# Question 2
# convert duration from seconds to minutes (60s -> 1 min)
# 3.20

minutes = function (seconds) {
  period = seconds_to_period(bank.data$duration)
  return(minute(period) + 0.01 * second(period))
}

bank.data$duration = minutes(bank.data$duration)

# Proof
# new_duration = minutes(bank.data$duration)
# View(data.frame(old=bank.data$duration, new=new_duration))
