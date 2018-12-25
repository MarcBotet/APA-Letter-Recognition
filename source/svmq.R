train <- read.csv("train.csv",sep=",")
test <- read.csv("test.csv",sep=",")

library(e1071)
library(caret)
library(doParallel)

#5-fold cv
c = 10^seq(-2,3)
tc2 = tune.control(sampling = "cross", cross = 5)


start.time <- Sys.time()
cl = makeCluster(4)
registerDoParallel(cl)

model.5cv <- tune.svm(train[,2:17],train[,1], cost=c,kernel="polynomial", degree = 2, scale = TRUE, tunecontrol = tc2)


stopCluster(cl)

end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken

#save(model.5CV, file = "SVMq.5CV")
#load("SVMq.5cv")
model.5CV$results
model.5CV$bestTune

pred <- (predict (model.5CV, newdata=test[,2:17], type="raw")) 

t <- table(pred,test[,1])
acc <- 100*(sum(diag(t))/nrow(test))
acc
