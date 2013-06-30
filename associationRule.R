#!/usr/bin/Rscript

setwd('/Users/e51141/macsrc/datasci/R/')

#install.package('arules')
require('arules')

########################
## simple ex
########################
## read transaction data from the csv
txn = read.transactions(file='data/trans.log', rm.duplicates=FALSE, format='single', sep=',', cols=c(1,2));
## now call apriori to find associatin rules
basket_rules = apriori(txn, parameter=list(sup=0.5, conf=0.9, target='rules'));
## inspect the result
inspect(basket_rules);
inspect(basket_rules[1]);
## visualize the item freq of the original txn file
itemfrequencyPlot(txn)
inspect(txn)

########################
## ex of mining AdultUCI
########################
data(AdultUCI)
## inspect the data
dim(AdultUCI)
names(AdultUCI)
head(AdultUCI)

## get rid of cols that's not suitable for a rule mining
AdultUCI$fnlwgt = NULL
AdultUCI[["education-num"]] = NULL

## map metrics into ordinal attributes by building suitable categories intervals.
AdultUCI[["age"]] = ordered(cut(AdultUCI[[ "age"]], c(15,25,45,65,100)), label=c("Young", "Middle-aged", "Senior", "Old"));
AdultUCI[["hours-per-week"]] = ordered(cut(AdultUCI[[ "hours-per-week"]], c(0,25,40,60,168)), labels = c("Part-time", "Full-time", "Over-time", "Workaholic"));
AdultUCI[["capital-gain"]] = ordered(cut(AdultUCI[[ "capital-gain"]], c(-Inf,0,median(AdultUCI[[ "capital-gain"]][AdultUCI[[ "capital-gain"]]>0]),Inf)), labels = c("None", "Low", "High")) 
AdultUCI[["capital-loss"]] = ordered(cut(AdultUCI[[ "capital-loss"]], c(-Inf,0, median(AdultUCI[[ "capital-loss"]][AdultUCI[[ "capital-loss"]]>0]),Inf)), labels = c("none", "low", "high"));

## as requries all col must be factor, then coerced to transactions as binary incidence matrix.
Adult = as(AdultUCI, "transactions") 
Adult
items(Adult)
summary(Adult) 

## find all the association rules
itemFrequencyPlot(Adult,support=0.1,cex.names=0.8
rules = apriori(Adult, parameter=list(support=0.01,confidence=0.6));
summary(rules)  # mined out a set of 276443 rules

## use subset to find subset rules for each item which resulted form the var income in rhs of the rule.
# what caused income small ? what caused income large ?
IncomeSmallRules = subset(rules, subset = rhs %in% 'income=small' & lift > 1.2)
IncomeLargeRules = subset(rules, subset = rhs %in% "income=large" & lift > 1.2) 

## sortby conf
inspect(head(sort(IncomeSmallRules, by = "confidence"), n = 3)) 
inspect(head(sort(IncomeLargeRules, by = "confidence"), n = 3)) 

WRITE(IncomeSmallRules, file = "data.csv", sep = ",", col.names = NA) 

########################
## interest measure with all conf, interestMeasure().
########################
## find the freq itemset
fsets = eclat(Adult, parameter = list(support = 0.05),control = list(verbose=FALSE));

## find all single items
singleItems = fsets[size(items(fsets)) == 1]
singleSupport = quality(singleItems)$support 
names(singleSupport) = unlist(LIST(items(singleItems), decode = FALSE));
head(singleSupport, n = 5)

itemsetList = LIST(items(fsets), decode = FALSE) 
allConfidence = quality(fsets)$support / sapply(itemsetList, function(x) max(singleSupport[as.character(x)]));
quality(fsets) = cbind(quality(fsets), allConfidence);

summary(fsets) 

## interested in how education related to other items in itemset, sorting by all-conf
## The resulting itemsets show that item high school graduate highly associated with 
## working full-time, a small income and working in the private sector.
fsetsEducation = subset(fsets, subset = items %pin% "education") 
inspect(SORT(fsetsEducation[size(fsetsEducation)>1], by = "allConfidence")[1 : 3]);

