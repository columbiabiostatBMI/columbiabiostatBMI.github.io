/******************************************************************* 
*                       P8130 Recitation 3                         *
*                          Oct. 2017                              *
*               One-sample and two-sample T-tests                  *
*             Power/Sample size calculation for T-test             *
********************************************************************/


/****************************************
*          One-sample T-test;           *
****************************************/

* Import data bonemineral - BMD of 20 subjects;
proc import datafile= 'C:\Users\bioguest.SPH-3DSKSX1-BIO\Downloads\Bonemineral.xls'
			dbms= XLS REPLACE
			out= bonemineral;
	 getnames=YES;
run;

proc print data = bonemineral;
run;

******************************************
*           One-sample T-test            *
******************************************/

* Is the mean BMD different from 1.06?;
proc ttest data=bonemineral h0=1.06 ;  * alpha=0.01, and sides=L,U;
var BMD;
run;
* Don't report just the p-value, but also the 95% confidence interval;


/******************************************
*     Two-sample independent T-test       *
******************************************/

proc ttest data=bonemineral alpha=0.05;
  class Status;
  var BMD;
run; 

 
/********************************************
*       Two-sample paired T-test            *
*********************************************/
* Investigating the effect of a new diet on weight;

data weight;
input wbefore wafter;
cards;
 200 185
 175 154
 188 176
 198 193
 197 198
 310 275
 245 224
 202 188
 ; 

 proc ttest data=weight; 
 paired wbefore*wafter;
 run; 

 /*Another way to test for a difference in weight loss*/
 data weight2;
 set weight;
 diff =  wafter - wbefore;
 run;

 proc ttest data=weight2;
 var diff;
 run;


*************************************************************
*  Power and Sample size for Two-sample independent T-test  *
*************************************************************; 

proc power;
twosamplemeans test=diff
meandiff=4.7     /* Mean diff. */
stddev=6.99       /* Std.dev. */
npergroup=36
power=.
;
run;


proc power;
twosamplemeans test=diff
meandiff=4.7     /* Mean diff. */
stddev=6.99       /* Std.dev. */
npergroup=.
power=0.9
;
run;
 
