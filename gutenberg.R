#install.packages('gutenbergr')
library(tidyverse)
library(gutenbergr)
library(tidytext)
options(digits = 3)

gutenberg_metadata

gutenberg_metadata %>%
  filter(str_detect(title,'Pride and Prejudice'))

gutenberg_works() %>%
  filter(str_detect(title,'Pride and Prejudice'))

pride_and_justice <- gutenberg_download(1342)

pride_and_justice %>%
  unnest_tokens(word, text) %>%
  filter(!word %in% stop_words$word ) %>%
  filter(!str_detect(word,'[0-9]')) %>%
  count(word, sort = T) %>%
  filter(n>100)

afinn <- get_sentiments("afinn")

afinn_sentiments <- pride_and_justice %>%
  unnest_tokens(word, text) %>%
  filter(!word %in% stop_words$word ) %>%
  filter(!str_detect(word,'[0-9]')) %>%
  inner_join(afinn, by = "word") %>%
  mutate(posneg=ifelse(value>=0,'positive','negative')) %>%
  group_by(posneg) %>%
  summarize(percent=n())


