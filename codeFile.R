rm(list = ls())

#1
sch.data <- read.csv(file = file.choose(), stringsAsFactors = TRUE, header = TRUE, sep = ",")
View(sch.data)
str(sch.data)

#2
mean(sch.data$Mavg, na.rm = T)
summary(sch.data)
hist(sch.data$OverallAvg)

#3
sch.data$ID = NULL

#4
str(sch.data$Eavg)
summary(sch.data$Eavg)
levels(sch.data$Eavg)
temp <- as.numeric(as.character(sch.data$Eavg))
View(data.frame(old_eavg=sch.data$Eavg, temp_eavg=temp))
sch.data$Eavg <- temp
sch.data$Eavg[is.na(sch.data$Eavg)] <- mean(sch.data$Eavg, na.rm = T)

#5
summary(sch.data$Mavg)
sch.data[is.na(sch.data$Mavg), "Mavg"] <- median(sch.data$Mavg, na.rm = T)
