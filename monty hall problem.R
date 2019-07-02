b <- 10000

stick <- replicate(b,{
  doors <- 1:3
  prize <- sample(c('car','goat','goat'))
  prize_door <- doors[prize=='car']
  mypick <- sample(doors,1)
  show<-sample(doors[!doors%in%c(mypick,prize_door)],1)
  mypick==prize_door
})
mean(stick)

switch <- replicate(b,{
  doors <- as.character(1:3)
  prize <- sample(c('car','goat','goat'))
  prize_door <- doors[prize=='car']
  mypick <- sample(doors,1)
  show<-sample(doors[!doors%in%c(mypick,prize_door)],1)
  switch<-doors[!doors%in%c(mypick,show)]
  switch==prize_door
})
mean(switch)