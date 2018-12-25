set.seed (4567)
library(randomForest)
library(TunePareto)

setwd("C:/Users/markb/Dropbox/1 UNI/4any/Q1/APA/practica")
train <- read.csv("train.csv",sep=",")
test <- read.csv("test.csv",sep=",")

harm <- function (a,b) { 2/(1/a+1/b) }

(ntrees <- seq(50,1500,100))

rf.results <- matrix (rep(0,2*length(ntrees)),nrow=length(ntrees))
colnames (rf.results) <- c("ntrees", "OOB")
rf.results[,"ntrees"] <- ntrees
rf.results[,"OOB"] <- 0

ii <- 1

start.time <- Sys.time()

for (nt in ntrees)
{ 
  print(nt)
  
  model.rf <- randomForest(V1 ~ ., data = train, ntree=nt, proximity=FALSE)
  
  
  # get the OOB
  rf.results[ii,"OOB"] <- model.rf$err.rate[nt,1]
  
  ii <- ii+1
}

end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken

rf.results

save(rf.results,file="RFresults.regul")
# load("RFresults.regul")

(lowest.OOB.error <- as.integer(which.min(rf.results[,"OOB"])))
(ntrees.best <- rf.results[lowest.OOB.error,"ntrees"])

start.time <- Sys.time()

model.rf <- randomForest(V1 ~ ., data = train, ntree=ntrees.best, proximity=FALSE)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken

pred.rf.final <- predict (model.rf,test, type="class")
ct <- table(Truth=test$V1, Pred=pred.rf.final)
sum(diag(ct))/sum(ct)

round(100*(1-sum(diag(ct))/sum(ct)),2)

(F1 <- harm (prop.table(ct,1)[1,1], prop.table(ct,1)[2,2]))

plot(model.rf$err.rate[,1], ylab = "Error", xlab = "Nombre d'arbres")

importance(model.rf)
options(repr.plot.width=6, repr.plot.height=4)
varImpPlot(model.rf)
