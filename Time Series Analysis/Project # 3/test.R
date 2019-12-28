install.packages('astsa')
library(astsa)
flow <- ts(scan("coloradoflow.txt"))
plot(flow, type="b")
diff12 = diff(flow,12)
acf(diff12, 48)
data <- arima.sim(order = c(1,0,1),seasonal = list(order=c(1,1,1), period=11), n=500)
help("arima.sim") 
library(forecast)

(fitf <- Arima(data_train$co2, order=c(3,0,1), seasonal=c(0,1,2),
              include.drift = T ))
checkresiduals(fitf, lag=36)

help(Arima)


logco2 <- log(data_train$co2)
cbind("H02 sales (million scripts)" = data_train$co2,
      "Log H02 sales"=logco2) %>%
  autoplot(facets=TRUE) + xlab("Year") + ylab("")

dataset1 <- cbind("norm" = data_train$co2,
                 "log"=logco2)) %>%
  as.data.frame()
  autoplot(facets=TRUE) + xlab("Year") + ylab("")
help("autoplot")
autoplot()
plot(datanew$norm, type = 'l')
plot(datanew$log, type = 'l')

datanew$time <- seq(length(datanew$norm))
p <- ggplot(datanew, aes(time, cty)) + geom_point()

# Use vars() to supply variables from the dataset:
p + facet_grid(rows = vars(drv))

logco2 <- log(data_train$co2)
co2 <- data_train$co2
cbind("H02 sales (million scripts)" = logco2,
      "Log H02 sales"=co2) %>%
  autoplot(facets=TRUE) + xlab("Year") + ylab("")
plot(logco2, type = 'l')
line(co2)
newdatset=gather(datanew, "type", "co2", 1:2)
p <- ggplot(newdatset, aes(time, co2)) + geom_line()

# Use vars() to supply variables from the dataset:
p + facet_grid(rows = vars(type), scales = 'free_y')


logco2 %>% diff(lag=12) %>%
  ggtsdisplay(xlab="Year",
              main="Seasonally differenced H02 scripts")

(fitnew <- Arima(co2, order=c(3,0,1),seasonal=list(order=c(1,1,4),period=12),
                 include.drift = T
              ))
checkresiduals(fitnew, lag=36)

#best#
(fitnewalter <- Arima(co2, order=c(3,1,1),seasonal=list(order=c(0,1,3),period=12)
                 #include.drift = TRUE
))
newauto=auto.arima(co2)
checkresiduals(fitnewalter, lag=36)
#best
help("accuracy")
auto.arima(co2)
accuracy(forecast(fitnewalter,h=20)$mean, data_test$co2)
accuracy(forecast(newauto,h=20)$mean, data_test$co2)

qqPlot(fitnewalter$residuals)



accuracy(fitnewalter,data_test$co2)
help(meanf)
fore

beer3 <- window(ausbeer, start=2008)
accuracy(beerfit1, beer3)
accuracy(beerfit2, beer3)
accuracy(beerfit3, beer3)



tsdisplay(residuals(fitnew), lag.max=45)
auto.arima(co2)


fitnew %>% forecast(h=250) %>% autoplot()


install.packages('car')

forecast(fitnewalter,h=25)
accuracy(forecast(fitnewalter,h=20)$mean, data_test$co2)
newdataset <- forecast(fitnewalter,h=20)
newdataset$mean
help("Arima")

arima.m<-arima.sim(list(order = c(0,0,12), ma = c(0.7,rep(0,10),0.9)), n = 200)
plot(arima.m)

analyse0 <- arima(co2, list(order = c(0,0,12, ma = c(0.7,rep(0,10),0.9))))

(newmodel <- arima(co2, order=c(1,0,3),seasonal=list(order=c(2,1,1),period=12),
                  xreg = data_train$time
))
my.tsdiag(newmodel$residuals)

library(car)
qqPlot(fitnew$residuals)
fitnew
