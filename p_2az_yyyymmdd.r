lowlow <- outer(letters,letters, paste0)
lowup  <- outer(LETTERS,LETTERS, paste0)
uplow  <- outer(letters,LETTERS, paste0)
upup   <- outer(LETTERS,letters, paste0)

l <- rbind(lowlow, lowup, uplow, upup)
dim(l)<-NULL

d <-format(seq(as.Date("2017-01-01"), as.Date("2020-12-31"), by="days"),"%Y%m%d")

p_2az_yyyymmdd<-outer(l,d,paste0)

dim(p_2az_yyyymmdd)<-NULL

write(p_2az_yyyymmdd, file = "p_2az_yyyymmdd.txt")
