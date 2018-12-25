set.seed(1234)
library(class)
library(caret)
library(ISLR)
#setwd("C:\\Users\\Riqui\\Dropbox\\practica")
train <- read.csv("train.csv",sep=",")
test <- read.csv("test.csv",sep=",")

#########################
trc <- trainControl(method = "LOOCV")
start.time <- Sys.time()
knnFit <- train(V1 ~ ., data = train, method = "knn", trControl = trc,tuneGrid = expand.grid(.k=1:25)) 
knnFit

end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken

#save(knnFit, file = "KNNloocv.CV")
#load("KNNloocv.CV")
knnFit$results
knnFit$bestTune


model <- knn(train = train[,-1], test = test[,-1],cl = train[,1],k=1)
t <- table(model,test[,1])
acc <- 100*(sum(diag(t))/nrow(test))
acc
