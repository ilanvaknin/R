mu <- 0
tau <- 0.035
sigma <- results$se
Y <- results$avg
B <- sigma^2 / (sigma^2 + tau^2)

posterior_mean <- B*mu + (1-B)*Y
posterior_se <- sqrt (1/ (1/sigma^2 + 1/tau^2))

# simulate 6 data point
J <- 6
N <- 2000
d <- 0.021
p <- (d+1)/2
X <- d + rnorm(J,0,2*sqrt(p*(1-p)/N))

# simulate 6 data point for 5 pollster
I<-5
J<-6
N<-2000
d <- 0.021
p <- (d+1)/2
h <- rnorm(I,0,0.025)
X<-sapply(1:I, function(i){
  d + h[i] + rnorm(J,0,2*sqrt(p*(1-p)/N))
})

#including pollster effect and general bias
mu <- 0
tau <- 0.035
sigma <- sqrt(results$se^2 + 0.025^2)
Y <- results$avg
B <- sigma^2 / (sigma^2 + tau^2)

posterior_mean <- B*mu + (1-B)*Y
posterior_se <- sqrt (1/ (1/sigma^2 + 1/tau^2))

1 - pnorm(0, posterior_mean, posterior_se)
