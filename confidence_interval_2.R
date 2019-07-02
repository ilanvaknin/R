library(dslabs)
data("polls_us_election_2016")

polls <- filter(polls_us_election_2016,enddate>='2016-10-31',state=='U.S.')

nrow(polls)

N<-polls[1,"samplesize"]

X_hat<-polls[1,"rawpoll_clinton"]/100
X_hat

SE_hat<-sqrt(X_hat*(1-X_hat)/N)
SE_hat

ci<-c(X_hat-qnorm(0.975)*SE_hat,X_hat+qnorm(0.975)*SE_hat)

pollster_results<- polls %>% 
  mutate(X_hat=rawpoll_clinton/100
         , SE_hat=sqrt(X_hat*(1-X_hat)/samplesize)
         , lower=X_hat-qnorm(0.975)*SE_hat
         , upper=X_hat+qnorm(0.975)*SE_hat) %>% 
  select(c('pollster','enddate','X_hat','SE_hat','lower','upper'))

p<-0.482

avg_hit <- pollster_results %>%
  mutate(hit=p>=lower&p<=upper) %>%
  summarize(mean(hit))

# Confidence interval of the spread
# Add a statement to this line of code that will add a new column named `d_hat` to `polls`. The new column should contain the difference in the proportion of voters.
polls <- polls_us_election_2016 %>% filter(enddate >= "2016-10-31" & state == "U.S.")  %>%
  mutate(d_hat = rawpoll_clinton/100 - rawpoll_trump/100)

# Assign the sample size of the first poll in `polls` to a variable called `N`. Print this value to the console.
N <- polls$samplesize[1]

# For the difference `d_hat` of the first poll in `polls` to a variable called `d_hat`. Print this value to the console.
d_hat <- polls$d_hat[1]
d_hat

# Assign proportion of votes for Clinton to the variable `X_hat`.
X_hat <- (d_hat+1)/2

# Calculate the standard error of the spread and save it to a variable called `se_hat`. Print this value to the console.
se_hat <- 2*sqrt(X_hat*(1-X_hat)/N)
se_hat

# Use `qnorm` to calculate the 95% confidence interval for the difference in the proportions of voters. Save the lower and then the upper confidence interval to a variable called `ci`.
ci <- c(d_hat - qnorm(0.975)*se_hat, d_hat + qnorm(0.975)*se_hat)

# Ex 6
pollster_results <- polls %>% 
  mutate(X_hat=(d_hat+1)/2
         ,se_hat=2*sqrt(X_hat*(1-X_hat)/samplesize)
         ,lower=d_hat - qnorm(0.975)*se_hat
         ,upper=d_hat + qnorm(0.975)*se_hat
  ) %>%
  select(c('pollster','enddate','d_hat','se_hat','lower','upper'))

# Add variable called `error` to the object `polls` that contains the difference between d_hat and the actual difference on election day. Then make a plot of the error stratified by pollster.
polls %>% mutate(errors=d_hat-0.021) %>%
  ggplot(aes(x = pollster, y = errors)) +
  geom_point() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# Add variable called `error` to the object `polls` that contains the difference between d_hat and the actual difference on election day. Then make a plot of the error stratified by pollster, but only for pollsters who took 5 or more polls.
polls %>% mutate(errors=d_hat-0.021) %>%
  group_by(pollster) %>%
  filter(n() >= 5) %>%
  ggplot(aes(x = pollster, y = errors)) +
  geom_point() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
  
  

