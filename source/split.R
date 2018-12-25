#https://archive.ics.uci.edu/ml/datasets/letter+recognition
setwd("C:/Users/markb/Dropbox/1 UNI/4any/Q1/APA/practica")
setwd("C:\\Users\\Riqui\\Dropbox\\practica")
data <- read.table("letter-recognition.data",sep=",")

summary(data[,-1])

library(caret)

dd <- createDataPartition(y=data$V1, p = .7, list = FALSE)
train <- data[ dd,]
test <- data[-dd,]

write.csv(train,file="train.csv",row.names = F)
write.csv(test,file="test.csv",row.names = F)
