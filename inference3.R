# Define `p` as a proportion of Democratic voters to simulate
p <- 0.45

# Define `N` as the sample size
N <- 100

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling
set.seed(1)

# Define `X` as a random sample of `N` voters with a probability of picking a Democrat ('1') equal to `p`
X<-sample(c(1,0),N,replace=TRUE,prob=c(0.45,0.55))
X_bar<-mean(X)
sqrt(X_bar*(1-X_bar)/N)