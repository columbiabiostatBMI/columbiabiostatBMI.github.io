###########################################################
# Title: P8130 Recitation 3: Oct 2nd/4th
#
# Author: Yutao Liu
#
# R version: 3.3.2
###########################################################

rm( list = ls() ) # clear workspace

if ( !require(pacman) ) install.packages('pacman')
pacman::p_load(dplyr, ggplot2)
pacman::p_load(pwr)

### Sample Size Calculation 

power.t.test(power = .90, delta = 4.7, sd = 6.99)

pwr.t.test(d = 4.7/6.99, power = .90, type = 'two.sample')

### Simulation-Based Type I Error/Power Evaluation

sigma <- 6.99;
delta <- 4.7;
n <- 48

rej <- function(delta, sigma, n, null, alpha = .05) {
  
  grp1 <- rnorm(n, 0, sigma)
  
  if (null) {
    grp2 <- rnorm(n, 0, sigma)
  } else {
    grp2 <- rnorm(n, delta, sigma)
  }
  
  res <- t.test(grp1, grp2, alternative = 'two.sided', var.equal = FALSE)
  
  return( (rej = res$p.value < alpha) )
  
}

## Type I Error
set.seed(1)
replicate(1e4, rej(delta, sigma, n, null = TRUE), simplify = TRUE) %>%
  mean(.)

## Power
set.seed(1)
replicate(1e4, rej(delta, sigma, n, null = FALSE), simplify = TRUE) %>%
  mean(.)
