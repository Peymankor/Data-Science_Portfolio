sim
matplot(acf(sim1), lty=1, type="l", col=rainbow(11))
acf(sim1)
simexp <- arima.sim(model = list(ar=c(0.8),ma=c(0.8,-0.5), order=c(1,0,2)), n = 500 ,sd=0.4)
sim32 <- arima.sim(model = list(ar=c(0.8),ma=c(0.8,-0.5), order=c(1,0,2)), n = 500 ,sd=0.4)
sim2 <- replicate(2,arima.sim(model = list(ar=c(0.8),ma=c(0.8,-0.5), order=c(1,0,2)), n = 500 ,sd=0.4))

newds <- acf(sim1,plot = FALSE)
newds
plot(newds)
exmdata <- acf(simexp,plot = FALSE)
plot(exmdata$lag,exmdata$acf, type = 'h')
new <- acf(sim1,plot = F)
plot(new)
newds$acf[]
newdf <- newds$acf
acf(sim1[,2])

d1 <- acf(sim1[,1],plot = F)

acf(sim1[,2])
sdd

install.packages('forecast')
library(forecast)
library(ggplot2)
Acf(wineind)
ggCcf(sim1[,1], sim1[,2])
acf
help("acf")
sim1acf <- acf(sim1, plot = F)
simacf <- sim1acf$acf
acf(sim1[,1])
simacdat1 <- simacf[,2,2]
dataset <- cbind(simacf[,1,1],simacf[,2,2],simacf[,3,3],simacf[,4,4],simacf[,5,5],simacf[,6,6],simacf[,7,7],simacf[,8,8],simacf[,9,9],simacf[,10,10])
matplot(dataset, lty=1, type="h", col=rainbow(11))

plot(0:16,simacdat, type = 'h')
lines(0:16,simacdat1, type = 'h', colur='blue')
simsin <- acf(sim1)
sim1acf$lag
data1 <- simacf[,2,2]
data2 <- acf(sim1[,2],plot = F)
datpacf <- pacf(sim1,plot = F)
sta <- apply(sim1,2,var)
