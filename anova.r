#!/usr/bin/Rscript

# an example of anova among 3 samples.
# 3 grp of with 7 observations
#
y1 = c(18.2, 20.1, 17.6, 16.8, 18.8, 19.7, 19.1)
y2 = c(17.4, 18.7, 19.1, 16.4, 15.9, 18.4, 17.7)
y3 = c(15.2, 18.8, 17.7, 16.5, 15.9, 17.1, 16.7)

# another way
#   scores = data.frame(x,y,z)
#   boxplot(scores)
#   scores = stack(scores)
#   oneway.test(values ~ ind, data=scores, var.equal=T)

# comb inot one big vect
y = c(y1,y2,y3)
cat(y)
n = rep(7,3)  # repeat 7 three times, 7 7 7
group = rep(1:3, n)  # for 1,2,3, each repeat 7 times
tmp = tapply(y, group, stem)  # create 2 columns, result ~ indic(data), can use stack.
stem(y)

tmpfn = function(x) {
	c(sum=sum(x), mean=mean(x), var=var(x), n=length(x))
}

tapply(y, group, tmpfn)  # grp vect, apply the func to each grp
tmpfn(y)

# create data frame with 2 cols, y and group
data = data.frame(y=y, group=factor(group))
fit = lm( y ~ group, data)
