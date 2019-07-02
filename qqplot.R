library('datasets')

summary(airquality)

x<-airquality$Temp

p<-seq(0.05,0.95,0.05)

observed_quantile<-quantile(x,p)

theoretical_quantile<-qnorm(p,mean=mean(x), sd=sd(x))

plot(theoretical_quantile, observed_quantile)

abline(0,1) # a: intercept b: slope