gapminder %>% filter(continent=='Africa' & year==2012) %>%
  ggplot(aes(fertility, life_expectancy, color=region))+
  geom_point()

library(dplyr)
library(ggplot2)
library(dslabs)
data(gapminder)

gapminder %>% filter(continent=='Africa' & year %in% c(1970,2010) & is.na(gdp) == FALSE) %>%
  mutate(dollars_per_day=gdp/population/365) %>%
  ggplot(aes(dollars_per_day))+
  geom_density()+
  scale_x_continuous(trans='log2')+
  facet_grid(.~year)

#Now we are going to edit the code from Exercise 9 to show stacked histograms of each region in Africa.
gapminder %>% filter(continent=='Africa' & year %in% c(1970,2010) & is.na(gdp) == FALSE) %>%
  mutate(dollars_per_day=gdp/population/365) %>%
  ggplot(aes(dollars_per_day, fill=region))+
  geom_density(bw=0.5, position = "stack")+
  scale_x_continuous(trans='log2')+
  facet_grid(.~year)

gapminder_Africa_2010 <- gapminder %>% filter(continent=='Africa' & year==2010 & is.na(gdp) ==FALSE) %>%
  mutate(dollars_per_day=gdp/population/365)
summary(gapminder)

# plot "y" versus "x"
gapminder_Africa_2010 %>% ggplot(aes(dollars_per_day, infant_mortality, color=region) )+
  geom_point()

gapminder_Africa_2010 <- gapminder %>% filter(continent=='Africa' & year==2010 & is.na(gdp) ==FALSE) %>%
  mutate(dollars_per_day=gdp/population/365)
summary(gapminder)

# now make the scatter plot
gapminder_Africa_2010 %>% ggplot(aes(dollars_per_day, infant_mortality, color=region) )+
  geom_point()

gapminder_Africa_2010 %>% ggplot(aes(dollars_per_day, infant_mortality, color=region, label=country) )+
  geom_label()+
  scale_x_continuous(trans='log2')

gapminder_Africa_2010 %>% ggplot(aes(dollars_per_day, infant_mortality, color=region, label=country) )+
  geom_point()+
  geom_text()+
  scale_x_continuous(trans='log2')

gapminder %>% filter(continent=='Africa' & year %in% c(1970,2010) & is.na(gdp) == FALSE & is.na(infant_mortality)==FALSE) %>%
  mutate(dollars_per_day=gdp/population/365) %>%
  ggplot(aes(dollars_per_day, infant_mortality, color=region, label=country))+
  scale_x_continuous(trans='log2')+
  geom_text()+
  facet_grid(year~.)

library(dplyr)
library(ggplot2)
library(dslabs)
data("murders")
murders %>% mutate(rate = total/population*100000) %>%
  mutate(region=reorder(region,rate,median)) %>%
  ggplot(aes(region,rate,fill=region))+
  geom_boxplot()+
  geom_point()