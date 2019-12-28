?arima.sim()
set.seed(5)
sim2 <- arima.sim(model = list(ar=0.6, order=c(1,0,0)), n = 500)
plot(sim2)
acf(sim2)
pacf(sim2)

rnorm
set.seed(5)
rnorm(5)
rnorm(5)
ts.sim <- arima.sim(list(order = c(1,0,2), ar = 0.8, ma=c(0.8,-0.5)), n = 200, sd=0.4)
plot(ts.sim)
acf(ts.sim)
pacf(ts.sim)

df <-data.frame(matrix(0,ncol = 11,nrow = 200))
for (i in 1:10) {
  df[,i] <- arima.sim(list(order = c(1,0,2), ar = 0.8, ma=c(0.8,-0.5)), n = 200, sd=0.4)
  df[,11] <- seq(1,200)
}
colnames(df) <- c("Realization #1","Realization #2","Realization #3","Realization #4","Realization #5","Realization #6","Realization #7","Realization #8",
                  "Realization #9","Realization #10","Time")
colnames(df)
library(tidyverse)

newdf <- df %>%
  gather("Realization", "Value",-Time)
head(newdf)
class(newdf)
sapply(newdf, class)

ggplot(newdf,aes(x=Time,y=Value, colour =Realization)) +
  geom_line(size=1)
seq(1,200)
