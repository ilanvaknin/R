library(dslabs)
data(heights)

summary(heights)

x<-heights$height
m <- sum(x) / length(x)
mean(x)

sd <- sqrt(sum((x-m)^2)/length(x))
sd(heights$height)


z<-(x-m)/sd
sum(z-scale(x))

sum(abs(z)<2)/length(z)
mean(abs(z)<2)

x <- heights$height[heights$sex == "Male"]
mean(x>69 & x<=72)

pnorm(c(69.72),mean(x), sd(x))

#Exercise 4. Seven footers and the NBA
#Someone asks you what percent of seven footers are in the National Basketball Association (NBA). Can you provide an estimate? Let's try using the normal approximation to answer this question.

#First, we will estimate the proportion of adult men that are 7 feet tall or taller.

#Assume that the distribution of adult men in the world as normally distributed with an average of 69 inches and a standard deviation of 3 inches.

#Instructions
#100 XP
#Using this approximation, estimate the proportion of adult men that are 7 feet tall or taller, referred to as seven footers. Print out your estimate; don't store it in an object.
1-pnorm(7*12,69,3,lower.tail = FALSE)
pnorm(7*12,69,3,lower.tail = FALSE)
