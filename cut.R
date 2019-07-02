library('datasets')

x<-sample(1:100,100,replace = F)
y<-cut(x,3,labels=F, right=F, include.lowest=T)

matrix(x,10,10)
matrix(y,10,10)





