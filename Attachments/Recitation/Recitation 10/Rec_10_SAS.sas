/************************************************************************************
 *                             P8130 Recitation 10                                  *
 *                     Model Diagnostics and Influential data                       *
 *                                    Nov. 2017                                     *
 ************************************************************************************/ 

PROC IMPORT OUT= 
            DATAFILE= "C:\Users\bioguest.SPH-3DSKSX1-BIO\Downloads\Hospital.csv" 
            DBMS=CSV REPLACE;                                     
     GETNAMES=YES;
     DATAROW=2; 
RUN;

proc contents data=hospital;
run;

proc means data=hospital;
  var los age infrisk cult census nurse facs;
run;

*Suppose we are using the model in 3.c;

proc reg data=hospital;
  model los = age infrisk census;
  output out=hospres(keep=id los age infrisk census r lev cd dffit)
                       rstudent=r h=lev cookd=cd dffits=dffit;
run;

*Let’s examine the studentized residuals as a first approach for identifying outliers;
proc univariate data=hospres plots;
  var r;
run;

*The plots help us see some potential outliers, but it's difficult to indentify the exact observations.
Let’s sort the data on the residuals and show the 10 largest and 10 smallest residuals along with id;
proc sort data=hospres;
  by r;
run;

proc print data=hospres(obs=10);
var id los age infrisk census r;
run;

proc print data=hospres(firstobs=104 obs=113);
var id los age infrisk census r;
run;

*We can show all of the variables in our regression where the studentized residual exceeds +2.5 or -2.5, 
i.e., where the absolute value of the residual exceeds 2.5;

proc print data=hospres;
  var r id los age infrisk census;
  where abs(r)>2.5;
run;

* Let’s look at the leverages to identify observations that will have potential great influence on regression coefficient estimates;
proc univariate data=hospres plots plotsize=30;
  var lev;
run;

proc sort data=hospres;
  by lev;
run;

proc print data=hospres (firstobs=94 obs=113);
  var lev id los age infrisk census;
run;

*Generally, a point with leverage greater than (2k+2)/n should be carefully examined, where k is the number of predictors 
and n is the number of observations. In our example this works out to (2*3+2)/113 = .07079646;

proc print data=hospres;
  var lev id los age infrisk census;
  where lev > .07079646;
run;

*let’s look at Cook’s D and DFFITS.  These measures both combine information on the residuals and leverages. ;
*The lowest value that Cook’s D can assume is zero, and the higher the Cook’s D is, the more influential
  the point is. The conventional cut-off point is 4/n or 0.5. We can list any observation above the cut-off point
  by doing the following. Which is the largest value?;
proc print data=hospres;
  where cd > (4/113);
  var id los age infrisk census cd;
run;

* The conventional cut-off point for DFFITS is 2*sqrt(k/n). DFFITS can be either positive or negative,
  with numbers close to zero corresponding to the points with small or zero influence.;
proc print data=hospres;
  where abs(dffit)> (2*sqrt(3/113));
  var id los age infrisk census dffit;
run;

* Additional measures of influence: DFBETA.

* The above measures are general measures of influence. We can also consider more specific measures 
  of influence that assess how each coefficient is changed by deleting the observation, i.e., DFBETA; 
* In SAS, we need to use the ods output OutStatistics statement to produce the DFBETAs for each of the predictors. 
  The names for the new variables created are chosen by SAS automatically and begin with DFB_. ;

proc reg data=Hospital;
  model los = age infrisk census / influence;
  ods output OutputStatistics=hospdfbetas;
  id id;
run;

*Let’s look at the first 5 values. ;
proc print data=hospdfbetas (obs=5);
  var id  DFB_age DFB_infrisk DFB_census;
run;

*The value of DFB_INFRISK for id = 1 is 0.0451, which means that by being included in the analysis (as compared to being excluded), 
ID#1 increases the coefficient for INFRISK by 0.0451  standard errors, i.e., 0.0451 times the standard error for BSingle or by (0.0451 * 0.11323). 
Because the inclusion of an observation could either contribute to an increase or decrease in a regression coefficient, 
DFBETAs can be either positive or negative.  A DFBETA value in excess of  2/sqrt(n) merits further investigation. In this example, 
we would be concerned about absolute values in excess of 2/sqrt(113) or 0.188144.;

*We can list those observations with DFB_infrisk larger than the cut-off value.  ;
proc print data=hospdfbetas;
  where abs(DFB_infrisk) > 2/sqrt(113);
  var DFB_infrisk id;
run;
