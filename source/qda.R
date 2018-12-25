set.seed(1234)
library(class)
library(caret)
library(ISLR)
library(MASS)
train <- read.csv("train.csv",sep=",")
test <- read.csv("test.csv",sep=",")

#qda

letter.qda.cv <- qda(train[,2:17],train[,1],CV=TRUE)

tab <- table(train$V1,letter.qda.cv$class)
(error.LOOCV <- 100*(1-sum(tab[row(tab)==col(tab)])/sum(tab)))

model.qda <- qda(V1 ~ ., data = train)
qda.predictions <- predict(model.qda, test)
qda.predictions$class

tab <- table(test$V1, qda.predictions$class)  
tab
error <- 100*(1-sum(tab[row(tab)==col(tab)])/sum(tab))
error
