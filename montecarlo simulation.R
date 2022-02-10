sac <- rep(c('red','blue'), times=c(2,3))
sample(sac,1)

b<-10000
events<-replicate(b,sample(sac,1))
tab<-table(events)
tab
prop.table(tab)

events<-sample(sac,b,replace = TRUE)
prop.table(table(events))