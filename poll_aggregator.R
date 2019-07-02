library(dplyr)

d<-0.039
Ns<-c(1298,533,1342,897,774,254,812,324,1291,1056,2172,516)
p<-(d+1)/2

ci <- sapply(Ns,function(N){
  X<-sample(c(1,0), N, replace = TRUE, prob=(c(p,1-p)))
  X_hat<-mean(X)
  SE_hat<-sqrt(X_hat*(1-X_hat)/N)
  2*c(X_hat, X_hat - 2*SE_hat,X_hat+2*SE_hat)-1
}
)

polls <- data.frame(poll=1:ncol(ci),
                  t(ci),
                  sample_size=Ns
                    )

names(polls)<-c("poll","estimate","low","high","sample_size")


d_hat <- polls %>% 
  summarize(avg=sum(estimate*sample_size)/sum(sample_size)) %>%
  .$avg

p_hat <- (1+d_hat)/2

moe <- 2*1.96*sqrt(p_hat*(1-p_hat)/sum(polls$sample_size))
moe

round(d_hat*100,1)

# 4.1 +- 1.8% does not include 0 : it's not a tossup !

library(dslabs)
polls <- polls_us_election_2016 %>%
    filter(state=="U.S." & enddate >= "2016-10-31" & 
      (grade %in% c("A+","A","A-","B+") | is.na(grade))) %>%
  mutate(spread=rawpoll_clinton/100 - rawpoll_trump/100)

d_hat <- polls %>%
  summarize(d_hat=sum(spread*samplesize)/sum(samplesize)) %>%
  .$d_hat

p_hat <- (d_hat+1)/2

moe <- 1.96 * 2 * sqrt(p_hat*(1-p_hat)/sum(polls$samplesize))
moe

library(ggplot2)

polls %>%
  ggplot(aes(spread)) + 
  geom_histogram(color="black", binwidth = .01)

# not normal ! The theory is not quite working here

polls %>% group_by(pollster) %>% summarize(n())

polls %>% group_by(pollster) %>%
  filter(n()>=6)%>%
  ggplot(aes(pollster, spread))+
  geom_point()+
  theme(axis.text.x=element_text(angle=90,hjust = 1))

polls %>% group_by(pollster) %>%
  filter(n()>=6)%>%
  summarize(se=2*sqrt(p_hat*(1-p_hat)/median(samplesize)))

# keep the last poll for each pollster
one_poll_per_pollster <- polls %>% group_by(pollster) %>%
  filter(enddate==max(enddate)) %>%
  ungroup()

one_poll_per_pollster %>%
  ggplot(aes(spread))+geom_histogram(binwidth = .01)

sd(one_poll_per_pollster$spread)

results <- one_poll_per_pollster %>%
  summarize(avg=mean(spread), se=sd(spread)/sqrt(length(spread))) %>%
  mutate(start=avg-1.96*se, end = avg + 1.96*se)

round(results*100,1)

# Ex
# The vector of all male heights in our population `x` has already been loaded for you. You can examine the first six elements using `head`.
head(x)

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling
set.seed(1)

# Define `N` as the number of people measured
N <- 50

# Define `X` as a random sample from our population `x`
X <- sample(x, N, replace = TRUE)

# Define `se` as the standard error of the estimate. Print this value to the console.
se<-sd(X)/sqrt(N)
se


# Construct a 95% confidence interval for the population average based on our sample. Save the lower and then the upper confidence interval to a variable called `ci`.
ci<-c(mean(X)-qnorm(0.975)*se,mean(X)+qnorm(0.975)*se)

#Ex5
# Define `mu` as the population average
mu <- mean(x)

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling
set.seed(1)

# Define `N` as the number of people measured
N <- 50

# Define `B` as the number of times to run the model
B <- 10000

# Define an object `res` that contains a logical vector for simulated intervals that contain mu
res<-replicate(B,{
  X <- sample(x, N, replace = TRUE)
  se<-sd(X)/sqrt(N)
  interval<-c(mean(X)-qnorm(0.975)*se,mean(X)+qnorm(0.975)*se)
  between(mu,interval[1],interval[2])
})

# Calculate the proportion of results in `res` that include mu. Print this value to the console.
mean(res)

#Ex6
# Load the libraries and data you need for the following exercises
library(dslabs)
library(dplyr)
library(ggplot2)
data("polls_us_election_2016")

# These lines of code filter for the polls we want and calculate the spreads
polls <- polls_us_election_2016 %>% 
  filter(pollster %in% c("Rasmussen Reports/Pulse Opinion Research","The Times-Picayune/Lucid") &
           enddate >= "2016-10-15" &
           state == "U.S.") %>% 
  mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100) 

# Make a boxplot with points of the spread for each pollster
polls %>% ggplot(aes(pollster, spread)) +
  geom_boxplot()+
  geom_point()
