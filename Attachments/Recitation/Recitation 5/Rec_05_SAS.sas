/***************************************************************************************************
*                                    P8130 Recitation 05                                           *
*                                        Fall 2017                                                 *
***************************************************************************************************/

/***************************************************************************************************
*                          Chi-squared test, Fisher's Exact test                                   *              
*                                       McNemar test
****************************************************************************************************/
 
proc freq data=demo14;
   tables selfcough*gender /expected chisq exact;
run;


/** Reading in 2x2 data from a table **/
data chi;
   input exposure disease Count @@;
   cards;
1 1 5   1 0 78
0 1 21   0 0 63
;
run;

proc freq data = chi;
  tables exposure*disease / chisq expected; *relrisk riskdiff;
  weight Count;
run;


/***************************************************************************************************
 *                                         McNemar's test                                          *
 ***************************************************************************************************/
ods rtf file = "C:\Users\bioguest.SPH-3DSKSX1-BIO\Downloads\sas.rtf" startpage = no;
Data Procedure;
  input Proc_A $ Proc_B $ count;
  cards;
positive positive 41
positive negative 8
negative positive 14
negative negative 12
;
run;

proc freq data = Procedure order = data;
  table Proc_A*Proc_B/ chisq agree BINOMIALC;
  weight count;
run;
ods rtf close;











