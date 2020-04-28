# equal width binning
bins = 9
age.max = max(sch.data$age)
age.min = min(sch.data$age)
age.newmax = age.max + bins
width = (age.newmax - age.min) / bins
age.temp = cut(
  sch.data$age, 
  breaks = seq(age.min, age.newmax, width), 
  labels = c(
    "new adults",
    "very young",
    "young",
    "early middle age",
    "middle age",
    "late middle age",
    "old",
    "older",
    "elderly"),
  right = FALSE)
summary(age.temp)     

View(data.frame(old=sch.data$age, new=age.temp))
sch.data$age = age.temp

