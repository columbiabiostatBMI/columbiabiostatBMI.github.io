################################################################
#             Biostatistical Methods I: Lecture 12             #
#                    Simple Linear Regression                  #
#           Author: Cody Chiuzan; Date: Oct 24, 2017           #
################################################################

rm(list=ls())

## Install and load the following libraries
install.packages(c("faraway","broom","dplyr"))

library(faraway)
library(broom)
library(dplyr)

# Load data diabetes
data(diabetes)
names(diabetes)
summary(diabetes)

# Plot (Y) chol vs age (X)
plot(diabetes$age, diabetes$chol)
reg_diab<-lm(diabetes$chol~diabetes$age)

# Summarize regression
summary(reg_diab)
tidy(reg_diab)
glance(reg_diab)

# Regression objects
names(reg_diab)

# Get fitted.values
reg_diab$fitted.values

# Scatterplot and regression line overlaid
plot(diabetes$age, diabetes$chol)
abline(reg_diab,lwd=2,col=2)


# Calculate the coef estimates 'by hand'
# Set seed for reproductibility
set.seed(1)

data = data.frame(x = rnorm(30, 3, 3)) %>% mutate(y = 2+.6*x +rnorm(30, 0, 1))
linmod = lm(y~x, data = data)
summary(linmod)
tidy(linmod)
glance(linmod)

beta1 = with(data, sum((x - mean(x))*(y - mean(y))) / sum((x - mean(x))^2))
beta0 = with(data, mean(y) - beta1*mean(x))
c(beta0, beta1)
