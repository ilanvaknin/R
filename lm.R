library(tidyverse)
library(broom)
library(Lahman)
Teams_small <- Teams %>% 
  filter(yearID %in% 1961:2001) %>% 
  mutate(avg_attendance = attendance/G, R=R/G, HR=HR/G)

summary(Teams_small)

Teams_small %>% do(tidy(lm(avg_attendance ~ R, data=.)))

Teams_small %>% do(tidy(lm(avg_attendance ~ HR, data=.)))

Teams_small %>% do(tidy(lm(avg_attendance ~ W, data=.)))

Teams_small %>% do(tidy(lm(avg_attendance ~ yearID, data=.)))

cor(Teams_small$W, Teams_small$R)

cor(Teams_small$W, Teams_small$HR)

Teams_small %>% mutate(W=round(W/10)) %>%
  group_by(W) %>%
  filter(W %in% 5:10 & n()>=20) %>%
  do(tidy(lm(avg_attendance ~ R,data=.), conf.int = TRUE)) %>%
  filter(term=='R')

Teams_small %>% mutate(W=round(W/10)) %>%
  group_by(W) %>%
  filter(W %in% 5:10 & n()>=20) %>%
  do(tidy(lm(avg_attendance ~ HR,data=.), conf.int = TRUE)) %>%
  filter(term=='HR') 

Teams_small %>% mutate(W=round(W/10)) %>%
  group_by(W) %>%
  filter(W %in% 5:10 & n()>=20) %>%
  do(tidy(lm(avg_attendance ~ R,data=.), conf.int = TRUE)) %>%
  filter(term=='R') %>%
  select(W, estimate, conf.low, conf.high) %>%
  ggplot(aes(W, y = estimate, ymin = conf.low, ymax = conf.high)) +
  geom_errorbar() +
  geom_point()

Teams_small %>% mutate(W=round(W/10)) %>%
  group_by(W) %>%
  filter(W %in% 5:10 & n()>=20) %>%
  do(tidy(lm(avg_attendance ~ HR,data=.), conf.int = TRUE)) %>%
  filter(term=='HR') %>%
  select(W, estimate, conf.low, conf.high) %>%
  ggplot(aes(W, y = estimate, ymin = conf.low, ymax = conf.high)) +
  geom_errorbar() +
  geom_point()

Teams_small %>% do(tidy(lm(avg_attendance~R+HR+W+yearID,data=.), conf.int=T))

fit<-lm(avg_attendance~R+HR+W+yearID,data=Teams_small)

predict(fit,data.frame(R=5,HR=1.2,W=80,yearID=2002))
predict(fit,data.frame(R=5,HR=1.2,W=80,yearID=1960))

d<- Teams %>% 
  filter(yearID==2002)%>%
  mutate(avg_attendance = attendance/G, R=R/G, HR=HR/G) %>%
  select(avg_attendance,R,HR,W,yearID) %>%
  mutate(R_hat=predict(fit,.))

cor(d$avg_attendance, d$R_hat)
