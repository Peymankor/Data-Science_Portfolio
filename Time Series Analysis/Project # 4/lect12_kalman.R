## Falling body example from last
# install.packages("MASS")
library(MASS)
## Initialising
set.seed(242)
z0 <- 10000
A <- matrix(c(1,0,1,1),nrow=2)
B <- matrix(c(-.5,-1),nrow=2)
C <- matrix(c(1,0),nrow=1)
Sigma1 <- matrix(c(2,.8,.8,1),nrow=2) #*1000
Sigma2 <- matrix(10000)
g <- 9.82; 
N <- 100
X <- matrix(nrow=2,ncol=N)
X[,1] <- c(z0,0)
Y <- numeric(N)
Y[1] <- C%*%X[,1]+sqrt(Sigma2) %*% rnorm(1)

## Simulating
for (I in 2:N){
  X[,I] <- A %*% X[,I-1,drop=FALSE] + B%*%g +
    mvrnorm(mu=rbind(0,0),Sigma=Sigma1)
    #chol(Sigma1) %*% matrix(rnorm(2),ncol=1)
  Y[I] <- C %*% X[,I] + sqrt(Sigma2) %*% rnorm(1)
}
Nhit <- min(which(X[1,]<0))-1
X <- X[,1:Nhit]
Y <- Y[1:Nhit]

par(mar=c(3,3,1,1), mgp=c(2, 0.7,0))
matplot(cbind(X[1,],Y),type="o",pch=c(NA,1),col=1:2)
plot(X[2,])

### It is time to start filtering ...
source("kalman.R") ## My Kalman filter - This file is not shared but you can do with the FKF package or similar
args(name = kalman)
## look at library("FKF)

## Here is the definition of the 'kalman' function that is used below.
function (Y, A, B = NULL, u = NULL, C, Sigma.1 = NULL, Sigma.2 = NULL, 
          debug = FALSE, V0 = Sigma.1, Xhat0 = NULL, n.ahead = 1, skip = 0, 
          verbose = FALSE) 
## And here follows a short description of each argument:
## Y      : Matrix with one observation per row. May be a vector if only one value
##          is observed at each time point.
## A, B, C, Sigma.1, Sigma.2 : Matrices as described in the definition of the Kalman
##          filter. 
## u      : Optional input to the system. One row per observation.
## V0     : Initial covariance of Sigma_xx_{1|0}
## Xhat0  : Initial estimate of the state X_{1|0}
## debug  : Ignore
## verbose: Ignore
## n.ahead: For making forecasts beyond the data
## skip   : Ignore

## Using optimal values:
Kr <- kalman(Y, A= A, B=B, u=matrix(g,length(Y),1), C=C, Sigma.1=Sigma1, Sigma.2=Sigma2, 
             V0=matrix(rep(0,4),ncol=2), Xhat0=rbind(1e4,0),n.ahead=1,verbose=TRUE)
str(Kr)
matplot(cbind(X[1,],Y),type="o",pch=c(NA,1),col=1:2,xlab="Time (s)", ylab="Altitude (m)")
matlines(Kr$pred[,1]+sqrt(Kr$Sigma.yy.pred[1,1,])%*%cbind(0,-1.96,1.96),col=3,lty=c(1,2,2))

## Using wrong start: h=6000
Kr2 <- kalman(Y, A= A, B=B, u=matrix(g,length(Y),1), C=C, Sigma.1=Sigma1, Sigma.2=Sigma2, 
              V0=matrix(rep(0,4),ncol=2), Xhat0=rbind(6e3,0),n.ahead=1,verbose=TRUE)
#str(Kr2)
#matplot(cbind(X[1,],Y),type="o",pch=c(NA,1),col=1:2,xlab="Time (s)", ylab="Altitude (m)")
matlines(Kr2$pred[,1]+sqrt(Kr2$Sigma.yy.pred[1,1,])%*%cbind(0,-1.96, 1.96),col=4,lty=c(1,2,2))

## Using wrong start: h=6000 but with uncertainty
Kr3 <- kalman(Y, A= A, B=B, u=matrix(g,length(Y),1), C=C, Sigma.1=Sigma1, Sigma.2=Sigma2, 
              V0=diag(c(1e5,0)), Xhat0=rbind(6e3,0),n.ahead=1,verbose=TRUE)
#str(Kr3)
#matplot(cbind(X[1,],Y),type="o",pch=c(NA,1),col=1:2,xlab="Time (s)", ylab="Altitude (m)")
matlines(Kr3$pred[,1]+sqrt(Kr3$Sigma.yy.pred[1,1,])%*%cbind(0,-1.96,1.96),col=6,lty=c(1,2,2))

###################################
## Handling missing  observations ####
Ypart <- Y
# Removing 32 observations
Ypart[sample(length(Y),39)] <- NA
Ypart
Krp <- kalman(Ypart, A= A, B=B, u=matrix(g,length(Y),1), C=C, Sigma.1=Sigma1, Sigma.2=Sigma2,
              V0=matrix(rep(0,4),ncol=2), Xhat0=rbind(1e4,0),n.ahead=1,verbose=TRUE)
str(Krp)
plot(Ypart, type="p",pch=c(1),col=2,xlab="Time (s)", ylab="Altitude (m)")
matlines(Krp$pred[,1]+sqrt(Krp$Sigma.yy.pred[1,1,])%*%cbind(0,-1.96,1.96),col=4,lty=c(1,2,2))
## Why is it this good!?!

## Try increasing Sigma.1 in the filter to blow up the uncertainty
Krp <- kalman(Ypart, A= A, B=B, u=matrix(g,length(Y),1), C=C, 
              Sigma.1=Sigma1*100, Sigma.2=Sigma2, V0=matrix(rep(0,4),ncol=2), 
              Xhat0=rbind(1e4,0),n.ahead=1,verbose=TRUE)
matlines(Krp$pred[,1]+sqrt(Krp$Sigma.yy.pred[1,1,])%*%cbind(0,-1.96,1.96),col=3,lty=c(1,2,2), lwd=2)

# Assuming an even larger uncertainty
plot(Ypart, type="p",pch=c(1),col=2,xlab="Time (s)", ylab="Altitude (m)", ylim=c(0,11500))
Krp2 <- kalman(Ypart, A= A, B=B, u=matrix(g,length(Y),1), C=C, 
              Sigma.1=Sigma1*10000, Sigma.2=Sigma2, V0=matrix(rep(0,4),ncol=2), 
              Xhat0=rbind(1e4,0),n.ahead=1,verbose=TRUE)
matlines(Krp2$pred[,1]+sqrt(Krp2$Sigma.yy.pred[1,1,])%*%cbind(0,-1.96,1.96),col=3,lty=c(1,2,2), lwd=2)


################################
## Which one is then better ...

# Calculating the log-likelihood
neps1 <- (Y[-1]-Kr$pred[-c(1, Nhit+1),1])^2 / Kr$Sigma.yy.pred[1,1,-c(1, Nhit+1)]
-0.5 * sum(neps1 + log(Kr$Sigma.yy.pred[1,1,-c(1, Nhit+1)]))

neps2 <- (Y[-1]-Kr2$pred[-c(1, Nhit+1),1])^2 / Kr2$Sigma.yy.pred[1,1,-c(1, Nhit+1)]
-0.5 * sum(neps2 + log(Kr2$Sigma.yy.pred[1,1,-c(1, Nhit+1)]))

neps3 <- (Y[-1]-Kr3$pred[-c(1, Nhit+1),1])^2 / Kr3$Sigma.yy.pred[1,1,-c(1, Nhit+1)]
-0.5 * sum(neps3 + log(Kr3$Sigma.yy.pred[1,1,-c(1, Nhit+1)]))

## Trying to optimize ...
## Objective function

my.obj <- function(par){
  Kro <- kalman(Y, A= A, B=B, u=matrix(g,length(Y),1), C=C, Sigma.1=Sigma1, Sigma.2=Sigma2,
                V0=diag(c(exp(par[2]),0)), Xhat0=rbind(exp(par[1]),0),n.ahead=1,verbose=TRUE)
  nepso <- (Y[-1]-Kro$pred[-c(1, Nhit+1),1])^2 / Kro$Sigma.yy.pred[1,1,-c(1, Nhit+1)]
  return(0.5 * sum(nepso + log(Kro$Sigma.yy.pred[1,1,-c(1, Nhit+1)])))
}

(Kmopt <- optim(log(c(9000,1000)),my.obj,method = "L-BFGS-B"))

exp(Kmopt$par)


## For illustration this is the same objective function except there is no log transformation
my.obj.2 <- function(par){
  
  Kro <- kalman(Y, A= A, B=B, u=matrix(g,length(Y),1), C=C, Sigma.1=Sigma1, Sigma.2=Sigma2, 
                V0=diag(c(par[2],0)), Xhat0=rbind(par[1],0),n.ahead=1,verbose=TRUE)
  nepso <- (Y[-1]-Kro$pred[-c(1, Nhit+1),1])^2 / Kro$Sigma.yy.pred[1,1,-c(1, Nhit+1)]
  return(0.5 * sum(nepso + log(Kro$Sigma.yy.pred[1,1,-c(1, Nhit+1)])))
}

(Kmopt.2 <- optim(c(9000,1000),my.obj.2,method = "L-BFGS-B"))
## The above line fails when the optimizer uses a negative variance!

## One option is to set lower bounds on parameters:
(Kmopt.2 <- optim(c(9000,1000),my.obj.2,method = "L-BFGS-B", lower=0))
## But the parameters differ by orders of magnitude ... so I recommend the log transform!
Kmopt.2$par ## Notice the second parameter ... 

## Additional example where also estimating the gravitation:


my.obj3 <- function(par){
  
  Kro <- kalman(Y, A= A, B=B, u=matrix(exp(par[3]),length(Y),1), C=C, Sigma.1=Sigma1, 
                Sigma.2=Sigma2, V0=diag(c(exp(par[2]),0)), Xhat0=rbind(exp(par[1]),0),n.ahead=1,verbose=TRUE)
  nepso <- (Y[-1]-Kro$pred[-c(1, Nhit+1),1])^2 / Kro$Sigma.yy.pred[1,1,-c(1, Nhit+1)]
  return(0.5 * sum(nepso + log(Kro$Sigma.yy.pred[1,1,-c(1, Nhit+1)])))
}

(Kmopt3 <- optim(log(c(9000, 1000, 9)),my.obj3,method = "L-BFGS-B"))

exp(Kmopt3$par)


## Using a numerical estimate of the Hessian as estimate of uncertainty.
## See Eq. 3.25 p.35
#install.packages("numDeriv")
library(numDeriv)

sigmaHat2 <- Kmopt$value/(length(Y)-1)
(VarTheta <- 2 * sigmaHat2 * solve(hessian(func = my.obj, x= Kmopt$par)) )
(SdTheta <- sqrt(diag(VarTheta)) )

(confInt <- cbind(Est= Kmopt$par, low = Kmopt$par - 1.96*SdTheta, high= Kmopt$par + 1.96*SdTheta))
exp(confInt)
## Conclusion: The initial height is well defined but the initial variance is not.


Kmopt.2$par
sigmaHat2 <- Kmopt.2$value/(length(Y)-1)
(VarTheta <- 2*sigmaHat2 * solve(hessian(func = my.obj.2, x= Kmopt.2$par)) )
(SdTheta <- sqrt(diag(VarTheta)) )

(confInt <- cbind(Est= Kmopt.2$par, low = Kmopt.2$par - 1.96*SdTheta, high= Kmopt.2$par + 1.96*SdTheta))
## On both scales (my.obj and my.obj.2) the uncertainty on the initial height is about the same
## However, for the covariance the confidence interval includes 50% negative values for the 
## initial variance - which is not meaningful.


#" What if using data with missing observations

my.obj.part <- function(par){
  Kro <- kalman(Ypart, A= A, B=B, u=matrix(g,length(Ypart),1), C=C, Sigma.1=Sigma1, Sigma.2=Sigma2,
                V0=diag(c(exp(par[2]),0)), Xhat0=rbind(exp(par[1]),0),n.ahead=1,verbose=TRUE)
  nepso <- (Ypart[-1]-Kro$pred[-c(1, Nhit+1),1])^2 / Kro$Sigma.yy.pred[1,1,-c(1, Nhit+1)]
  return(0.5 * sum(nepso + log(Kro$Sigma.yy.pred[1,1,-c(1, Nhit+1)]), na.rm = TRUE))
}

(Kmopt.part <- optim(log(c(9000,1000)),my.obj.part,method = "L-BFGS-B"))

exp(Kmopt.part$par)
sigmaHat2 <- Kmopt.part$value/(sum(!is.na(Ypart))-1)
(VarTheta <- 2 * sigmaHat2 * solve(hessian(func = my.obj.part, x= Kmopt.part$par)) )
(SdTheta <- sqrt(diag(VarTheta)) )

(confInt <- cbind(Est= Kmopt.part$par, low = Kmopt.part$par - 1.96*SdTheta, high= Kmopt.part$par + 1.96*SdTheta))
exp(confInt)
