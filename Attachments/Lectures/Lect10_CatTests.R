################################################################
#             Biostatistical Methods I: Lecture 10              #
#          Contingency Tables: Tests for Categorical Data       #
#           Author: Cody Chiuzan; Date: Oct 10, 2017            #
################################################################

rm(list=ls())

################################################################
#                      Chi-Squared Test                        #
################################################################

# Marijuana usage among colleg students

drug_data<-matrix(c(57,50,43,57,58,20,56,45,24,45,22,33), nrow=4,ncol=3,byrow=T,
           dimnames=list(c("freshman","sophomore","junior","senior"),c("experimental","casual","modheavy")))

drug_data

chisq.test(drug_data)

# X-squared = 19.369, df = 6, p-value = 0.003584
# We reject the null hypothesis and conclude that the proportions of usage are different among classes


###############################################################
#      Fisher's Exact test for small cell counts (<5)         #
###############################################################

practice_data<-matrix(c(1,8,9,3), nrow=2,
              dimnames=list(c("diet","non-diet"),c("men","women")))

chisq.test(practice_data)
# Pearson's Chi-squared test with Yates' continuity correction for 2X2 table
# X-squared = 6.0494, df = 1, p-value = 0.01391
# Warning message:
# In chisq.test(practice_data) : Chi-squared approximation may be incorrect

fisher.test(practice_data)
# Fisher's Exact Test for Count Data
# p-value = 0.007519  # Notice the difference in p-values b/w chi-squared and Fisher


###############################################################
#      McNemar Test for binomial matched-pair data            #
#               Normal approximation                          #
###############################################################

# Two procedures are tested on the same 75 subjects 
# in order to identify the absence/presence of the disease

procedure_data<-matrix(c(41,8,14,12), nrow=2,byrow=T,
               dimnames=list(c("positive","negative"),c("positive","negative")))

mcnemar.test(procedure_data)

# McNemar's Chi-squared test with continuity correction
# McNemar's chi-squared = 1.1364, df = 1, p-value = 0.2864

# What if you performed a chi-squared test instead? 
chisq.test(procedure_data)

# X-squared = 6.278, df = 1, p-value = 0.01222
# Notice that the conclusion would be totally different.



