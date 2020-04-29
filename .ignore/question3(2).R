hist(sch.data$age)
boxplot(sch.data$age)

library(classInt)

ages = sch.data$age

# frequency
f <- classIntervals(ages, 4, style = 'quantile')

# width
w <- classIntervals(ages, 4, style = 'equal')

copy.data = sch.data
copy.data$age = f
View(data.frame(old_age=sch.data$age, new_age=copy.data$age))
