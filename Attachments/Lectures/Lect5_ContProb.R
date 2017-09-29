################################################################
#             Biostatistical Methods I: Lecture 5              #
#   Continuos probability distributions: Uniform and Normal    #
#           Author: Cody Chiuzan; Date: Sept 18, 2017          #
################################################################

rm(list=ls())

# How to calculate integrals in R
f <- function(x){4*x^3}

integrate(f, lower = 0, upper = 1) # Equals 1
integrate(f, lower = 0.2, upper = 0.5) # Equals 0.0609

##########################################
#           Uniform distribution         #
##########################################

# Generate 10 uniform random variables with values b/w 0 and 30.
runif(10, min=0, max=30)

# Given X~Unif(0,30)
# Calculate prob: P(15<x<20) using the diff of cumulative probabilities.

punif(20, min=0, max=30)-punif(15, min=0, max=30) # Equals 0.17=1/6


##########################################
#           Normal distribution          #
##########################################

# Generate normal random variables and create density curves for different means and standard deviations

install.packages("ggplot2")
install.packages("reshape")

library(ggplot2)
library(reshape2)


# Generate n=100 normal random variables with different means and std.
#v1: mean=0, std=1 -> standard normal
#v2: mean=0, std=2 
#v3: mean=-2, std=2 

x <- data.frame(v1=rnorm(100),v2=rnorm(100,0,2),v3=rnorm(100,-2,2))
data<- melt(x)
ggplot(data,aes(x=value, fill=variable)) + geom_density(alpha=0.15)
     
# Calculate normal probablites
# Given a normal distribution wiht mean 70 and std 10.

# Find P(X<=65)
pnorm(65, mean = 70,sd = 10)

# Find P(40<=X<=60)
pnorm(60, mean = 70,sd = 10) - pnorm (40, mean = 70,sd = 10)


# Find a percentile
qnorm(0.92778, mean = 0, sd = 1)

# Important percentiles for probabilities: 0.95, 0.975, 0.995
qnorm(c(0.05, 0.025, 0.005), lower.tail = FALSE)


# Create normal density curves with shaded areas
# This code was taken from:https://www.r-bloggers.com/how-to-shade-under-a-normal-density-in-r/

shadenorm = function(below=NULL, above=NULL, pcts = c(0.025,0.975), mu=0, sig=1, numpts = 500, color = "gray", dens = 40,
                     justabove= FALSE, justbelow = FALSE, lines=FALSE,between=NULL,outside=NULL){
  
  if(is.null(between)){
    below = ifelse(is.null(below), qnorm(pcts[1],mu,sig), below)
    above = ifelse(is.null(above), qnorm(pcts[2],mu,sig), above)
  }
  
  if(is.null(outside)==FALSE){
    below = min(outside)
    above = max(outside)
  }
  lowlim = mu - 4*sig
  uplim  = mu + 4*sig
  
  x.grid = seq(lowlim,uplim, length= numpts)
  dens.all = dnorm(x.grid,mean=mu, sd = sig)
  if(lines==FALSE){
    plot(x.grid, dens.all, type="l", xlab="X", ylab="Density")
  }
  if(lines==TRUE){
    lines(x.grid,dens.all)
  }
  
  if(justabove==FALSE){
    x.below    = x.grid[x.grid<below]
    dens.below = dens.all[x.grid<below]
    polygon(c(x.below,rev(x.below)),c(rep(0,length(x.below)),rev(dens.below)),col=color,density=dens)
  }
  if(justbelow==FALSE){
    x.above    = x.grid[x.grid>above]
    dens.above = dens.all[x.grid>above]
    polygon(c(x.above,rev(x.above)),c(rep(0,length(x.above)),rev(dens.above)),col=color,density=dens)
  }
  
  if(is.null(between)==FALSE){
    from = min(between)
    to   = max(between)
    
    x.between    = x.grid[x.grid>from&x.grid<to]
    dens.between = dens.all[x.grid>from&x.grid<to]
    polygon(c(x.between,rev(x.between)),c(rep(0,length(x.between)),rev(dens.between)),col=color,density=dens)
  }
  
}

# Use shadenorm to illustrate different regions under the normal density curves
#shadenorm()
shadenorm(above=1.46, justabove=TRUE, col="blue")
abline(v=0)

shadenorm(between=c(-1.32, 1.32), col="blue")
abline(v=0)

shadenorm(below=1.46, justbelow=TRUE, col="blue")
abline(v=0)

shadenorm(below=-1.46,above=1.46, col="blue")
abline(v=0)


