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
