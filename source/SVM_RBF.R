library(e1071)
library(caret)
library(doParallel)
set.seed (4567)

setwd("C:/Users/markb/Dropbox/1 UNI/4any/Q1/APA/practica")
train <- read.csv("train.csv",sep=",")
test <- read.csv("test.csv",sep=",")

# normalize data
train[,2:17] <- scale(train[,2:17])
test[,2:17] <- scale(test[,2:17])

# 5-fold cross validation
trc <- trainControl (method="cv", number=5)
c = 10^seq(-2,3)
sigma = 2^seq(-5,2)

start.time <- Sys.time()

cl = makeCluster(4)
registerDoParallel(cl)

SVM.5CV <- train(train[,2:17],train[,1], method='svmRadial',
                 tuneGrid = expand.grid(.C=c,.sigma=sigma), trControl=trc)

stopCluster(cl)

end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken

save(SVM.5CV, file = "scaleSVM5CV.regul")
# load("scaleSVM5CV.regul")

SVM.5CV$results
SVM.5CV$bestTune

pred <- predict(SVM.5CV,test[,2:17], type = 'raw')

t <- table(pred,test[,1])
acc <- 100*(sum(diag(t))/nrow(test))
acc

