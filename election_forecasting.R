# Load the libraries and data
library(dplyr)
library(dslabs)
data("polls_us_election_2016")

# Create a table called `polls` that filters by  state, date, and reports the spread
polls <- polls_us_election_2016 %>% 
  filter(state != "U.S." & enddate >= "2016-10-31") %>% 
  mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100)

# Create an object called `cis` that has the columns indicated in the instructions
cis<-polls %>% mutate(X_hat=(spread+1)/2, se=2*sqrt(X_hat*(1-X_hat)/samplesize)
                      , lower=spread-qnorm(0.975)*se, upper=spread+qnorm(0.975)*se) %>%
  select(state, startdate, enddate, pollster, grade, spread, lower, upper)

# Add the actual results to the `cis` data set
add <- results_us_election_2016 %>% mutate(actual_spread = clinton/100 - trump/100) %>% select(state, actual_spread)

ci_data <- cis %>% mutate(state = as.character(state)) %>% left_join(add, by = "state")

# Create an object called `p_hits` that summarizes the proportion of confidence intervals that contain the actual value. Print this object to the console.
p_hits<-ci_data %>% mutate(hit=ifelse(actual_spread>=lower & actual_spread<=upper,TRUE,FALSE)) %>%
  summarize(proportions_hits=sum(hit)/n())

# The `cis` data have already been loaded for you
add <- results_us_election_2016 %>% mutate(actual_spread = clinton/100 - trump/100) %>% select(state, actual_spread)
ci_data <- cis %>% mutate(state = as.character(state)) %>% left_join(add, by = "state")

# Create an object called `p_hits` that summarizes the proportion of hits for each pollster that has at least 5 polls.
p_hits<-ci_data %>% mutate(hit=ifelse(actual_spread>=lower & actual_spread<=upper,TRUE,FALSE)) %>% 
  group_by(pollster) %>%
  filter(n()>=5) %>%
  summarize(proportion_hits=sum(hit)/n(), n=n(), grade=first(grade)) %>%
  arrange(desc(proportion_hits))

# The `cis` data have already been loaded for you
add <- results_us_election_2016 %>% mutate(actual_spread = clinton/100 - trump/100) %>% select(state, actual_spread)
ci_data <- cis %>% mutate(state = as.character(state)) %>% left_join(add, by = "state")

# Create an object called `p_hits` that summarizes the proportion of hits for each state that has more than 5 polls.
# The `cis` data have already been loaded for you
add <- results_us_election_2016 %>% mutate(actual_spread = clinton/100 - trump/100) %>% select(state, actual_spread)
ci_data <- cis %>% mutate(state = as.character(state)) %>% left_join(add, by = "state")

# Create an object called `p_hits` that summarizes the proportion of hits for each pollster that has at least 5 polls.
p_hits<-ci_data %>% mutate(hit=ifelse(actual_spread>=lower & actual_spread<=upper,TRUE,FALSE)) %>% 
  group_by(state) %>%
  filter(n()>=5) %>%
  summarize(proportion_hits=sum(hit)/n(), n=n()) %>%
  arrange(desc(proportion_hits))

# The `p_hits` data have already been loaded for you. Use the `head` function to examine it.
head(p_hits)

# Make a barplot of the proportion of hits for each state
p_hits %>% ggplot(aes(reorder(state,proportion_hits), proportion_hits))+
  geom_bar(stat="identity")+
  coord_flip()

# The `cis` data have already been loaded. Examine it using the `head` function.
head(cis)

# Create an object called `errors` that calculates the difference between the predicted and actual spread and indicates if the correct winner was predicted
cis <- cis %>% mutate(error=spread-actual_spread, hit=ifelse(spread*actual_spread>0,TRUE,FALSE))
errors<-cis

# Examine the last 6 rows of `errors`
tail(errors,6)

# Create an object called `errors` that calculates the difference between the predicted and actual spread and indicates if the correct winner was predicted
errors <- cis %>% mutate(error = spread - actual_spread, hit = sign(spread) == sign(actual_spread))

# Create an object called `p_hits` that summarizes the proportion of hits for each state that has more than 5 polls
p_hits <- errors %>%
  group_by(state) %>%
  filter(n()>5) %>%
  summarize(proportion_hits=mean(hit), n=n())

# Make a barplot of the proportion of hits for each state
p_hits %>% ggplot(aes(reorder(state,proportion_hits), proportion_hits))+
  geom_bar(stat = "identity")+
  coord_flip()

# The `errors` data have already been loaded. Examine them using the `head` function.
head(errors)

# Generate a histogram of the error
hist(errors$error)

# Calculate the median of the errors. Print this value to the console.
median(errors$error)

# The `errors` data have already been loaded. Examine them using the `head` function.
head(errors)

# Create a boxplot showing the errors by state for polls with grades B+ or higher
errors %>% filter(grade %in% c("A+","A","A-","B+")) %>% 
  ggplot(aes(reorder(state,error), error))+
  geom_boxplot()+
  geom_point()

# The `errors` data have already been loaded. Examine them using the `head` function.
head(errors)

# Create a boxplot showing the errors by state for states with at least 5 polls with grades B+ or higher
errors %>% filter(grade %in% c("A+","A","A-","B+")) %>%
  group_by(state) %>%
  filter(n()>=5) %>%
  ggplot(aes(reorder(state,error),error))+
  geom_boxplot()+
  geom_point()

# You see that the West (Washington, New Mexico, California) underestimated Hillary's performance, while the Midwest (Michigan, Pennsylvania, Wisconsin, Ohio, Missouri) overestimated it. In our simulation in we did not model this behavior since we added general bias, rather than a regional bias. Some pollsters are now modeling correlation between similar states and estimating this correlation from historical data. To learn more about this, you can learn about random effects and mixed models.