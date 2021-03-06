### Updated Feb 8th 2011.

# The goal of this tutorial is.....

# let's have a regression  Y~ N(a+b*x, sd)
par(mfrow=c(2,2))
a=5
b=0.7
x <- seq(2,20)
y_fixed <- a + b*x # we are expressing the relationship between y and x as a linear model. In this case we are generating the data using such a model.
plot(y_fixed~x, main= "Deterministic Component of the model") # A linear model 
abline(a=5, b=0.7)
# But data is generally generated by a noiser (and usually unknown process), so we add some variation. In this case let's say sd=2. Let's think about what this means?

y.sim.1 <- rnorm(length(x), mean=y_fixed, sd=2) # Explain length(x)
plot(y.sim.1~x)
abline(a=5, b=0.7) # Expected relationship based on the (known) parameters we used.

# But what are the estimated values for these parameters  for the regression?
y.sim.1.lm <- lm(y.sim.1 ~ x)
coef(y.sim.1.lm) # This pulls out the estimated coefficients (intercept and slope)
summary(y.sim.1.lm)  # notice parameter estimates and RSE!
confint(y.sim.1.lm) # does it include our expected values
abline(reg=y.sim.1.lm, lty=2) # estimated values based on simulated data.
# The point is, we have now done a little simulation of our regression model. 


# Write a script to repeat this simulation 100 times, describe the distribution of the fitted lines? The estimated coefficients.

simmie.1 <- function() {
	y.sim.1 <- rnorm(length(x), mean=y_fixed, sd=2) # generate a sample from the distribution
	y.sim.1.lm <- lm(y.sim.1 ~ x) # using the new sample, re-run the model
  abline(reg=y.sim.1.lm,lty=2, col="grey", lwd=0.8) # Draw the fitted line for the model
  coef(y.sim.1.lm)  # extract the coeffiecients from this new model
  }

coef.sim <- replicate(n=100, simmie.1()) # repeatedly call the function n times.

coef.sim <- t(coef.sim) # transposing the output from the simulation
dim(coef.sim)
hist(coef.sim[,1], main='estimates of the intercept from simulation')
hist(coef.sim[,2], main='estimates of the slopes from simulation')

sd(coef.sim[,1]) # compare this to the standard error of the intercept
sd(coef.sim[,2]) # compare this to the standard error of the slope
summary(y.sim.1.lm)
# Repeat this, and alter the size of the 'sd' when generating the random variation.  How does this influence your results?




 # In your groups I want you to use this approach to 
 #A) Write a script where you increase the sample size of the experiment, and examine how this influences the estimated slope, and estimated SE. How are these changing?
 # Make a plot ( Estimated values of the slope on the Y axis, sample size on the X)
 # Hint it may be easier to use values of x drawn from a random distribution as well, but you can also use 
 # x <- seq(from=2, to=20, length.out=100) # where you change length.out
 
 # Explain what is happening to the estimated slope as sample size increases?