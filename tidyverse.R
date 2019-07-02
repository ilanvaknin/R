library(dslabs)
library(tidyverse)

data("heights")

heights %>% filter(sex=="Male") %>% summarize(average=mean(height), standard=sd(height))

data("murders")

murder_rate <- murders %>% summarize(murder_rate = sum(total) / sum(population)*100000 ) 

class(murder_rate)

murders %>% 
  summarize(murder_rate = sum(total) / sum(population)*100000 ) %>% 
  .$murder_rate

murders %>%
  group_by(region) %>%
  summarize(rate=sum(total)/sum(population)*100000)
  
  
murders %>% 
  summarize(rate=sum(total)/sum(population)*100000)
