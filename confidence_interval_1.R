library(dplyr)

p<-0.45
N<-100

X<-sample(c(1,0),N,replace=TRUE,prob=c(p,1-p))
X_hat<-mean(X)
SE_hat<-sqrt(X_hat*(1-X_hat)/N)

c(X_hat-2*SE_hat, X_hat+2*SE_hat) # ~95% CI

qnorm(0.975) # 1-(1-q)/2

# Monte carlo simulation
inside <- replicate(10000,{
  X<-sample(c(1,0),N,replace=TRUE,prob=c(p,1-p))
  X_hat<-mean(X)
  SE_hat<-sqrt(X_hat*(1-X_hat)/N)
  between(p,X_hat-2*SE_hat,X_hat+2*SE_hat)
})
mean(inside)