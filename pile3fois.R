B<-10000
results<-replicate(B,{
  tirage<-sample(c(0,1),3,replace=TRUE,prob=c(0.5,0.5))
  identical(tirage,c(1,1,1))
})

mean(results)
