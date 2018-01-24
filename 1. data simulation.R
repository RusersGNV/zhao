rm(list=ls())
library(boot)

# simulate covariates
n <- 200 # number of sites
x1 <- rnorm(n, mean=0, sd=1) # covariate 1, assume that it's standardized to have 0 mean and unit sd
x2 <- rnorm(n, mean=0, sd=1) # covariate 2, also standardized

# intercept and slopes
alpha <- 0.5
beta1 <- -1
beta2 <- 2
beta3 <- 1
beta4 <- 2
beta5 <- 2

# observation parameters
pobs <- .2 # detection probability
J <- 5 # number of surveys per site

# simulation occurrence probability
pi <- inv.logit(
  alpha + 
  beta1 * x1 + 
  beta2 * x1 ^ 2 + 
  beta3 * x2 + 
  beta4 * x1 * x2 + 
  beta5 * x1 ^ 2 * x2
)

# simulation true, latent status
z <- rbinom(length(pi), 1, pi)

# simulation observed presence/absence
y <- rbinom(length(pi), J, z*pobs)

# put the data together, note that here we assume that the true, latent status z is unknown
data <- data.frame(y, J, x1, x2)
head(data, n=6)

#save(data, file='d:/sim1.RData')


