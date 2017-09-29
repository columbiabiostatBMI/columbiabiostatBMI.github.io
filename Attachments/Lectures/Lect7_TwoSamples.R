################################################################
#             Biostatistical Methods I: Lecture 7              #
#            Statistical Inference: Two-Sample Means           #
#           Author: Cody Chiuzan; Date: Sept 27, 2017          #
################################################################

rm(list=ls())

################################################################
#   Conduct a paired t-test to test the effect of a new diet   #
################################################################

weight_before<-c(201,231,221,260,228,237,326,235,240,267,284,201)
weight_after<-c(200,236,216,233,224,216,296,195,207,247,210,209)
weight_diff<-weight_after-weight_before
sd_diff<-sd(weight_diff)


test_weight<-mean(weight_diff)/(sd_diff/sqrt(length(weight_diff)))

# Use the t.test() built-in function
# What alternative are you testing?
                          
t.test(weight_after, weight_before, paired=T)

# Testing equality of variances for two independent samples
# drawn from two underlying normal distributions.

# Sample 1: s1=0.16, n1=10
# Sample 2: s2=0.14, n2=10

F_test<-0.16^2/0.14^2

F_crit<-qf(.975, df1=9, df2=9) 

# Compare the F statistic (F_test) to the critical value
# Fcrit: F with 9 dfs in numerator and 9 dfs in denominator
# Because F_test < F_crit, we fail to reject and conclude
# that the pop. variances are not significantly different.


################################################################
#               Two-Sample independent t-test                  #
################################################################

# Effect of caffeine on muscle metabolism.
# 15 men were randomly selected to take a capsule containing pure caffeine one hour before the test.
# The other group of 20 men received a placebo capsule. 
# During each exercise the subject's respiratory exchange ratio (RER) was measured.
# The question of interest to the experimenter was whether, on average, caffeine consumption has an effect on RER.
# The two samples came from two underlying normal distributions: N(94.2,5.6), N(105.5,8.1) and are independent.


# Generate data using past info (ideally, here I made it up).

set.seed(6)
caff<-rnorm(15, 94.2, 5.6)
placebo<-rnorm(20, 105.5, 8.1)

# Test equality of variances: use R function var.test()

var.test(placebo,caff, alternative = "two.sided")

#F = 3.5768, num df = 19, denom df = 14, p-value = 0.01881             # Reject the null, evidence that variances are not equal.


res<-t.test(caff, placebo, var.equal=FALSE, paired=FALSE)               # var.equal=FALSE is the default, so no need to specifically write it.
names(res)

# t = -4.5834, df = 30.125, p-value = 7.472e-05                        # Reject the null and conclude that the means RER are sig diff b/w the two groups.

# 95% CI of the difference: (-17.639668,-6.766628)                     # We could safely say that the mean RER is sig. lower in the caff group (Why?)
