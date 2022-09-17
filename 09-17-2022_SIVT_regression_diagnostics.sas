LIBNAME sivt "M:\myrthe SAS\2020\sivt_struct"; 
PROC IMPORT OUT= sivt.struct
            DATAFILE= "M:\myrthe SAS\2020\SIVT_struct\SIVT_struct\SIVT_CDR_BNT_imp.xlsx" 
            DBMS=XLSX REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

TITLE'regression diagnostics: https://blogs.sas.com/content/iml/2021/03/24/regression-diagnostic-plots-sas.html';
proc reg data = sivt.struct plots = (DiagnosticsPanel ResidualPlot(smooth)); model SIVT_total = AgeAtDC_2 Gender; quit;
*effects not significant, assuming that confounds do not have a significant effect on the model;

TITLE'other statistics: https://stats.oarc.ucla.edu/sas/dae/robust-regression/';
proc reg data = sivt.struct;
  model SIVT_total = AgeAtDC_2 Gender ;
  output out = t student=res cookd = cookd h = lev;
run;
quit;

data t; set t;
  resid_sq = res*res;
run;

proc sgplot data = t;
  scatter y = lev x = resid_sq / datalabel = PIDN;
run;
quit;

proc print data = t;
  where cookd > 4/177;
  var PIDN SIVT_total AgeAtDC_2 Gender cookd;
run;
*If any, there may be one outlier but not necessary to delete;

