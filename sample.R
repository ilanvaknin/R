x<-sample(seq(1:3), 1000,replace=T, prob = c(0.43,0.22,0.35)) 
y<-sample(seq(1:3), 1000,replace=T, prob = c(0.67,0.11,0.22))

ds<-data.frame(x,y)

table(ds)

haszero<-sample(c(1,0),1694, replace=T, prob=c(0.3,0.7))

write.csv(d,'C:\\appl\\Monitoring\\haszero.csv')

x<-sample(seq(339458281,559458281), 68178,replace=F) 

write.csv(x,'C:\\data\\Network\\fake_teoudat_68178.csv')


n<-68178
vorna<-read.csv('C:\\data\\Names\\vorna.csv',encoding = 'UTF-8',header=F)
firstname<-sample(vorna$V1,n,replace=T, prob=vorna$V2)
nachn<-read.csv('C:\\data\\Names\\nachn.csv',encoding = 'UTF-8',header=F)
lastname<-sample(nachn$V1,n,replace=T, prob=nachn$V2)
ds<-data.frame(firstname, lastname)
write.csv(ds,'C:\\data\\Names\\names.csv')
