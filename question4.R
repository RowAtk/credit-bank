# deposit normalization
deposit.min <- min(bank.data$deposit)
deposit.max <- max(bank.data$deposit)
deposit.norm <- ((bank.data[, "deposit"] - deposit.min) / (deposit.max - deposit.min)) * ((100 - 1) + 1)
deposit.norm <- round(deposit.norm, digits = 2)
summary(deposit.norm)
bank.data$deposit <- deposit.norm

# balance normalization
balance.min <- min(bank.data$balance)
balance.max <- max(bank.data$balance)
balance.norm <- ((bank.data[, "balance"] - balance.min) / (balance.max - balance.min)) * ((100 - 1) + 1)
balance.norm <- round(balance.norm, digits = 2)
summary(balance.norm)
bank.data$balance <- balance.norm

#results = data.frame(old=bank.data$balance, new=balance.norm)
#View(results[results$old == min(results$old), ])
