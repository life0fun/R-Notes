#!/usr/bin/Rscript

# svm classification example from
# http://en.wikibooks.org/wiki/Data_Mining_Algorithms_In_R/Classification/SVM

#install.packages('e1071',dependencies=TRUE)
library(e1071)

dataset = read.csv('/Users/e51141/macsrc/datasci/R/wdbc.data',head=FALSE)

# prepare train data, 30% 
index <- 1:nrow(dataset)
testindex <- sample(index, trunc(length(index)*30/100))
testset <- dataset[testindex,]
trainset <- dataset[-testindex,]

names(dataset)  # default, v1,v2,...
# V2 col is class col. 
tuned <- tune.svm(V2~., data = trainset, gamma = 10^(-6:-1), cost = 10^(-1:1))
summary(tuned)

# now build the model based on the best gamma and cost
model  <- svm(V2~., data = trainset, kernel="radial", gamma=0.001, cost=10) 
summary(model)

# now run predict, remove the v2 class column
prediction <- predict(model, testset[,-2])
# compared the predicted class with original class
tab <- table(pred = prediction, true = testset[,2])
tab

