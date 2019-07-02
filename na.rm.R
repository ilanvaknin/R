library(dplyr)
library(NHANES)
data(NHANES) 


tab <- NHANES %>% filter(AgeDecade == " 20-29" & Gender=="female")

NHANES %>% group_by(AgeDecade) %>%
  summarize(average=mean(BPSysAve,na.rm=TRUE), standard_deviation=sd(BPSysAve,na.rm=TRUE))