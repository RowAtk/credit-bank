dep_bal = bank.data[, c("deposit", "balance")]
dep_bal.cor = cor(dep_bal$balance, dep_bal$deposit)
library(corrplot)
corrplot(cor(dep_bal), method = "color")

corrplot(cor(dep_bal, method = "pearson"), method = "color", order = "AOE", tl.col = "black", tl.cex = 1, addCoef.col = "white")
         