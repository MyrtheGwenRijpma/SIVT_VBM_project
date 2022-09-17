LIBNAME sivt "M:\myrthe SAS\2020\sivt_struct"; 
PROC IMPORT OUT= sivt.struct
            DATAFILE= "M:\myrthe SAS\2020\SIVT_struct\SIVT_CDR_BNT_imp.xlsx"
            DBMS=XLSX REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

TITLE'inspect data and generate M(SD) for table 1';
proc sort data = sivt.struct; by DxPrim; run;
proc means data = sivt.struct; var AgeAtDC_2 Educ MMSETot cdr_plus_cc_ftld cdr_plus_cc_ftld_sob SIVT_Total  BNT_corr_2; run;
proc means data = sivt.struct; var AgeAtDC_2 Educ MMSETot CDRTot BoxScore cdr_plus_cc_ftld cdr_plus_cc_ftld_sob SIVT_Total BNT_corr_2; by DxPrim; run;
proc freq data = sivt.struct; tables  Gender; by DxPrim; run;

TITLE'check for sig group differences for demographics for table 1';
proc glm data= sivt.struct; class DxPrim; model AgeAtDC_2 = DxPrim /SS3 effectsize; lsmeans DxPrim / pdiff=control('NORMAL'); run; quit;  
proc glm data= sivt.struct; class DxPrim; model Gender = DxPrim /SS3 effectsize; lsmeans DxPrim / pdiff=control('NORMAL'); run; quit;  
proc glm data= sivt.struct; class DxPrim Gender; model Educ = DxPrim AgeAtDC_2 Gender/SS3 effectsize; lsmeans DxPrim / pdiff=control('NORMAL'); run; quit; 
proc glm data= sivt.struct; class DxPrim Gender; model MMSETot = DxPrim AgeAtDC_2 Gender/SS3 effectsize; lsmeans DxPrim / pdiff adjust = tukey; run; quit;  
proc glm data= sivt.struct; class DxPrim Gender; model cdr_plus_cc_ftld = DxPrim AgeAtDC_2 Gender/SS3 effectsize; lsmeans DxPrim / pdiff adjust = tukey; run; quit;  
proc glm data= sivt.struct; class DxPrim Gender; model cdr_plus_cc_ftld_sob = DxPrim AgeAtDC_2 Gender/SS3 effectsize; lsmeans DxPrim / pdiff adjust = tukey; run; quit;  
proc glm data= sivt.struct; class DxPrim Gender; model SIVT_Total = DxPrim AgeAtDC_2 Gender /SS3 effectsize; lsmeans DxPrim / pdiff=control('NORMAL'); run; quit; 
proc glm data= sivt.struct; class DxPrim Gender; model BNT_corr_2 = DxPrim AgeAtDC_2 Gender /SS3 effectsize; lsmeans DxPrim / pdiff=control('NORMAL'); quit; 


