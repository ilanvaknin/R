# 2 people having the same birthday in a group of people
# when are the chance larger than 50% ? 75 % ?

compute_prob<- function(n,b=10000){
  same_day <- replicate(b,{
    bdays <- sample(1:365,n,replace=TRUE)
    any(duplicated(bdays))
  })
  mean(same_day)
}

n <- seq(1,60)
prob<-sapply(n, compute_prob)

plot(n,prob)

abline(0.5,0)

exact_prob<-function(n){
  prob_unique<-seq(365,365-n+1)/365
  1-prod(prob_unique)
}
eprob<-sapply(n, exact_prob)
lines(n,eprob,col='red')
