N <- seq(100, 5000, len = 100)
p <- 0.5
se <- sqrt(p*(1-p)/N)

plot(N,se)
abline(h=0.01)

errors<-replicate(10000,{
  X<-sample(c(1,0),N,replace=TRUE,prob=c(0.45,0.55))
  X_bar<-mean(X)
  X_bar-p
})

