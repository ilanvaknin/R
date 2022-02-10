library(dslabs)
library(lubridate)
options(digits = 3)    # 3 significant digits

data(brexit_polls)

brexit_polls %>% 
  filter(month(startdate)==4) %>% 
  select(startdate) %>%
  count()

?round_date

round_date(brexit_polls$enddate, unit='week')

brexit_polls %>%
  mutate(enddate_week=round_date(enddate, unit='week')) %>%
  filter(enddate_week=='2016-06-12') %>%
  count()

brexit_polls %>%
  mutate(enddate_weekday=weekdays(brexit_polls$enddate,abbreviate = T)) %>%
  count(enddate_weekday)  
  
data(movielens)

movielens %>% 
  select(timestamp) %>%
  mutate(timestamp_dt=as_datetime(timestamp)) %>%
  count(year(timestamp_dt)) %>%
  top_n(1)

movielens %>% 
  select(timestamp) %>%
  mutate(timestamp_dt=as_datetime(timestamp)) %>%
  count(hour(timestamp_dt)) %>%
  top_n(1)
  
  

