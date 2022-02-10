library(rvest)

url <- 'https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm'

h <- read_html(url)

nodes <- html_nodes(h, "table")

html_table(nodes[[21]])

tab_1 <- html_table(nodes[[10]])
tab_2 <- html_table(nodes[[19]])

tab_1<-tab_1[,2:4]

tab_1<-tab_1[2:31,1:3]

tab_2<-tab_2[2:31,1:3]

names(tab_1)<-c("Team", "Payroll", "Average")

names(tab_2)<-c("Team", "Payroll", "Average")

library(tidyverse)

result<-full_join(tab_1,tab_2,by='Team')

url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"

h<-read_html(url)

tab <- html_nodes(h, "table")
tab_1 <- html_table(tab[[5]],fill=T)
