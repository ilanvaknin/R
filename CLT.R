loan <- 180000
n<-1000
B<-10000
p<-0.02
lost_per_foreclosure <- -200000
losts<-replicate(B,{
  fault<-sample(c(0,1),replace=TRUE,prob=c(1-p,p),n)
  sum(fault * lost_per_foreclosure)
})

library(tidyverse)

data.frame(loss_per_million=losts/10^6) %>% 
  ggplot(aes(loss_per_million)) +
  geom_histogram(binwidth = 0.6, col='black')

# CLT -> Because our losses are a sum of independant draws its distribution is approximately normal
# with expected value n*(ap+b(1-p))
# with standard error sqrt(n)*abs(a-b)*sqrt(p*(1-p))

n*(p*lost_per_foreclosure+(1-p)*0)

sqrt(n)*abs(lost_per_foreclosure)*sqrt(p*(1-p))

# Let's search for x so (p*lost_per_foreclosure+(1-p)*x)=0 (break even)
x<- -lost_per_foreclosure*p/(1-p)

#interest rate is approximatelly 2%
x/loan

# but break even means 50% chance loosing money !?!
# let's pick an interest rate with 1% chance of loosing
# Pr(S<0)=0.01
z <- qnorm(0.01)
l<-lost_per_foreclosure
x <- -l*( n*p - z*sqrt(n*p*(1-p)))/ ( n*(1-p) + z*sqrt(n*p*(1-p)))

#interest rate is approximatelly 3%
x/loan

#total expected profit
l*p+x*(1-p)

#monte carlo check
profit<-replicate(B,{
  draws<-sample(c(x,lost_per_foreclosure),replace=TRUE,prob=c(1-p,p),n)
  sum(draws)
})
mean(profit)
mean(profit<0)


