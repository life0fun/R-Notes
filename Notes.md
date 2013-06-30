## R list and vector. data.frame is really a lis
    lisp: Every scalar is a vector of length one.
	http://stackoverflow.com/questions/2050790/how-to-correctly-use-lists-in-r

## factor, categorical data, as opposed to continuous random variable
  http://www.ats.ucla.edu/stat/R/modules/factor_variables.htm
  	gender <- factor(c('male', 'female'))
  	smoke <- facotr(c('smoke', 'non-smoke'))

## cut numerica vector into factor using cut breaks.
	incomes = c(60, 49, 40, 61, 64, 60, 59, 54, 62, 69, 70, 42, 56, 67)
	incomes <- factor(cut(incomes, breaks = 35+10*(0:7)))

	statef <- factor(c('ca','il','ny','wa','tx'))
	statef <- factor(rep(statef, 6))

	table(statef, incommes)

  a <- c(1,2,3,4,5,2,3,4,5,6,7)
	f <- cut(a,3)  # cut evenly into 3 chunks
	f <- cut(a, 3, dig.lab=4, ordered = TRUE)

## Frequency tables from factors
  A two way table is two level break down of data, first break down by gender, then smoke.
    tb <- table(breakdown_by_factor_1, breakdown_by_factor2)
  All breakdown arguments must have the same length

  	sexsmoke<-matrix(c(70,120,65,140),ncol=2,byrow=TRUE)
  	rownames(sexsmoke)<-c("male","female")
  	colnames(sexsmoke)<-c("smoke","nosmoke")
  	sexsmoke <- as.table(sexsmoke)

## data.frame, defined as a table(column1, column2,...), data frame is really a list.
   data frame is a list of columns with the same num of rows with unique row names.

  	f <- data.frame(col1, col2, ...)
  	f <- data.frame(colname=factor1, colname=factor2, ...)

   sort a data.frame, just sort the col, get a index vector, then use that index vector.
   	d<-order(LifeCycleSavings$dpi)
	LifeCycleSavings[d,]

## existing data frame
   LifeCycleSavings {datasets}

## summary is used to check data distribution. We should avoid data clustering within certain area.
1. summary() returns five number summary plus mean for numeric vector 
   and returns the frequencies for categorical vector.
2. var() returns the sample variance, 
   sd() the sample standard deviation, and 
   cor() the sample correlation coefficient between two vectors: 
   cor(Mileage,Weight)


## Statistics explained: (sample, population, test, expected value, confidence level)
  N measurements, how their avg, variance, and the ratio between them distributed !!

  Center Limit Theorem(CLT) : random variables tends to follow normal distribution.
  Test and hypothesis: statistic take n random samples of population, as n samples approximately normal dist, from n samples sigma, SE, etc, we can estimate population.

  If the observed value is normally distributed, then under the null hypothesis, the z-statistic has a standard normal distribution
  So the further the z-statistic is from zero, such extreme z-statitics should unlikely to happen under normal distribution. this serves as the stronger the evidence that the null hypothesis is false.
  The P-value of the test is the chance of getting a test statistic as extreme, or more extreme, than the one we observed(z-value), if the null hypothesis is true

  n sample, mean, variance, sigma, SE. confidence level.
  68% population within mean+- 1 sd, confidence level 68%
  95% population within mean+- 2 sd, confidence level 95%.
  SE = 2*sigma.

  Ex: U.S ppl life mean 68, sd(sigma) is 5. so 95% ppl live from 58-78.

  z= ( observed − expected ) / standard_error
  z-test = (xbar - expected)/(sd/sqrt(n))
  t-test, unrealistic popluation's sd(sigma) is known, use samples sigma


  Ex: 42 out of 100 says yes, does it support null hypothesis that half p=.5 yes ?
    prop.test(42, 100, p=.5)
  
  Ex: 420 out of 1000 says yes, does it support null hypothesis that half p=.5 yes ?
    prop.test(420, 1000, p=.5)

  For binary value(true/false), do multiple tests, each test is a sample, then calculate mean, sigma, SE among tests.

  Ex: Honda claim mpg=25. We sample 10 ppl, get avg xbar=22 with sigma=1.5.
      null hypothesis H_0 mpg=25, alternative hypothesis, mpg<25
        xbar=22;s=1.5;n=10
        t = (xbar-25)/(s/sqrt(n))
        t = [1] -6.324555
      we use pt to get the prob dist of t > 
        pt(t,df=n-1)
        [1] 6.846828e-05
    pt is a small p-value (0.000068). Reject h0 in favor of alternative.

  Ex: I survey a random sample of 1000 adults. They have an average income of $32000 a year, with a SD of $11000 a year. What is the 95% confidence interval for the average annual income of all adults?

    Estimated average = $32000
    Estimate of SE = $11000/sqrt(1000) = $350
    95% CI is $32000 +/- 2*$350 = $31300 to $32700

  Hypothesis tests, P-value and statistical significant
    z-test = (xbar - expected) / (sigma/sqrt(n))
    from z value, from standard normal distribution table, find prob area for the value.

  Ex: hypothesis the avg of mean value in a blackbox is 10. Assume the real avg is 50. so the expected value is 50.
    we draw 100 tickets from the box: these have mean 45 and SD 10.
    The expected sample average is 50
    Standard error of sample average is estimated as 10/sqrt(100) = 1
    We observed the sample average was 45
    if avg is really 50, then 45 is 5 standard error below. 
    It's unlikely we'd get 5 SEs below the expected value just by chance
    Therefore, we have evidence the box average is not 50

  Ex: toss a coin 100 time, get head 35 times, 
    P(35 or fewer heads) = 0.18% 
    P(35 or fewer tails) = 0.18%
    prop.test(35, 100, p=0.5)
    p-value = 0.003732
    35 heads is very unlikely to happen by chance(3%), so reject the null. The coin is biased.

  Statistic significant:
    A P-value of less than 5% is statistically significant: the difference can't be explained by chance, so reject the null hypothesis
    A P-value of more than 5% is not statistically significant: the difference can be explained by chance. We don't have enough evidence to reject the null hypothesis.

## Confidence Level : how close sample to population. z=diff(sample,population) is to 0 by confidence. Prob(-1<(p-xp)/SE<1)=0.68 
    Claim: 42 likes out of 100 surveyed with error 9%. This is 95% CI.
    1. sample mean approximate to true mean, with sample size n, population std sigma, and CI.
    2. zstar follow cumulative distribution qnorm(1-alpha) where alpha=1-CI
    3. SE = sigmal/sqrt(n)  # sigmal = sqrt(variance)
    4. value interval is xbar+(-zstar*SE, zstar*SE)

## Chisq test: goodness of fit test. distribution of variance, categorical data variance.

 categorical data. indep ? same effect of use seat belt or not, or Rows comes from same distribution ?
    yes-belt = c(12813,647,359,42)
    no-belt = c(65963,4000,2642,303)
    chisq.test(data.frame(yes-belt,no-belt))

## ANOVA 
F-dist: distribution between two variances, the ratio of two chi-square variables. ANOVA.
variance analysis. hypothesis test two samples with t test to get p-value to reject null hypo.
## hypothesis test with t test and p-value: with avg/var and its ratio of sample, prob of getting more extrem value.

## z-test : diff between sample and true population statistics. 
## Assume true sigma is known for the distribution, which is not realistic; t-test, use sigma from sample.
## One sample t test(against true mean): sample weight, analysis variances. 

    8 tosses 6 head, tot=pow(2,8), 6head=C(8,6)=28. p=28/256, not small enough to reject H0.

    w=c(175 ,176 ,173 ,175 ,174 ,173 ,173 ,176 ,173 ,179)
    hist(w), boxplot(w) and qqnorm(w) 
    t.test(w) p-value: a small p-value is considered strong evidence against the null hypothesis.

t-test from one sampled against claimed mean : calc xbar and s sigma from sample value.
    t = (xbar-claimed-mean) / (s/sqrt(n))  # n values in one sample, s is sampled standard deviation. SE = s/sqrt(n)
    p-value = pt(t, df=n-1)
if Estimat and SE is known from regression or anova, conduct one-side test to see if est is high ?
    t = (calced-est - claimed-or-new-guess) / SE   # SE = sampled-standard-deviation/sqrt(n)
    pt(t, df=n, lower.tail=F)
    if p-value is not small, mean new-guess has the same effect.

or Proportion test to check bias : two samples test(prop one Vs another) 
    prop.test(42,100, conf.level=0.90)
    prop.test(42,100,p=.5)
    prop.test(420,1000,p=.5)

## Two samples t test (compare null hypothesis(Equal Mean) between two groups, or many groups) 
    t.test(weight[feed='meat'], mu=mean(weight0)
    t.test(weight[feed == ’casein’],weight[feed == ’sunflower’])

## N sample t test : one-way ANOVA check the variance among n groups, H0, Equal mean among all groups. 
    oneway.test(values ~ ind, data=stack(data.frame(x,y,z), var.equal=T)

## chi-square test: goodness of fit test: fit a model. 
    dice is fair, i.e, each face prob is 1/6. chisq.test(c(22,21,22,27,22,36), p = c(1,1,1,1,1,1)/6)
    letter dist: chisq.test(c(100,110,80,55,14), p=c(29, 21, 17, 17, 16)/100))
    test for indep: no co-relation between variables. chisq.test(data.frame(yes-belt,no-belt))

## Mining Data pipeline: [ discretizer, smoothers, principle component analysis, regression, classifiers ]
    1. model data, fit func, predict and estimation.
    2. estimation and variance analysis, calc mean, hypothesis, etc.
    3. finding cluster, frequent items, etc.
    4. Principle Component Analysis.
    5. Classifier, Machine Learning : train SVM with GA algo to classify instance.

## PCA : prcomp(wine, scale=TRUE)
    1. PCA: normalize feature values scale=True, check feature value distribution with summary() / table().
    2. biplot dominate eigenvalues(principle components) and find features that align to x(pc1) and y(pc2). 
    1. classifier algorithm: align test data to training data, which are already classified properly.
    2. classifier by SVM : support vector to divide components.

## Machine learning : train SVM use GA to search best fit tuning params, gen SVM classifier.

1. SVM : input is a vector[feature-val-1, feature-val-2,...], tuning params, training set.
   Desired Output Classification : [ Input Vector ] => should produce this output classification.
1. GA is domain agnostic: input as a set of string, [attr1, attr2,..]  and grade the output as how fit it is.
2. use GA to search for best SVM tuning parameters.
3. GA input candidate: a string repr all possible tuning params. GA params: empirical to avoid stuck or speedify fast converge.
4. GA fitness func: the Mean-Square-Error of training set for each tuning params set.
5. 

## N-gram distribution
    sentence = [ 'to','be','or','not','to','be']
    2-gram = [] 3-gram = []
    for i in sentence[0..len]
        2-gram.push sentence[i..i+2]  # ['to be', 'be or', 'or not']
        3-gram.push sentence[i..i+3]  # ['to be or', 'be or not', 'or not to']

* convert a seq of char into a _set_ of n-grams, repr in vector space, approx(similarity) based on cosine dist among vectors.
* for 3-gram letter, there are 26^3 dimention vector space. For english vocabulary with 3000 words, dim = (3000^3)
* 
