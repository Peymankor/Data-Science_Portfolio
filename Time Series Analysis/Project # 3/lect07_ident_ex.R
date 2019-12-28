## First showing a difference between 'ar' and 'arima' for estimating
ar2 <- arima.sim(model=list(ar=c(0.8, -0.6)), n=250)
plot(ar2)
acf(ar2)
pacf(ar2)
# Estimating:
arima(ar2,order= c(2,0,0), include.mean = FALSE)
ar(ar2, order.max = 2)

## Simulating an ARMA(1,1) model ####
arma11 <- arima.sim(model=list(ar=c(0.8), ma=0.6), n=250)
par(mfrow=c(4,1), mgp=c(2,0.7,0), mar=c(3,3,1.5,1))
plot(arma11)
acf(arma11)
pacf(arma11)
nlag <- 14
 pval <- sapply(1:nlag, function(i) Box.test(arma11, i, type = "Ljung-Box")$p.value)
plot(1L:nlag, pval, xlab = "lag", ylab = "p value", ylim = c(0,1), main = "p values for Ljung-Box statistic")
abline(h = 0.05, lty = 2, col = "blue")

my.tsdiag <- function(dat,   nlag = 14, ...){
  if(class(dat) == "Arima")
    dat <- dat$residuals
  oldpar <- par(mfrow=c(4,1), mgp=c(2,0.7,0), mar=c(3,3,1.5,1))
  on.exit(par(oldpar))
  plot(dat)
  acf(dat,...)
  pacf(dat,...)

  pval <- sapply(1:nlag, function(i) Box.test(dat, i, type = "Ljung-Box")$p.value)
  plot(1L:nlag, pval, xlab = "lag", ylab = "p value", ylim = c(0,1), main = "p values for Ljung-Box statistic")
  abline(h = 0.05, lty = 2, col = "blue")
  
}
my.tsdiag(arma11)

(fit.ar1 <- arima(arma11, order =c(1,0,0) ))
my.tsdiag(fit.ar1)

(fit.arma11 <- arima(arma11,order =c(1,0,1) ))
my.tsdiag(fit.arma11)


fit.ar2 <- arima(arma11,order =c(2,0,0) )
my.tsdiag(fit.ar2)
fit.ar2
fit.arma11

fit.arma11.css <- arima(arma11,order =c(1,0,1) , method="CSS")

fit.arma11.css
fit.arma11
fit.arma11.css.nm <- arima(arma11,order =c(1,0,1) , method="CSS", include.mean = FALSE)


## Simulating some data ...
arms1 <- arima.sim(model=list(ar=c(.4,-.3,.6), ma=0.41), n=250)
par(mfrow=c(1,1))
plot(arms1)

my.tsdiag(arms1)

## First model
fit1 <- arima(arms1,order=c(2,0,1))
fit1
my.tsdiag(fit1)

## Suggestions for extension
(fit2 <- arima(arms1,order=c(3,0,1)))
my.tsdiag(fit2)

## Now what does the object contain
names(fit2)
str(fit2)

## Likelihood ratio test
fit1$loglik - fit2$loglik
1 - pchisq(-2 * ( fit1$loglik - fit2$loglik ), df=1)
# Alternatively
pchisq(-2 * ( fit1$loglik - fit2$loglik ), df=1, lower.tail = FALSE)

## F-test
s1 <- sum(fit1$residuals^2)
s2 <- sum(fit2$residuals^2)
n1 <- 4
n2 <- 5
( f.stat <- (s1-s2)/(n2-n1) / (s2/(length(fit1$residuals)-n2)) )
pf(f.stat , df1 = n2 - n1, df2 = (length(fit1$residuals)-n2), lower.tail = FALSE)


###################
## Next example ####
dat <- read.csv("data.lecture7.csv")$x

my.tsdiag(dat)

analyse0 <- arima(dat, order=c(2,0,2), include.mean=FALSE, method="ML")
analyse0
my.tsdiag(analyse0$residuals)


(tmp <- arima(dat,order=c(2,0,4),include.mean=F))
my.tsdiag(tmp$residuals)
(analyse0 <- arima(dat,order=c(4,0,2),include.mean=F,method="ML"))
my.tsdiag(analyse0$residuals)


## Looking at distributional assumption
par(mfrow=c(2,1))
hist(analyse0$residuals,probability=T,col='blue')
curve(dnorm(x,sd=sqrt(analyse0$sigma2)), col=2, lwd=3, add = TRUE)
 
qqnorm(analyse0$residuals)
qqline(analyse0$residuals,col=2)
 
 
## Comparing with random numbers ...
par(mfrow=c(2,1))
ts.plot(analyse0$residuals)
ts.plot(ts(rnorm(length(analyse0$residuals))*sqrt(analyse0$sigma2)),
         ylab='Simulated residuals')
 
# sign test mean and sd:
N <- length(analyse0$residuals)
(N-1)/2
### sd:
sqrt((N-1)/4) 
### 95% interval:
(N-1)/2 +  c(-1,1) * 1.96 * sqrt(N-1/4) 
### test:
res <- analyse0$residuals
(N.sign.changes <- sum( res[-1] * res[-length(res)]<0 ))



### or:
binom.test(N.sign.changes, length(analyse0$residuals)-1)
## 0.5 is within the interval so OK 
  
### test in the acf, 14 lags (exchange the number of
### degrees of freedom according to your model:
## First extracting the ACF estimates
acfvals <- acf(analyse0$residuals,type="correlation",plot=FALSE)$acf[2:15]
## Calculating the test statistic
test.stat <- sum(acfvals^2) * (length(analyse0$residuals))
## Performing the test in the naive way ..
1 - pchisq(test.stat, length(acfvals)-length(analyse0$coef)) ## Numerical issue ... next line is better
pchisq(test.stat, length(acfvals)-length(analyse0$coef),lower.tail = FALSE) 


analyse0
cpgram(dat)
cpgram(analyse0$residuals)

## Testing a single parameter ... e.g. ma1
p <- length(analyse0$coef)
pt(0.2237/0.0612, df = N-p,lower.tail = FALSE) * 2

