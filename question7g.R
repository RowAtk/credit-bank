credit_risk <- bank.data %>% filter(bank.data$housing_n == 1 & bank.data$loan_n == 1 & bank.data$balance >= 500000)
View(credit_risk)

#having a house is seen as an asset. so even in the person is deemed low risk there is still a possiblity that something can go
#badly. so knowing they have assets makes it easier to issue them a loan

#having no loan also reduces risks. it can be argued that having a loan can show that they have the ability to payback but we don't
#have enough data to determing that. arguing from no loan we can say that it reduces the chances as the individual would not
#have multiple loans to deal with.

#balance gives a representation of the current standing of the individual and gives an idea of the income they receive and how
#they handle their money.
