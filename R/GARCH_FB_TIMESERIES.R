install.packages("quantmod")
install.packages("rugarch")

library(quantmod)
library(rugarch)

fb <-getSymbols("FB", auto.assign=F)
head(fb)
chartSeries(fb)

fbClose = fb$FB.Close
head(fbClose)

fb1 <- ugarchspec(variance.model=list(model="sGARCH", garchOrder=c(0,1)),
                    mean.model=list(armaOrder=c(1,1)),
                    distribution.model="std")

fbGarch <-ugarchfit(spec=fb1, data=fbClose)

fbPredict <- ugarchboot(fbGarch, method = "Full", 
	n.ahead = 10, n.bootpred = 2000)

plot(fbPredict)