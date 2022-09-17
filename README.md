# SIVT_VBM_project
This repository contains all code used for the SIVT VBM manuscript

## Data availability
Patient data can be requested through the UCSF resources portal http://memory.ucsf.edu/resources/data.
Data request would requires a submission of the Material Transfer Agreement, which is available at https://icd.ucsf.edu/material-transfer-and-data-agreements.

## Usage

# 09-17-2022_SIVT_regression_diagnostics.sas
Regression diagnostics analyses include a combination of standard SAS procedures: https://blogs.sas.com/content/iml/2021/03/24/regression-diagnostic-plots-sas.html, and procedures from the UCLA statistics department: https://stats.oarc.ucla.edu/sas/dae/robust-regression/. 

# 09-17-2022_SIVT_behav.sas
This script includes calculation of the mean and standard deviation of the primary metrics used in this study, and general linear models of demographic information, disease severity measures and primary test results, divided by diagnostic groups. Dunnett Hsu post Hoc tests are included to compare to the healthy control group, and Tukey-Kramer post hoc tests are included to compare between each diagnostic group.

# 09-17-2022_SIVT_MICE_imput.R
MICE imputation was conducted using the following procedure: https://stefvanbuuren.name/fimd/sec-toomany.html.
More information about applying MICE imputations: https://cran.r-project.org/web/packages/mice/index.html

# co_atrophy_ggplot.R
The R ggplot package is used to plot the distribution of the primary performance metric (SIVT score) against structural volume in key neuromorphometric structures. Diagnostic groups are color coded to visualize distribution.

# FSLmath_atrophy_variance_map.txt
Includes an example (test) code that can be used in FSL math through the terminal. The entire code has to be run for each individual in the sample.
