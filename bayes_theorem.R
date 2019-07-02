# test accuracy 99%

# suppose we select a random person, and his test is positive
# what is the probability that he has the disease ?
# Pr( D = 1 | + ) ?

# dicease overall rate : 1 in 3900 (cystic fibrosis)
# Pr(D = 1) = 0.00025

# despite the test having 99% accuracy,
# the probability of having the disease
# given a positive test is only 2%

# monte carlo check:
prev<- 0.00025
N<-100000
outcome <- sample(c("disease","healthy"),N, replace=TRUE, prob=c(prev,1-prev))

N_D <- sum(outcome=="disease")
N_D

N_H <- sum(outcome == "healthy")
N_H

accuracy <- 0.99
test <- vector("character",N) 
test[outcome=="disease"]<-sample(c("+","-"), N_D, replace=TRUE, prob=c(accuracy,1-accuracy))
test[outcome=="healthy"]<-sample(c("-","+"), N_H, replace=TRUE, prob=c(accuracy,1-accuracy))

table(outcome, test)
