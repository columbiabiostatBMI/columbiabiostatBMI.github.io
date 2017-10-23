/***************************************************************************************************
*                                    P8130 Recitation 06                                           *
*                                        Fall 2017                                                 *
***************************************************************************************************/

/***************************************************************************************************
*                       Wilcoxon Signed-Rank and Wilcoxon Rank-Sum tests                           *  
****************************************************************************************************/

/************************************
*        Wilcoxon Rank-Sum test     *
*************************************/;


data hospital_stay;
input hospital $ length_of_stay @@;
datalines;
hosp1 21 hosp1 10 hosp1 32 hosp1 60 hosp1 8 hosp1 44 hosp1 29 
hosp1 5 hosp1 13 hosp1 26 hosp1 33
hosp2 86 hosp2 27 hosp2 10 hosp2 68 hosp2 87 hosp2 76 hosp2 125
hosp2 60 hosp2 35 hosp2 73 hosp2 96 hosp2 44 hosp2 238
;
run;

proc print data = hospital_stay;
run;

 
* Check normality assumption;
proc sort data=hospital_stay;
by hospital;
run;

proc univariate data=hospital_stay NORMAL;
var length_of_stay;
by hospital;
qqplot length_of_stay;
run;
* Reject the null (Shapiro-Wilk p=0.0171) in the Hospital 2 group and cannot assume normality;

proc npar1way data = hospital_stay Wilcoxon;
class hospital;
var length_of_stay;
run;


/*************************************
*     Wilcoxon Signed-Rank test      *
**************************************/;

data sbp;
infile 'C:\Users\tx2155\Downloads\sbp.txt';
input id $ sbp_baseline sbp_1mo diff;
run;

proc print data = sbp;
run;

 
proc univariate data=sbp NORMAL;
var diff;
qqplot diff;
run; 
