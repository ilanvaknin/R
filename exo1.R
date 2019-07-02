color <- rep(c('black','red','green'), c(18,18,2))

n<-1000
X<-sample(ifelse(color=='red',-1,1), n, replace = TRUE)
X[1:10]

S<-replicate(10000,{
  X<-sample(c(-1,1),n,replace=TRUE,prob=c(9/19,10/19))  
  sum(X)
})

mean(S<=0)

mean(S)
