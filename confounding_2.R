library(dslabs)
data("research_funding_rates")
research_funding_rates

totals <- research_funding_rates %>% 
  summarize(yes_men=sum(awards_men), 
           no_men=sum(applications_men)-sum(awards_men),
           yes_women=sum(awards_women),
           no_women=sum(applications_women)-sum(awards_women)) 

two_by_two <- data.frame(awarded = c("no", "yes"), 
                         men = c(totals$no_men, totals$yes_men),
                         women = c(totals$no_women, totals$yes_women))

round(two_by_two$men[2]/(two_by_two$men[1]+two_by_two$men[2])*100,1)
round(two_by_two$women[2]/(two_by_two$women[1]+two_by_two$women[2])*100,1)

chisq_test <- two_by_two %>% select(-awarded) %>% chisq.test()
chisq_test$p.value

dat <- research_funding_rates %>% 
  mutate(discipline = reorder(discipline, success_rates_total)) %>%
  rename(success_total = success_rates_total,
         success_men = success_rates_men,
         success_women = success_rates_women) %>%
  gather(key, value, -discipline) %>%
  separate(key, c("type", "gender")) %>%
  spread(type, value) %>%
  filter(gender != "total")
dat

dat %>% ggplot(aes(discipline, success, col = gender, size = applications)) + geom_point()
