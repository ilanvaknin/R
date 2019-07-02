x <- matrix(sample(1:100,100,replace=F),nrow=10,ncol=10)
print(x)

y <- apply(x,c(1,2),function(x) sqrt(x))
print(y)


