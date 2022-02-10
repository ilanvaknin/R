# what is the probability that at least 2 students have 
# the same birthday in a class of 50 ?

b<-10000
results <- replicate(b,{
    bdays <- sample(1:365,50,replace=TRUE)
    any(duplicated(bdays))
})
mean(results)


