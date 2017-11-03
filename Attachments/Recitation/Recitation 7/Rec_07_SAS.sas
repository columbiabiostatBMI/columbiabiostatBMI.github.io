/*****************************************************************/
/*                      P8130 Recitation 07                      */
/*                    Simple Linear Regression                   */
/*****************************************************************/

* Kutner 1.21;
 data airfeight;
 input x y ;
 datalines;
   16.0    1.0
    9.0    0.0
   17.0    2.0
   12.0    0.0
   22.0    3.0
   13.0    1.0
    8.0    0.0
   15.0    1.0
   19.0    2.0
   11.0    0.0
   ;
   run;
 
proc print data = airfeight;
run;

proc reg data = airfeight;
model y = x;
plot y*x / nostat cline = red;
run; 

* Another example;
proc print data = diab (keep = glyhb weight);
run;

proc reg data = diab;
model glyhb = weight;
plot glyhb*weight / nostat cline = red;
run;
 
proc reg data=diab;
model glyhb = weight / clb;  
output out=lin p=pred r=res;
run;

* Obtain the normality test;
proc univariate data=lin normal;
var res;
qqplot res;
run;
  
