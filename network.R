size <- 10
d1 <- data.frame(source=1, target=paste(1, seq(1,size), sep="-"), SourceNodeWeight=10, TargetNodeWeight=7)
size <- 3
d2 <- data.frame(source=rep(d1$target, each=size),target=paste(rep(d1$target, each=size), seq(1,size), sep="-"), SourceNodeWeight=7, TargetNodeWeight=1)
size <- 2
d3 <- data.frame(source=rep(d2$target, each=size),target=paste(rep(d2$target, each=size), seq(1,size), sep="-"), SourceNodeWeight=1, TargetNodeWeight=1)
size <- 1
d4 <- data.frame(source=rep(d3$target, each=size),target=paste(rep(d3$target, each=size), seq(1,size), sep="-"), SourceNodeWeight=1, TargetNodeWeight=1)
size <- 10
d5 <- data.frame(source=rep(d4$target, each=size),target=paste(rep(d4$target, each=size), seq(1,size), sep="-"), SourceNodeWeight=1, TargetNodeWeight=1)

hierarchy <- rbind(d1, d2, d3, d4, d5)

write.table(hierarchy, "c:/data/network.txt", sep="\t", row.names = F)