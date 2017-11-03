################################################################
#             Biostatistical Methods I: Lecture 14             #
#                    Simple Linear Regression                  #
#           Author: Cody Chiuzan; Date: Nov 2, 2017           #
################################################################

rm(list = ls())

# Load libraries
library(faraway)
library(broom)
library(dplyr)

# Read data 'Hospitals'
setwd("O:\\Teaching\\Methods1\\P8130\\Lectures\\Lecture14")
data_hosp<-read.csv("Hospital.csv")
names(data_hosp)

# Plot (Y) vs (X)
# LOS: length of stay
# BEDS: number of beds
plot(data_hosp$LOS, data_hosp$BEDS)


# Simple linear regression
reg_hos<-lm(data_hosp$LOS~data_hosp$BEDS)

# Analyze the regression results
summary(reg_hos)

tidy(reg_hos)

glance(reg_hos)$sigma


# Scatterplot and regression line overlaid
plot(data_hosp$BEDS,data_hosp$LOS)
abline(reg_hos,lwd=2,col=2)


# How do we calculate the 95% CI for the slope?
# Interpretation: 95% CI for the expected difference for 1 bed differene
# Get the critical t value for alpha=0.05 and n-2 df

qt(0.975,df?)  # In data hospital, df=n-2=113-2=111

coef<-summary(reg_hos)$coefficients[2,1] 
err<-summary(reg_hos)$coefficients[2,2] 
slope_int<-coef + c(-1,1)*err*qt(0.975, 111)

# CIs for both slope and intercept
confint(reg_hos)
confint(reg_hos,level=0.9)


# How do we calculate the 95% CI for 100 beds difference?
coef<-summary(reg_hos)$coefficients[2,1] 
err<-summary(reg_hos)$coefficients[2,2] 
slope_int<-100*coef + c(-1,1)*(100*err)*qt(0.975, 111)


# How do we calculate the 95% CI for mean Y_hat?
mean_Y_hat=function(dataset, x, y, n, conf.level=0.95){

# Create regression object    
  reg<-lm(y~x)
  
#Get the number of observations n
  n<-dim(dataset)[1]
  
  Upper_limit=reg$coefficients[1]+reg$coefficients[2]*x+
    qt(0.5*(1 + conf.level), n-2)*sqrt(sigma(reg)^2*(1/n+(x-mean(x))^2/sum((x-mean(x))^2)))
  Lower_limit= reg$coefficients[1]+reg$coefficients[2]*x-
    qt(0.5*(1 + conf.level), n-2)*sqrt(sigma(reg)^2*(1/n+(x-mean(x))^2/sum((x-mean(x))^2)))
  list(Upper_limit,LL=Lower_limit)
}

pred.clim=mean_Y_hat(data=data_hosp,x=data_hosp$BEDS,y=data_hosp$LOS,113)
pred.clim[1]
pred.clim[2]


# Calculate 95% CIs for fitted values using predict function
pred.clim<-predict.lm(reg_hos, interval="confidence") 
datapred<-data.frame(cbind(data_hosp$BEDS,data_hosp$LOS,pred.clim))

plot(datapred[,1],datapred[,2])

#abline(reg_hos,lwd=2,col=2)
lines(datapred[,1],datapred[,3], lwd=2)
lines(datapred[,1],datapred[,5], lty=3, col=3, type='p')
lines(datapred[,1],datapred[,4], lty=3, col=3,type='p')


# Calculate the correlation between LOS and BEDS
cor(data_hosp$LOS, data_hosp$BEDS)

# Look at the R_squared. How does it compare to the correlation?
cor(data_hosp$LOS, data_hosp$BEDS)^2


# Class exercise: send the solution by email by Thursday (11/02) 5:00pm

# How do we calculate the 95% prediction interval for a new (single) value Xh?
# Let's say Xh=200 beds





