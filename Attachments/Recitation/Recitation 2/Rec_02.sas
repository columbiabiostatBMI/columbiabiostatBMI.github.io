/************************************************************************************
 *            P8130 Recitation 2: Probability Distributions Functions,              *
 *                 Permanent datasets and Output Delivery System                    *
 *                                   Sept. 2017                                     *
 ************************************************************************************                                      
 * Obtain prbability from Binomial/Poisson/Normal distributions                     * 
 * Compute CDF and PDF                                                              *
 * Use LIBNAME statement to create a permanent SAS datasets                         *
 * Use Output Delivery System (ODS) to generate publication-quality output          *
 ************************************************************************************/


/************************************************************************************
 *          Obtaining prbability from Binomial/Poisson/Normal distributions         *
 ************************************************************************************/

/* Code for finding binomial probabilities in SAS */

/* The command PROBBNML computes _cumulative_ binomial probabilities */
/* To get the cumulative probability, the syntax is: probbnml(p, n, x) */

ods rtf file="C:\Users\bioguest.SPH-6DSKSX1-BIO\Downloads\bin_ex1.rtf";
DATA binomial_ex1;
PROB = PROBBNML(0.25,4,1);
RUN;

PROC PRINT DATA = binomial_ex1;
RUN;
ods rtf close;

ods rtf file="C:\Users\bioguest.SPH-6DSKSX1-BIO\Downloads\bin_ex2.rtf";
DATA binomial_ex2; 
PROB = PROBBNML(0.25,4,1)-PROBBNML(0.25,4,0);
RUN;

PROC PRINT DATA = binomial_ex2;
RUN;
ods rtf close;


/*Practice: Suppose our random variable X is binomial with n=20 and p=0.65 */
/* 1. What is the probability of 13 or fewer successes?  P(X <= 13) */
/* 2. What is the probability of 6 or fewer successes? P(X <= 6)  */
/* 3. What is the probability of EXACTLY 13 successes? P(X = 13) */
/* 4. What is the probability of more than 13 successes? P(X > 13) */
/* 5. What is the probability of 13 or more successes? P(X >= 13) */
/* 6. What is the probability of 8, 9, or 10 successes? P(8 <= X <= 10) */


data binom;
  prob1 = probbnml(0.65, 20, 13);
  prob2 = probbnml(0.65, 20, 6);
  prob3 = probbnml(0.65, 20, 13) - probbnml(0.65, 20, 12);
  prob4 = 1 - probbnml(0.65, 20, 13);
  prob5 = 1 - probbnml(0.65, 20, 12);
  prob6 = probbnml(0.65, 20, 10) - probbnml(0.65, 20, 7);
run;

proc print data=binom;
title 'Binomial Probabilities';
run;


/* Code for finding Poission probabilities in SAS */
/* To get the cumulative probability, the syntax is: poisson(lambda, x) */

ods rtf file="C:\Users\bioguest.SPH-6DSKSX1-BIO\Downloads\poi_ex.rtf";
DATA POISSON_EX;
  *Prob(X=0);
  PROB = POISSON(1,0);
  *Prob(X=1);
  PROB1 = POISSON(1,1)-POISSON(1,0);
  *Prob(X=2);
  PROB2 = POISSON(1,2)-POISSON(1,1);
  *Prob(X=3);
  PROB3 = POISSON(1,3)-POISSON(1,2);
PROC PRINT;
title;
RUN;
ods rtf close;


/* Practive: Suppose random variable X is distributed Poission with lambda = 12.33. */
/* 1. What is the probability of 15 or fewer occurrences?  P(X <= 15) */
/* 2. What is the probability of EXACTLY 6 successes? P(X = 6) */
/* 3. What is the probability of more than 13 successes? P(X > 13) */
/* 4. What is the probability of 13 or more successes? P(X >= 13) */
/* 5. What is the probability of 8, 9, or 10 successes? P(8 <= X <= 10) */

data poiss;
  prob1 = poisson(12.33, 15);
  prob2 = poisson(12.33, 6) - poisson(12.33, 5);
  prob3 = 1 - poisson(12.33, 13);
  prob4 = 1 - poisson(12.33, 12);
  prob5 = poisson(12.33, 10) - poisson(12.33, 7);
run;

proc print data=poiss;
title 'Poisson Probabilities';
run;


/* Code for finding Standard Normal probabilities in SAS */
ods rtf file="C:\Users\bioguest.SPH-6DSKSX1-BIO\Downloads\normal_ex1.rtf";
DATA NORMAL_EX1;
  PROB = PROBNORM(1);
PROC PRINT;
title;
RUN;
ods rtf close;

ods rtf file="C:\Users\bioguest.SPH-6DSKSX1-BIO\Downloads\normal_ex2.rtf";
DATA NORMCDF;
   Z=(95-80)/10;
   P_LT95=PROBNORM(Z);
   P_GT95=1-P_LT95; 
PROC PRINT;
title;
RUN;
ods rtf close;

/*Practice: Suppose our random variable Z is standard normal 
 1). What is the probability Z is greater than 1.24?  
 2). What is the probability Z is less than 1.24?  
 3). What is the probability Z is between -0.79 and 1.16? 
 4). What if X is normal with mean 266 and standard deviation 16, 
     what is the probability X is between 260 and 280? */

data norm;
  normp1 = 1 - probnorm(1.24);
  normp2 = probnorm(1.24);
  normp3 = probnorm(1.16) - probnorm(-0.79);
  normp4 = probnorm((280-266)/16) - probnorm((260-266)/16);
run;

proc print data=norm;
title 'Normal Probabilities';
run;


/************************************************************************************
 *                              Compute CDF and PDF                                 *
 ************************************************************************************/

/*Examples of CDF and PDF functions*/
ods rtf file="C:\Users\bioguest.SPH-6DSKSX1-BIO\Downloads\cdf_ex1.rtf";
data normal_CDF;
input x @@;
cprob1=PROBNORM(x); *returns cum.prob. for std. Normal;
cprob2=CDF('NORMAL',x,0,1) ; *returns cum.prob. for any Normal;

*in this case both are the same;
CARDS;
-3 -2 -1 0 1 2 3
;
run;
Proc print data=normal_CDF label;
title "Normal probability distribution, mu=0, sigma=1";
title2 "The empirical rule";
label cprob1="P(X<=x)" cprob2="P(X<=x)";
run;
ods rtf close;


ods rtf file="C:\Users\bioguest.SPH-6DSKSX1-BIO\Downloads\cdf_ex2.rtf";
DATA cdf_ex2;
INPUT x @@;
*if x had decimals we could use cprob=CDF('BINOMIAL',int(x),.3,6);
cprob=CDF('BINOMIAL',x,.3,6);
prob=PDF('BINOMIAL',x,.3,6);
CARDS;
1 2 3 4 5 6
;
RUN;
Proc print data=cdf_ex2 label;
title "Binomial probability distribution, n=6, p=.3";
label prob="P(X=x)" cprob="P(X<=x)";
run;
ods rtf close;
 

/************************************************************************************
 *             Use LIBNAME statement to create a permanent SAS datasets             *
 ************************************************************************************/

 libname rec01 'C:\Users\bioguest.SPH-6DSKSX1-BIO\Downloads';
  data rec01.sbp;
    input pat_name $ pat_id gender $ year1 year2 year3;  
    cards;
       John  1002 M 90 120 125
       Alice 1003 F 140 148 116
       Mike  1004 F 121 130 117
       Barbara 1005 M 151 144 148
    ;
  run;

  
  *Use SET statement to use an existed SAS dataset;
  data newdata;
  set rec01.sbp;
  run;


/************************************************************************************
 *                   Doing Recitation Practice Problems with SAS                    *
 ************************************************************************************/
 
  
data rec02pp;
  prob3_1 = 1 - probbnml(0.03, 15, 2);
  prob3_2 = probbnml(0.04, 12, 2);
  prob4 = poisson(12.4, 23) - poisson(12.4, 22);
  prob5_1 = probbnml(0.197, 25, 3) - probbnml(0.197, 25, 2);
  prob5_2 = 1 - probbnml(0.197, 25, 2);
  prob5_3 = probbnml(0.197, 25, 3);
  prob5_4 = probbnml(0.197, 25, 6) - probbnml(0.197, 25, 3);
proc print;
run;


