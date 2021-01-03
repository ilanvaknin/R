library(tidyverse)
library(dslabs)
library(Lahman)


# stratify by HR
dat <- Teams %>% filter(yearID %in% 1961:2001) %>%
  mutate(HR = round(HR/G, 1), 
         BB = BB/G,
         R = R/G) %>%
  select(HR, BB, R) %>%
  filter(HR >= 0.4 & HR<=1.2)


# calculate slope of regression lines to predict runs by BB in different HR strata
dat %>%  
  group_by(HR) %>%
  summarize(slope = cor(BB,R)*sd(R)/sd(BB))

# use lm to get estimated slopes - lm does not work with grouped tibbles
# lm ignore the group_by ! --> lm is not part of the tidyverse
dat %>%  
  group_by(HR) %>%
  lm(R ~ BB, data = .) %>%
  .$coef

# inspect a grouped tibble
dat %>% group_by(HR) %>% head()
dat %>% group_by(HR) %>% class()

########################################
# Tibbles: Differences from Data Frames
########################################
# 1. Tibbles are more readable than data frames.
Teams # --> not readable
as_tibble(Teams) # --> more readable

# 2. If you subset a data frame, you may not get a data frame. If you subset a tibble, you always get a tibble.
# 3. Tibbles can hold more complex objects such as lists or functions.
# 4. Tibbles can be grouped.

########################################
# Tibbles: function do()
########################################
# The do() function serves as a bridge between R functions, such as lm(), and the tidyverse.
# We have to specify a column when using the do() function, otherwise we will get an error.
# If the data frame being returned has more than one row, the rows will be concatenated appropriately.
# use do to fit a regression line to each HR stratum
dat %>%  
  group_by(HR) %>%
  do(fit = lm(R ~ BB, data = .))

# using do without a column name gives an error
dat %>%
  group_by(HR) %>%
  do(lm(R ~ BB, data = .))

# define a function to extract slope from lm
get_slope <- function(data){
  fit <- lm(R ~ BB, data = data)
  data.frame(slope = fit$coefficients[2], 
             se = summary(fit)$coefficient[2,2])
}

# return the desired data frame
dat %>%  
  group_by(HR) %>%
  do(get_slope(.))

# data frames with multiple rows will be concatenated appropriately
get_lse <- function(data){
  fit <- lm(R ~ BB, data = data)
  data.frame(term = names(fit$coefficients),
             estimate = fit$coefficients, 
             se = summary(fit)$coefficient[,2])
}

dat %>%  
  group_by(HR) %>%
  do(get_lse(.))

########################################
# Tibbles: Broom package
########################################
# The broom package has three main functions, 
# all of which extract information from the object returned by lm and return it in a tidyverse friendly data frame.
# The tidy() function returns estimates and related information as a data frame.
# The functions glance() and augment() relate to model specific and observation specific outcomes respectively.

# use tidy to return lm estimates and related information as a data frame
library(broom)
fit <- lm(R ~ BB, data = dat)
tidy(fit)

# add confidence intervals with tidy
tidy(fit, conf.int = TRUE)

# pipeline with lm, do, tidy
dat %>%  
  group_by(HR) %>%
  do(tidy(lm(R ~ BB, data = .), conf.int = TRUE)) %>%
  filter(term == "BB") %>%
  select(HR, estimate, conf.low, conf.high)

# make ggplots
dat %>%  
  group_by(HR) %>%
  do(tidy(lm(R ~ BB, data = .), conf.int = TRUE)) %>%
  filter(term == "BB") %>%
  select(HR, estimate, conf.low, conf.high) %>%
  ggplot(aes(HR, y = estimate, ymin = conf.low, ymax = conf.high)) +
  geom_errorbar() +
  geom_point()

# inspect with glance
glance(fit)

######################################
# Assessments
######################################
get_slope <- function(data) {
  fit <- lm(R ~ BB, data = data)
  sum.fit <- summary(fit)
  
  data.frame(slope = sum.fit$coefficients[2, "Estimate"], 
             se = sum.fit$coefficients[2, "Std. Error"],
             pvalue = sum.fit$coefficients[2, "Pr(>|t|)"])
}

dat %>% 
  group_by(HR) %>% 
  do(get_slope(.))

# Question 7
dat <- Teams %>% filter(yearID %in% 1961:2001) %>%
  mutate(HR = HR/G,
         R = R/G) %>%
  select(lgID, HR, BB, R) 

dat %>% 
  group_by(lgID) %>% 
  do(tidy(lm(R ~ HR, data = .), conf.int = T)) %>% 
  filter(term == "HR") 

# Question 8
library(tidyverse)
library(HistData)
data("GaltonFamilies")
set.seed(1) # if you are using R 3.5 or earlier
set.seed(1, sample.kind = "Rounding") # if you are using R 3.6 or later
galton <- GaltonFamilies %>%
  group_by(family, gender) %>%
  sample_n(1) %>%
  ungroup() %>% 
  gather(parent, parentHeight, father:mother) %>%
  mutate(child = ifelse(gender == "female", "daughter", "son")) %>%
  unite(pair, c("parent", "child"))

galton %>% group_by(pair) %>% count()

galton %>% group_by(pair) %>% summarize(r = cor(childHeight, parentHeight))

get_slope <- function(data){
  fit <- lm(childHeight ~ parentHeight, data = data)
  data.frame(slope = fit$coefficients[2], 
             se = summary(fit)$coefficient[2,2])
}

galton %>% group_by(pair) %>% do(get_slope(.))

galton %>% group_by(pair) %>% do(tidy(lm(childHeight ~ parentHeight, .), conf.int = TRUE)) %>%
  filter(term=='parentHeight')

# make ggplots
galton %>%  
  group_by(pair) %>%
  do(tidy(lm(childHeight ~ parentHeight, data = .), conf.int = TRUE)) %>%
  filter(term == "parentHeight") %>%
  select(pair, estimate, conf.low, conf.high) %>%
  ggplot(aes(pair, y = estimate, ymin = conf.low, ymax = conf.high)) +
  geom_errorbar() +
  geom_point()

# --> All sets of parent-child heights are significantly correlated at a p-value cut off of .05

# All of the confidence intervals overlap each other.
# The confidence intervals involving mothers' heights are larger than the confidence intervals involving fathers' heights.

# Because all of the confidence intervals overlap each other:
### The data are consistent with inheritance of height being independent of the child's gender
### The data are consistent with inheritance of height being independent of the parent's gender.






