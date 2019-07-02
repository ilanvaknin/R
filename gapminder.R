library(dslabs)

data(gapminder)

gapminder %>% filter(year==1962 & country != 'Kuwait') %>%
  ggplot(aes(gdpPercap, lifeExp, label=country, color=continent)) +
  geom_point()

gapminder %>% filter(year==2007) %>%
  ggplot(aes(gdpPercap, lifeExp, label=country, color=continent)) +
  geom_point()

gapminder %>% filter(year %in% c(1962,2007) & country != 'Kuwait') %>%
  ggplot(aes(gdpPercap, lifeExp, label=country, color=continent)) +
  geom_point()+
  facet_grid(.~year)

gapminder %>% filter(country == 'United States') %>%
  ggplot(aes(year, gdpPercap)) +
  geom_line()
