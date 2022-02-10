library(tidyverse)
library(pdftools)
options(digits = 3)    # report 3 significant digits

fn <- system.file("extdata", "RD-Mortality-Report_2015-18-180531.pdf", package="dslabs")
system("cmd.exe", input = paste("start", fn))

txt <- pdf_text(fn)

length(txt)

txt

raw_data<-txt[9]

x <- str_split(raw_data, "\n")
x %>% head

class(x)

s<-x[[1]]
class(s)

s<-str_trim(s)
s[1]

header_index<-str_which(s,"2015")[1]

header<-s[header_index]

header_list <- header %>%
  str_split("\\s{2,}", simplify = TRUE)

month<-header_list[1]

header<-header_list[2:5]

tail_index<-str_which(s,"Total")[1]

n<-str_count(s,"\\s*\\d+\\s*")

tab <- s[(header_index+1):(tail_index-1)]

n<-str_count(tab,"\\s*\\d+\\s*")

tab<-tab[!n==1]

s<-tab

s <- str_remove_all(s, "[^\\d\\s]")
s

s <- str_split_fixed(s, "\\s+", n = 6)[,1:5]
s

mean(as.numeric(s[,2]))
mean(as.numeric(s[,3]))
mean(as.numeric(s[1:19,4]))
mean(as.numeric(s[20:30,4]))

tab <- data.frame(s)
tab

names(tab)[1]<-'day'
names(tab)[2]<-'2015'
names(tab)[3]<-'2016'
names(tab)[4]<-'2017'
names(tab)[5]<-'2018'

tab <- tab %>% gather(year, deaths, -day) %>%
  mutate(deaths = as.numeric(deaths))

tab %>% filter(!year==2018) %>%
  ggplot(aes(as.numeric(day),deaths)) +
  geom_point(aes(colour=year)) +
  geom_vline(xintercept = 20)
