library(tidyverse)

set.seed(25)

probx<-function(x,df1,df2){
  return (sort(sapply(t<-rf(x,df1,df2), fun<-function(x){return (x/sum(t))}),decreasing = TRUE))
  #return (sort(sapply(t<-rchisq(x,df1,df2), fun<-function(x){return (x/sum(t))}),decreasing = TRUE))
}

nrows<-10000
ds<-data.frame(
  var01=sample(seq(1,20,1),prob=probx(20,5,1),nrows, replace=TRUE)
  ,var02=sample(seq(1,50,1),prob=probx(50,1,1),nrows, replace=TRUE)
  ,var03=sample(seq(1,100,1),prob=probx(100,1,1),nrows, replace=TRUE)
)

ds %>% ggplot()+
  geom_density(aes(x=var01), color='blue')+
  geom_density(aes(x=var02), color='red')+
  geom_density(aes(x=var03), color='green')

write.csv(ds,'C:\\data\\ds.csv')


