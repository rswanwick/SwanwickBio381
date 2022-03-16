# Lab #8 
# RHS 

library(boot)

# why sim data? 
# saves time: write parts of code before you have data 
# Baseline for comparisons: check assumptions in your data 
# Test new stats techniques 

# Part 1: Normally distributed data 
# Start with groups of data 
# input for a t-test or ANOVA 

# simulate groups with 20 observations 
group1 <- rnorm(n = 20, mean = 2, sd = 1)
hist(group1)

# change some parameters
group2 <- rnorm(n=20,mean=5,sd=1)
group3 <- rnorm(n=20,mean=2,sd=3)

hist(group2)
hist(group3)


# Sim data for linear regression 
# Two continuous normal variables
# Start simple: assume a intercept of 0 
# Call the slope beta1
# x is the predictor variable

# start with constant slope 
beta1 <- 1 

# our predictor variable is normally distributed
x <- rnorm(n=20)

# linear model: 
y <- beta1*x 

# you can play with different slopes 
beta1 <- 1.5
y <- beta1*x

# you can also add an intercept
beta0 <- 2 
y <- beta0+beta1*x

# adding covariates 
# you can draw covariates from a different distribution 

# Part 2: Abundance/count data 
# Option 1: data are normal-ish
# use round() to remove decimals 
abund1 <- round(rnorm(n=20,mean=50,sd=10))
hist(abund1)

# Option 2: Poisson distribution
# this is like the center of the poisson distribution 
abund2 <- rpois(n=20,lambda=3)
barplot(table(abund2))

# somtimes the environment affects counts 
# to account for that, first create our lambdas 
# then use lambdas to get counts 

# use a regression to get initial values 
pre.lambda <- beta0+beta1*x
# inverse log to make lambdas positive 
lambda <- exp(pre.lambda)

# use created lambda values to get counts 
abund3 <- rpois(n=20,lambda=lambda)
hist(abund3)

# Part 3: Occupancy, presence/absence data (probabilities of sucess) 
# Option #1: Getting probabilities from a beta distribution 
probs <- rbeta(n=20,shape=1,shape2=1)
occ1 <- rbinom(n=20,size=1,prob=probs)
print(occ1)

# Option 2: occupancy with a covariant
# similar to above, except we're generating probabilities, not lambdas 

pre.probs <- beta0 + beta1*x
print(pre.probs)

# convert to a 0-1 scale
psi <- inv.logit(pre.probs)

# create new occupancy data: 
occ2 <- rbinom(n=20,size=1,prob=psi)
print(occ2)