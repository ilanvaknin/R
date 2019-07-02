install.packages("dplyr")
library("dplyr")

my_states <- murders %>% mutate(rate=total/population*100000, rank=rank(-population)) %>% filter(region %in% c("Northeast","West") & rate<1) %>% select(state, rate, rank)