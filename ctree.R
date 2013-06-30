#!/usr/bin/Rscript

##
## ex taken from http://www.rdatamining.com/

library(party)
library(wavelets)

sc = read.table('./synthetic_control.data', header=F, sep='')

# random sample n cases
n = 10
s = sample(1:100, n)
idx <- c(s, 100+s, 200+s, 300+s, 400+s, 500+s)
sample2 <- sc[idx,]

observedLabels <- c(rep(1,n), rep(2,n), rep(3,n), rep(4,n), rep(5,n), rep(6,n))

#
# Time series clustering
#
# hierarchical clustering with Eclidean dist
hc = hclust(dist(sample2), method='ave')
memb<-cutree(hc,k=8)  # cut tree to get 8 clusters
table(observedLabels, memb)

# Fail...hierarchical clustering with DTW dist
#distMatrix<-dist(sample2,method="DTW") 
#hc = hclust(distMatrix,method="average")

#
# time series classification
#

# classification with Original Data
#
# 1. make class label categorical data
classId = c(rep('1',100), rep('2',100), rep('3',100), rep('4', 100), rep('5', 100), rep('6', 100))
newSc = data.frame(cbind(classId, sc))
# 2. build a decision tree with ctree() in package party
ct = ctree(classId ~ ., data=newSc, controls = ctree_control(minsplit=30, minbucket=10, maxdepth=5))
pClassId = predict(ct)
table(classId, pClassId)
accu = (sum(classId==pClassId)) / nrow(newSc)
accu

# classification with wavelet transform.
# filter out noise in data with wavelet tranform
# 1. transform to wavelet data.frame
wtData = NULL
for (i in 1:nrow(sc)) {
  a = t(sc[i,])
  wt = dwt(a, filter='haar', boundary='periodic')
  wtData = rbind(wtData, unlist(c(wt@W,wt@V[[wt@level]])))
}
wtData = as.data.frame(wtData)
wtSc = data.frame(cbind(classId, wtData))
 
# 2. decision tree with DWT
ct = ctree(classId ~ ., data=wtSc, controls= ctree_control(minsplit=30, minbucket=10, maxdepth=5))
pClassId = predict(ct)
table(classId, pClassId)
accu = (sum(classId==pClassId)) / nrow(wtSc)
accu
