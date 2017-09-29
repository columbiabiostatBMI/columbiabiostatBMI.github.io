################################################################
#             Biostatistical Methods I: Lecture 6              #
#            Statistical Inference: One-Sample Mean            #
#           Author: Cody Chiuzan; Date: Sept 25, 2017          #
################################################################

rm(list=ls())


# Construct a 95% CI for n=10, mu=175, and known sigma=15
# Sigma represents the pooulation standard deviation
# 1-(alpha/2)=1-(0.05/2)=0.975

LCLz<-175 - qnorm(0.975) * 15/sqrt(10)
UCLz<-175 + qnorm(0.975) * 15/sqrt(10)
CLz<-c(LCLz, UCLz)

# What if we want a 99% CI?
LCLz<-175 - qnorm(0.995) * 15/sqrt(10)
UCLz<-175 + qnorm(0.995) * 15/sqrt(10)
CLz<-c(LCLz, UCLz)

# Notice that increasing the confidence level (decreasing alpha),
# leads to a wider confidence interval.


#################################################################
#                 Student's t-distribution                      #
#################################################################

# Student's t distributions with various degrees of freedom 
# Comparison to the normal distribution

# Function dt() calculates the density for t-distribution

x <- seq(-5, 5, length=100)
densnorm <- dnorm(x)

df <- c(1, 2, 5, 29)
colors <- c("red", "blue", "green", "orange", "black")

# Export the plot as a .pdf file

pdf("O:\\Teaching\\Methods1\\P8130\\Lectures\\Lecture6\\tDistr1.pdf", width = 10.0, height = 7)

plot(x, densnorm, type="l", lty=2, xlab="x", ylab="Density", main="Student's t Distributions")

for (i in 1:4){
  lines(x, dt(x,df[i]), lwd=2, col=colors[i])
}

legend("topright", legend=c("df=1", "df=2", "df=5", "df=29", "normal"), 
        bty='n', lwd=2, lty=c(1, 1, 1, 1, 2), col=colors)

dev.off()



# Construct a 95% CI for n=10 => df=10-1=9, mu=175, and known s=15
# s represents the sample standard deviation

LCLt<-175 - qt(0.975, df=9) * 15/sqrt(10)
UCLt<-175 + qt(0.975, df=9) * 15/sqrt(10)
CLt<-c(LCLt, UCLt)



# We want to test the hypothesis that mothers with low socio-economic status
# deliver babies with lower than 'normal' birthweights. 
# Suppose the true mean birthweight follows a normal distribution with
# mean of 120oz and standard deviation of 24oz.

# Generate data and randomly select a random sample of 50.
set.seed(3)
bweight<-rnorm(50,120,24)

# Using the sample generated above, perform a t-test to test the hypotheses:
# The true mean birthweight is different than 120oz
# Use alpha=0.05

t.test(bweight, alternative='two.sided', mu=120)

# Output from R #
# One Sample t-test

# data:  bweight
# t = -0.50797, df = 49,                                     # test statistic: t=-0.51 > -qt(0.975,49) => fail to reject H0
# p-value = 0.6138                                           # p-value >0.05 => fail to reject H0
# alternative hypothesis: true mean is not equal to 120
# 95 percent confidence interval: 112.3968 124.5350          # 95% CI for the true mean weight: (112.4,124.5)
# sample estimates:mean of x 118.4659                        # Xbar=118.5


# The true mean birthweight is less than 120oz
# Use alpha=0.05
t.test(bweight, alternative='less', mu=120)


# The true mean birthweight is greater than 120oz
# Use alpha=0.05
t.test(bweight, alternative='greater', mu=120)


# Class exercises:

# 1. Write your own code to test the two-sided hypotheses: mean not equal to 120oz
#alpha = 0.05

##########################################################################
#   Solution by: Maciejewski, Kaitlin & Angel Garcia de la Garza         #
##########################################################################
n = 50
mu_0=120
alpha=0.05

# t-critical value for alpha=0.05 and (50-1) df to compare
qt(.975, df =49)                                             
# tcrit=2.009575

# Generate data and randomly select a random sample of 50.
set.seed(3)
bweight<-rnorm(50,120,24)
x_bar <- mean(bweight)
s <- sd(bweight)

# Calculate the test statistic observed from the data
test_stat = ((x_bar-mu_0)/ (s/(sqrt(n))))
#test_stat=0.5079659


# We compare t_star to the critical value
# Since the absolute value of the test statistic is less than the t-critical value, 
# we fail to reject H_0 at the 95% confidence level

if (abs(test_stat) > qt(1 - (alpha/2), length(bweight) - 1)) {
    print("We reject the null that sample mean is 120")
# Otherwise
}else{
    print("We fail to reject the null that sample mean is 120")}
   
  
# Calculate the p-value for two-sided t-test
p.value<-2*pt(0.5079659, 49, lower=FALSE)
# p.value=0.6137564

#### To confirm solution by hand:

t.test(bweight, alternative = "two.sided", mu = 120)

# One Sample t-test
# 
# data:  bweight
# t = -0.50797, df = 49, p-value = 0.6138
# alternative hypothesis: true mean is not equal to 120
# 95 percent confidence interval:
#   112.3968 124.5350
# sample estimates:
#   mean of x 
# 118.4659 
# 




##########################################################################
#                  Solution by: Cai, Manqi & Yue, Leiyu                  #
##########################################################################

# 2. Generate 100 samples of size 100 from the N(120,24).
# Perform a one-tailed t-test (< 120) for each of the samples and
# compute the proportion of samples for which we declare significance at alpha=0.05.
# Does the proportion change for a larger number of samples?


set.seed(1)
z = 0
for (i in 1:100) {
  ex_100 <- rnorm(100,120,24)
  t_100 <- t.test(ex_100, alternative = 'less', mu = 120)
  if (t_100$p.value < 0.05) {
    z = z + 1
  }
}
# Compute the proportion of samples for which we declare significance at alpha=0.05.
z/100
#[1] 0.06

# Does the proportion change for a larger number of samples?
set.seed(2)
z = 0
for (i in 1:10000) {
  ex_large_num <- rnorm(100,120,24)
  t_10000 <- t.test(ex_large_num, alternative = 'less', mu = 120)
  if (t_10000$p.value < 0.05) {
    z = z + 1
  }
}

# Calculate the proportion of a larger sample
z/10000
#[1] 0.0521



