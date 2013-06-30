#!/usr/bin/Rscript

#
# An example taken from a simple R tutorial at 
#  http://math.illinoisstate.edu/dhkim/rstuff/rtutor.html
#

Make<-c("Honda","Chevrolet","Ford","Eagle","Volkswagen","Buick","Mitsbusihi", "Dodge","Chrysler","Acura")
Model<-c("Civic","Beretta","Escort","Summit","Jetta","Le Sabre","Galant", "Grand Caravan","New Yorker","Legend")
Cylinder<-c(rep("V4",5),"V6","V4",rep("V6",3))
Weight<-c(2170,2655,2345,2560,2330,3325,2745,3735,3450,3265)
Mileage<-c(33,26,33,33,26,23,25,18,22,20)
Type<-c("Sporty","Compact",rep("Small",3),"Large","Compact","Van",rep("Medium",2))

Car<-data.frame(Make,Model,Cylinder,Weight,Mileage,Type) 

cat('------ car table--------\n')
table(Car$Make, Car$Type)

cat('--- sort by weight ---\n')
i<-order(Car$Weight);
Car[i,]

attach(Car)  # to avoid using Car$ every time

plot(Weight, Mileage, main="Weight vs. Mileage")
fit<-lm(Mileage~Weight)
abline(fit)

cor(Mileage,Weight)

cat(' ---- aov(wt, type) ----\n')
a<-aov(Car$Weight~Car$Type)
summary(a)

