library(dslabs)
library(ggplot2)

data("murders")

r <- sum(murders$total) / sum(murders$population) * 10^6

p<-ggplot(data=murders,aes(x=population/10^6,y=total,label=abb))

p+geom_point(aes(col=region), size=3)+
  geom_text(nudge_x = 0.05)+
  scale_x_log10()+
  scale_y_log10()+
  xlab("Population in millions (log scale)")+
  ylab("Total number of murders (log scale)")+
  ggtitle("US Gun Murders in Us 2010")+
  scale_color_discrete(name="Region")+
  geom_abline(intercept = log10(r), lty=2, color="darkgrey")