#!/usr/bin/Rscript

# k mean cluster example
# http://www.statmethods.net/advstats/cluster.html
#
m1 = matrix(rnorm(100, sd = 0.3), ncol = 2)
m2 = matrix(rnorm(100, mean=1, sd = 0.3), ncol = 2)

x = rbind(m1,m2)
colnames(x) = c("x", "y")
cl = kmeans(x, 2)  # 2 clusters
cl

plot(x, col = cl$cluster)
points(cl$centers, col = 1:2, pch = 8, cex=2)

#
# to use cluster vector, you can col bind to original matrix
nx = cbind(x, clusternum = cl$cluster)
table(nx[,3])

# list all rows belong to cluster n
x[cl$cluster==2,]


