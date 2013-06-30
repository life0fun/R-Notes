#!/usr/bin/Rscript

setwd('/Users/e51141/macsrc/datasci/R')

x = c(18,23,25,35,65,54,34,56,72,19,23,42,18,39,37)
y = c(202,186,187,180,156,169,174,172,153,199,193,174,198,183,178)
xy = lm(y ~ x)
summary(xy)
n = length(y)
res = resid(xy)
s=sqrt(sum(res^2)/(n-2))
b1 = coef(xy)['x']
SE = s/sqrt(sum((x-mean(x))^2))
# now test the hypothesis that b1 = -1
t = (b1 - (-1))/SE
pt(t, n-2, lower.tail=FALSE)

cat('---- predict to produce fit values with 95% conf interval --\n')
predict(xy, data.frame(x=x), level=.9, interval="confidence")


# Quadratic regression
dist = c(253, 337,395,451,495,534,574) 
height = c(100,200,300,450,600,800,1000)
lm.2 = lm(dist ~ height + I(height^2)) 
lm.3 = lm(dist ~ height + I(height^2) + I(height^3)) 
summary(lm.2)
summary(lm.3)

pts = seq(min(height),max(height),length=100) 
quad.fit=200.211950+ .706182*pts-0.000341*pts^2 

cube.fit=155.5+1.119*pts-.001234* pts^2+ .000000555*pts^3
plot(height,dist)
lines(pts,quad.fit,lty=1,col="blue")
lines(pts,cube.fit,lty=2,col="red") 
#legend(locator(1), c("quadraticfit","cubicfit"),lty=1:2,col=c("blue","red")) 

