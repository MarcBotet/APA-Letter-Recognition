set.seed(1234)
library(class)
library(caret)
library(ISLR)
library(MASS)
train <- read.csv("train.csv",sep=",")
test <- read.csv("test.csv",sep=",")

#LDA

letter.lda.cv <- lda(train[,2:17],train[,1],CV=TRUE)

tab <- table(train$V1,letter.lda.cv$class)
(error.LOOCV <- 100*(1-sum(tab[row(tab)==col(tab)])/sum(tab)))

model.lda <- lda(V1 ~ ., data = train)
lda.predictions <- predict(model.lda, test)
lda.predictions$class

tab <- table(test$V1, lda.predictions$class)  
tab
error <- 100*(1-sum(tab[row(tab)==col(tab)])/sum(tab))
error