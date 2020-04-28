normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}
cohort2020.set.a$balance<-normalize(cohort2020.set.a$balance)
View(cohort2020.set.a)
