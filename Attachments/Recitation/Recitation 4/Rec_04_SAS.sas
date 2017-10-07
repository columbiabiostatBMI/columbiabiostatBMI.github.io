/***************************************************************************************************
*                                       P8130 Recitation 04                                        *
***************************************************************************************************/

/***************************************************************************************************
*                               Analysis of Variance (ANOVA)                                       *
*                              Summary statistics: PROC FREQ                                       *
*                      One- and Two-Sample test for Binomial Proportion(s)                         *
*          	Estimation of Power and Sample size for comparing two binomial proportions             * 
****************************************************************************************************/


****************************************************************************************************
*                                   One-Way ANOVA                                                  *
****************************************************************************************************;

*Input data (example from lecture 8);
data insulin;
input insulin trtgroup mouse @@;
cards;
1.53 1 1 1.61 1 2 3.75 1 3 2.89 1 4
3.26 1 5 3.15 2 1 3.96 2 2 3.59 2 3
1.89 2 4 1.45 2 5 1.56 2 6 3.89 3 1
3.68 3 2 5.70 3 3 5.62 3 4 5.79 3 5
5.33 3 6 8.18 4 1 5.64 4 2 7.36 4 3
5.33 4 4 8.82 4 5 5.26 4 6 7.10 4 7
5.86 5 1 5.46 5 2 5.69 5 3 6.49 5 4
7.81 5 5 9.03 5 6 7.49 5 7 8.98 5 8
;
run;

proc print data = insulin;
title;
run;


/*One-way ANOVA and Model Assumption checking*/
proc glm data = insulin plots=diagnostics(unpack);
class trtgroup;
model insulin=trtgroup;
means trtgroup/ HOVTEST=BF; 
run;

* Plots = diagnostic(unpack) used for checking model assumptions:
Residual vs fitted values plot - constant variance check (look for random pattern)
QQplot - normality check (look for linear trend);

* HOVTEST=BF option generats the Brown-Forsythe test (with P-value)
used to assess constant variance assumption (homoscedasticity)
Available only for One-Way ANOVA;
 

/*Multiple Comparisions*/
proc glm data = insulin;
class trtgroup;
model insulin = trtgroup;
means trtgroup/ bon; *tukey dunnett("B") scheffe;  
run;
 

/************************************************************************************
*           PROC FREQ: summary statistics for categorical variables                 *
*************************************************************************************/ 
*Read the demo.sas7bdat dataset;
data demo14;
set 'C:\Users\bioguest.SPH-3DSKSX1-BIO\Downloads\demo.sas7bdat';
run;
*The data set can be found on Canvas or the course website;

proc freq data=demo14;
tables gender;                            * One-way table;
run;

proc freq data=demo14;
tables gender*state;                      * Two-way table;
run;

proc freq data=demo14;
tables selfcough*gender*state;                 * Three-way table;
run;

proc freq data=demo14;
tables selfcough*gender*state / norow;         * Eliminate row percentages;          
run;

proc freq data=demo14;
tables selfcough;                            * One-way table;
run;



/************************************************************************************
*             One- and Two-Sample test for Binomial Proportion(s)                   *
*************************************************************************************/ 

/** One Sample Test for Proportion  **/
*Example: Researchers want to test if the proportion of patients who soes not have self-cough is different from 25%.;

proc freq data=demo14 order = data;
  exact binomial;
  tables selfcough / binomial (p=.75);
run; 


/*Suppose you have a grouped data but not individual data*/
data proportion;
input gender $ response $ count;
cards;
Men Yes 88
Men No 32
Women Yes 85
Women No 55
;
run;

proc freq data = proportion order = freq;
weight count;
tables response / binomial (p=0.5);
run;


/** Two Sample Test for Proportions  **/ 

proc freq data=demo14 order = data;
  exact binomial;
    tables gender*selfcough / riskdiff(equal var=null cl=wald);  
run; 




****************************************************************************************************
*            Estimation of Power and Sample size for comparing two binomial proportions            *
****************************************************************************************************;


/*Computing Power given sample size*/

proc power;
   twosamplefreq test = pchi
   alpha = 0.05
   groupproportions = (0.25 0.40)
   nullproportiondiff = 0
   groupweights = (1 1)
   ntotal = 200
   power = .;
run;




/*Computing Computing Sample Size Given Power*/ 


proc power;
   twosamplefreq test = pchi
   alpha = 0.05
   groupproportions = (0.25 0.40)
   nullproportiondiff = 0
   npergroup = .  /*could also do ntotal = . here*/
   power = 0.80;
run;



/*Computing Sample Size Given Power (Unbalanced Groups)*/
* alpha = 0.05, power = 0.80, 2 to 1 ratio new:standard';
proc power;
   twosamplefreq test = pchi
   alpha = 0.05
   groupproportions = (0.25 0.40)
   nullproportiondiff = 0
   groupweights = (1 2)
   ntotal = .
   power = 0.80;
run;
ods rtf close;

 
 
