################################################################
#             Biostatistical Methods I: Lecture 11              #
#                    Non-parametric Tests                       #
#           Author: Cody Chiuzan; Date: Oct 10, 2017            #
################################################################

rm(list=ls())

####################################################################
# Example 1:
# A small cross-over trial investigates a new treatment for anxiety.
# 10 patients are given one week of drug and one-week of placebo.
# The order of the treatments is randomly assigned in order to 
# reduce the carry-over effect.
# At the end of each week, patients need to complete a questionnaire,
# and a score is calculated corresponding to their state of anxiety.
# Both scores are recorded from the same individual: paired data.

drug<-c(19,11,14,17,23,11,15,19,11,8)
placebo<-c(22,18,17,19,22,12,14,11,19,7)
diff_anx<-drug-placebo

# Checking normality distribution for the differences 
# Skewed data

# Create a histogram using frequencies
hist(diff_anx, xlab="Anxiety Score", freq=T,
     main="Distribution of Anxiety Score Differences")

# If you want to overlay a density curve, than show probabilites 
# and not frequencies on the y-axis
hist(diff_anx, xlab="Anxiety Score",ylim=c(0,0.5), freq=F,
     main="Distribution of Anxiety Score Differences")
mean_anx<-mean(diff_anx)
std_anx<-sqrt(var(diff_anx))
      
curve(dnorm(x, mean=mean_anx, sd=std_anx), col=2, lwd=2, add=TRUE, yaxt="n")

####################################################################
#                  Non-parametric Sign test                        #
#            Uses ony the signs, but not the magnitudes            #
####################################################################

# H0: the median of the diff distribution is zero 

install.packages("BSDA")
library(BSDA)

# Testing the median = 0
SIGN.test(diff_anx, md=0)

#s = 4, p-value = 0.7539
#alternative hypothesis: true median is not equal to 0
#95 percent confidence interval: -5.702222  1.000000

###################################################################
#         Non-parametric Wilcoxon-Signed Rank test                #
#            Uses the magnitudes of the differences               #
####################################################################

# Gives exact p-values for <50 samples, no ties
# Otherwise, gives the normal approximation

wilcox.test(diff_anx)
#OR
wilcox.test(drug, placebo, paired=T)         # default is paired=F, Wilcoxon-Rank Sum

# Wilcoxon signed rank test with continuity correction
# d ata:  diff_anx
# V = 17, p-value = 0.3043
# alternative hypothesis: true location is not equal to 0


#########################################################################
# Example 2:
# Dental measurements (mm) are taken from two groups of boys and girls
girls <- c(23,25.5,26,26.5,23.5,22.5,25,24,21.5,19.5,28)
boys <- c(31,26.5,27.5,27,26,28.5,26.5,25.5,26,31.5,25,28,29.5,26,30,25)

# Testing normality of each group
par(mfrow=c(1,2))
hist(girls, xlab="Dental (mm)", freq=T, main="Girls")
hist(boys, xlab="Dental (mm)", freq=T, main="Boys")

boxplot(boys, girls)
# Data seems skewed for both groups and unequally spread.


###################################################################
#         Non-parametric Wilcoxon-Rank Sum test                   #
#                  Two-independent groups                         #
####################################################################


# H0:  The true median of boys is greater than that of girls,

wilcox.test(boys, girls, alternative="greater", mu=0)

#data:  boys and girls
#W = 150.5, p-value = 0.001074
#alternative hypothesis: true location shift is greater than 0


# What if we used an independent two-sample t-test instead?




