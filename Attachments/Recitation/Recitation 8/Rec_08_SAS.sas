/*****************************************************************/
/*                      P8130 Recitation 08                      */
/*                    Simple Linear Regression                   */
/*****************************************************************/

PROC IMPORT OUT= GPA
            DATAFILE= "C:\Users\bioguest.SPH-3DSKSX1-BIO\Downloads\GPA.csv" 
            DBMS=CSV REPLACE;  
     GETNAMES=YES;
     DATAROW=2; 
RUN;
 
PROC CORR data = GPA plots = scatter (ellipse= none);
  var GPA ACT;
RUN;


* Kutner 2.4;
* 2.4 a; 
proc reg data=GPA;
model GPA = ACT /CLB ALPHA = 0.01;   
run;

*2.4 b&c;
PROC CORR data = GPA  Fisher(alpha = 0.01);
  var GPA ACT;
RUN;
 

*Kutner 2.13 a&b;
Data Xvalue;
INPUT ACT GPA;
CARDS;
28 .
;
run;

Data GPA;
SET GPA Xvalue;
run;

proc reg data=GPA;
model GPA = ACT /CLM CLI ALPHA = 0.05;   
run;

/* The option CLM will give us CIs for the expected value of Y */
/* The option CLI will give us CIs for the individual predicted value of Y */
