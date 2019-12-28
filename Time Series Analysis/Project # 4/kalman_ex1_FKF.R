## Kalman filter example using the FKF package
##
## Lasse Engbo Christiansen, 2018

## Simulating a falling body:
## We start at 10000 m and drop the body.
z0 <- 10000
A <- matrix(c(1,0,1,1),nrow=2)
B <- matrix(c(-.5,-1),nrow=2)
C <- matrix(c(1,0),nrow=1)
Sigma1 <- 100*matrix(c(2,.8,.8,1),nrow=2)
Sigma2 <- matrix(10000)

g <- 9.82 ## m/s2
N <- 100
X <- matrix(nrow=2,ncol=N)
X[,1] <- c(z0,0)
Y <- numeric(N)
Y[1] <- C%*%X[,1]+sqrt(Sigma2) %*% rnorm(1)
## Simulation
for (I in 2:N){
    X[,I] <- A%*%X[,I-1,drop=FALSE]+B%*%g+chol(Sigma1) %*% matrix(rnorm(2),ncol=1)
    Y[I] <- C%*%X[,I]+sqrt(Sigma2) %*% rnorm(1)
}

Nhit <- min(which(X[1,]<0))-1
X <- X[,1:Nhit]
Y <- Y[1:Nhit]

## Plotting our observations
plot(X[1,])
plot(X[2,])
plot(Y)

## Loading library
# install.packages("FKF")
library("FKF")
## Running the Kalman filter with the parameters and initial values used for the simulation
kf1 <- fkf(a0=c(10000,0), P0 = diag(0,2),dt = B%*%g, Tt = A, ct=0, Zt = C, HHt = Sigma1, GGt = Sigma2, yt = matrix(Y,nrow=1))
str(kf1)

plot(kf1$at[1,])
plot(kf1$at[2,])
plot(sqrt(kf1$Pt[1,1,]))
plot(sqrt(kf1$Pt[2,2,]))
plot(sqrt(kf1$Ptt[1,1,]))


plot(Y)
kf1$logLik
with(kf1, matlines((at[1,]) + cbind(0,-1.96*sqrt(Pt[1,1,]),1.96*sqrt(Pt[1,1,])),type="l", lty=c(1,2,2), col=2))

## Running the Kalman filter with wrong initial height
kf1w0 <- fkf(a0=c(6000,0), P0 = diag(0,2),dt = B%*%g, Tt = A, ct=0, Zt = C, HHt = Sigma1, GGt = Sigma2, yt = matrix(Y,nrow=1))
kf1w0$logLik
with(kf1w0, matlines((at[1,]) + cbind(0,-1.96*sqrt(Pt[1,1,]),1.96*sqrt(Pt[1,1,])),type="l", lty=c(1,2,2), col=3))

## Running the Kalman filter with wrong initial height and increased initial uncertainty
kf1vl <- fkf(a0=c(6000,0), P0 = diag(100000,2),dt = B%*%g, Tt = A, ct=0, Zt = C, HHt = Sigma1, GGt = Sigma2, yt = matrix(Y,nrow=1))
kf1vl$logLik
with(kf1vl, matlines((at[1,]) + cbind(0,-1.96*sqrt(Pt[1,1,]),1.96*sqrt(Pt[1,1,])),type="l", lty=c(1,2,2), col=4))

## Plotting the filtered velocities
with(kf1, matplot((at[2,]) + cbind(0,-1.96*sqrt(Pt[2,2,]),1.96*sqrt(Pt[2,2,])),type="l", lty=c(1,2,2), col=2))

## What if some observations were missing:
length(Y)
Ymis <- Y
Ymis[sample(Nhit,36)] <- NA
plot(Ymis, ylim=c(0,12000))

kf1mis <- fkf(a0=c(10000,0), P0 = diag(0,2),dt = B%*%g, Tt = A, ct=0, Zt = C, HHt = Sigma1*100, GGt = Sigma2, yt = matrix(Ymis,nrow=1))
with(kf1mis, matlines((at[1,]) + cbind(0,-1.96*sqrt(Pt[1,1,]),1.96*sqrt(Pt[1,1,])),type="l", lty=c(1,2,2), col=3, lwd=2))

