/*****************************************************************/
/*                      P8130 Recitation 09                      */
/*                   Practice Problems in SAS                    */
/*****************************************************************/

*6.5.a;
Data BrandPref;
infile "C:\Users\bioguest.SPH-3DSKSX1-BIO\Desktop\BrandPref.txt";
input y x1 x2;
run;

*Scatter Plot Matrix;
PROC SGSCATTER DATA=BrandPref; 
     MATRIX y x1 x2;
	 title "Scatter Plot Matrix - Brand Prefrence example";
RUN; 

*Correlation Matrix;
PROC CORR DATA =BrandPref NOPROB OUT=fullcorr;
     VAR y x1 x2;
	 title "Correlation Matrix - Brand Prefrence example";
RUN;

* 6.5.b;
PROC REG DATA =BrandPref;
     MODEL y = x1 x2 ;
	 title "Regression of Y on X1 and X2";
RUN;

*6.6.a;
*The associated p-value (Prob>F) of <.0001 leads to a rejection of the hypothesis 
 and to the conclusion that some of the beta's are not 0;

*6.7.a;
*R^2 is 0.9521;

*7.3.a;
PROC REG DATA =BrandPref;
     MODEL y = x1;
	 title "Regression of Y on X1";
RUN;

PROC REG DATA =BrandPref;
     MODEL y = x2;
	 title "Regression of Y on X2";
RUN;
* The ANOVA table that decomposes the SSR into extra Sum of Squares is calculated based on above 3 tables form the model: (1): y ~ X1 ; (2) y ~ X2 ; (3) y ~ X1 + X2.
SSE(X1) was extracted from ANOVA table of model (1); SSE(X1, X2) was extracted from ANOVA table of model (3).

  SSR(X1) = 1566.45000
  SSR(X2|X1) = SSE(X1) - SSE(X1, X2) = 400.55000 - 94.30000 = 306.25;

*7.3.b;
* According to the regression model of Y on X1 and X2, the t* test statistic is 6.50, with p-value < 0.0001,
  X2 cannot be dropped from the regression model.;

* Or, we can use F test;
PROC REG DATA =BrandPref;
     MODEL y = x1 x2;
     X2: test x2 = 0;
RUN;
  * F* = 42.22 > F_{1,13,0.01}=9.07, reject H0, X2 cannot be dropped from the regression model.
  * Note that t*^2 = (6.498)^2 = 42.22 = F*, the two test statistics are equivalent, just as for SLR;
 




