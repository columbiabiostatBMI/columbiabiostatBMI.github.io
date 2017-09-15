
/************************************************************************************
 *          P8130 Recitation 1: Reading data in SAS and Descriptive Statistics      *
 *                                   Sept. 2017                                     *
 ************************************************************************************                                      
 * Reading different types of data                                                  * 
 * Data description, printing                                                       *
 * Summary statistics: PROC MEANS and PROC FREQ                                     *
 * Exploratory graphs: histograms, box plots, scatter plots                         *
 ************************************************************************************/

/************************************************************************************
 *                        Reading data using INPUT statement                        *
 ************************************************************************************/
* The following data step inputs 6 variables for 4 individuals;
data sbp;
  input pat_name $ pat_id gender $ year1 year2 year3;               /*year1-year3*/
  cards;
  John  1002 M 90 120 125
  Alice 1003 F 140 148 116
  Mike  1004 F 121 130 117
  Barbara 1005 M 151 144 148
;
run;

proc print data=sbp;
run;

data height_weight;
	input id height weight @@;
	cards;
	1 60 120 2 67 131 3 64 145
	4 63 111 5 69 168 6 69 200
	;
run;

proc contents data=height_weight;              /* varnum - list in the same order as in the data set */ 
run;

proc print data=height_weight (obs=3);
run;



/*************************************************************************************
*                    Read external data using INFILE statement                       *
**************************************************************************************/
* Evaluate people suspected of having either iron deficiency or iron overload: 
* Binding capacity, transferrin saturation, etc.;

data iron;
infile 'C:\Users\bioguest.SPH-6HKJSX1-BIO\Downloads\Lecture 1 Data step and Informat\iron.dat';  *where to find data;
input ID $ serferr ironaa tibcaa trnsfrec trnsfia; *variable names;
run;

proc print data = iron;
run;


/*************************************************************************************
 *                     Use PROC IMPORT to read CD_count.csv                          *
 ************************************************************************************/

PROC IMPORT OUT= WORK.CD_COUNTS 
            DATAFILE= "path\CD_counts.csv" 
            DBMS=CSV REPLACE;                                       * DBMS specifies the type of file to import: .xls, .xlsx, .sav, etc.;
     GETNAMES=YES;
     DATAROW=2; 
RUN;



/*************************************************************************************
 *                     Use Import Wizard to read CD_count.csv                        *
 ************************************************************************************/


/************************************************************************************
*                           Reading SAS dataset                                     *
*************************************************************************************/
* Modify data cdcounts imported from the .csv file specifeid above;

/* Use SET statement */
data demo14;
set 'C:\Users\bioguest.SPH-6HKJSX1-BIO\Downloads\Lecture 3 Descriptive Statistics\demo.sas7bdat';
run;
proc contents data=demo14 varnum;
run;



/************************************************************************************
*           PROC MEANS: summary statistics for continuous variables                 *
*************************************************************************************/ 
data prob3;
input id $ hr @@;
cards;
1 165	2 145	3 115	4 110	5 150	
6 145	7 38	8 140	9 122	10 155
;
run;

proc means data = prob3 ;
run;

proc means data = prob3 median q1 q3 qrange nmiss mode;
run;

proc univariate data = prob3 plot;
var hr;
run;



/************************************************************************************
*                                 Exploratory graphs                                *
*************************************************************************************/ 

data prob2;
input id $ time @@;
cards;
1 113	2 118	3 121	4 123	5 126	
6 128	7 130	8 135	9 136	10 137
11 138	12 139	13 140	14 140	15 142	
16 142	17 142	18 142	19 143	20 155
21 157	22 157	23 158	24 159	25 164
;
run;

* PROC UNIVARIATE - histogram;
proc univariate data=prob2 noprint;
var time;
histogram time ;                           */ midpoints= (110 to 170 by 5)  ;
run;

* Normality check;
proc univariate data=prob2;
histogram time / normal(percents=20 40 60 80);
inset n normal(ksdpval) / pos = ne;                    * Create a normal quantile-quantile plot;
run;
 
* PROC UNIVARIATE - boxplot and qqplot;
proc univariate data=prob2 plot;
var time;
run;








