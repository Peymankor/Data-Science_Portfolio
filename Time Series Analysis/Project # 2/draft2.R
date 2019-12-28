set.seed(123)
phi2 <- -0.52
sim1 <- arima.sim(model = list(ar=c(1.5,phi2), order=c(2,0,0)), n = 100, sd=0.1)
plot(sim1)
acf(sim1)
pacf(sim1)
(arima300 <- arima(sim1, order = c(2,0,0), method = "ML", include.mean = FALSE)) # May give a warning due to unit root
c(1, -coef(arima300))
rev(c(1, -coef(arima300)))
## Finally, we can find the roots from the two models
polyroot(rev(c(1, -coef(arima300))))
c(1,-1.5,0.56)
help("polyroot")
#########################################################
estphi2 <- function(phi2,sd) {
  phi2 <- phi2
  sd <- sd
  estimatephi2 <- rep(0,100) 
  for (i in 1:100){
    sim1 <- arima.sim(model = list(ar=c(1.5,phi2), order=c(2,0,0)), n = 300, sd=sd)
    arima200 <- arima(sim1, order = c(2,0,0)) # May give a warning due to unit root
    estimatephi2[i] <- arima200$coef[2]
  }
  return(estimatephi2)
}

Hist_Proces1 <- estphi2(-0.52,0.1)
hist(Hist_Proces1, breaks = 10)
abline(v=-0.5)

Hist_Proces2 <- estphi2(-0.52,5)
hist(Hist_Proces2, breaks = 10)

Hist_Proces3 <- estphi2(-0.98,0.1)
hist(Hist_Proces3, breaks = 10)

Hist_Proces4 <- estphi2(-0.98,5)
hist(Hist_Proces4, breaks = 10)

help(hist)
x <- rnorm(100)


plot(1:10, (-4:5)^2, main="Parabola Points", xlab="xlab")
mtext("10 of them")
