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
     
     