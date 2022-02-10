# Calculate the probability of seeing t-distributed random variables
# being more than 2 standard deviation away from the mean
# in absolute value when 'df = 3'.
1-pt(2,df=3)+pt(-2,df=3)

# Generate a vector 'df' that contains a sequence of numbers from 3 to 50
df<-seq(3,50,1)

# Make a function called 'pt_func' that calculates the probability that a value is more than |2| for any degrees of freedom 
pt_func<-function(df){
  1-pt(2,df)+pt(-2,df)
}

# Generate a vector 'probs' that uses the `pt_func` function to calculate the probabilities
probs<-sapply(df, pt_func)

# Plot 'df' on the x-axis and 'probs' on the y-axis
plot(df,probs)

# Load the neccessary libraries and data
library(dslabs)
library(dplyr)
data(heights)

# Use the sample code to generate 'x', a vector of male heights
x <- heights %>% filter(sex == "Male") %>%
  .$height

# Create variables for the mean height 'mu', the sample size 'N', and the number of times the simulation should run 'B'
mu <- mean(x)
N <- 15
B <- 10000

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling
set.seed(1)

# Generate a logical vector 'res' that contains the results of the simulations
res<-replicate(B,{
  Y<-sample(x,N, replace=TRUE)
  interval<-mean(Y)+c(-qnorm(0.975),qnorm(0.975))*sd(Y)/sqrt(N)
  between(mu,interval[1],interval[2])
})

# Calculate the proportion of times the simulation produced values within the 95% confidence interval. Print this value to the console.
mean(res)

# The vector of filtered heights 'x' has already been loaded for you. Calculate the mean.
mu <- mean(x)

# Use the same sampling parameters as in the previous exercise.
set.seed(1)
N <- 15
B <- 10000

# Generate a logical vector 'res' that contains the results of the simulations using the t-distribution
res<-replicate(B,{
  Y<-sample(x,N, replace=TRUE)
  interval<-mean(Y)+c(-qt(0.975,df=N-1),qt(0.975,df=N-1))*sd(Y)/sqrt(N)
  between(mu,interval[1],interval[2])
})

# Calculate the proportion of times the simulation produced values within the 95% confidence interval. Print this value to the console.
mean(res)

#Remember that we saw previously that the t-distribution performs similarly to the normal distribution when sample sizes 30 or larger.

