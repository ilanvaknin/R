b<-10^seq(1,5,len=100)

compute_prob<- function(b,n=22){
  same_day <- replicate(b,{
    bdays <- sample(1:365,n,replace=TRUE)
    any(duplicated(bdays))
  })
  mean(same_day)
}

prob<-sapply(b, compute_prob)

plot(log10(b), prob, type='l')