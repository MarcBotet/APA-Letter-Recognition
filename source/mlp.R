library(MASS)
library(nnet)
set.seed (4567)
library(caret)
library(doParallel)

# setwd("C:/Users/markb/Dropbox/1 UNI/4any/Q1/APA/practica")

train <- read.csv("train.csv",sep=",")
test <- read.csv("test.csv",sep=",")

# normalize data
train[,2:17] <- scale(train[,2:17])
test[,2:17] <- scale(test[,2:17])

trc <- trainControl (method="cv", number=5)
(sizes2 <- 2*seq(5,50,by=3))

(decays <- c(0.01, 0.1,0.0, 0.5, 1.0))

start.time <- Sys.time()

cl = makeCluster(6)
registerDoParallel(cl)

model.train = train(V1 ~., data = train, method='nnet', maxit = 200, 
                    trControl=trc, MaxNWts = 10000, tuneGrid = 
                      expand.grid(.size=sizes,.decay=decays))

stopCluster(cl)

end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken

save(model.train, file = "LargeMLP_CV.regul")
load("LargeMLP_CV.regul")

p2 <- predict(model.train, newdata = test, type = "raw")

t2 <- table(p2,test$V1)
error_rate.test <- 100*(sum(diag(t2))/nrow(test))
error_rate.test

plot(model.train)
