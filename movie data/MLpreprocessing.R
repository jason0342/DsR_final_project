movies <- read.csv("processed movie data.csv");
movies2 <- movies[,c(1, 2)]
movies2[,c(3:8)] <- scale(movies[,c(5:10)])
colnames(movies2) <- colnames(movies)[c(1,2,5:10)]
movies2[,c(9:10)] <- movies[,c(11, 12)]
write.csv(movies2, "MLdata.csv", fileEncoding = "UTF-8")
