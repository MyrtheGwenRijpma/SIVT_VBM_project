#for this script I used: https://stefvanbuuren.name/fimd/sec-toomany.html

setwd("~/Box Sync/science/2020/SIVT_struct/new_dataset")

library(tidyverse)
library(tibble)
library(dplyr)
library(mice)
library(lattice)

#SIVT imputation
SIVT_imp <- read_csv(file = "07-12-2022_SIVT_BNT_171.csv")

#select relevant variables
SIVT2 <- SIVT_imp %>%
  select(c(AgeAtDC, SIVT_Easy, SIVT_Medium, SIVT_Hard, SIVT_Total, PPT_verb,	PPT_des, BNT_corr, MMSETot, Gender, Educ, cdr_plus_cc_ftld_sob))

inlist <- SIVT2 %>%
  select(c(SIVT_Total, PPT_verb,	PPT_des, BNT_corr, MMSETot, AgeAtDC, Gender))

#run quickpred to check the data
pred <- quickpred(SIVT2, minpuc = 0.5, include = inlist)
table(rowSums(pred))

#ready for imputation
imp.qp <- mice(SIVT2, pred = pred, seed = 29725)

#Plotting results
vnames <- c("BNT_corr", "SIVT_Total")
cd2 <- mice::complete(imp.qp)[, vnames]
typ <- factor(rep(c("quickpred"),
                  each = nrow(cd2)))
mis <- ici(SIVT2[, vnames])
mis <- is.na(imp.qp$data$BNT_corr) | is.na(imp.qp$data$SIVT_Total)
cd <- data.frame(typ = typ, mis = mis, rbind(cd2)) 
xyplot(jitter(BNT_corr, 10) ~ jitter(SIVT_Total, 10) | typ,
       data = cd, groups = mis,
       col = c(mdc(1), mdc(2)),
       xlab = "SIVT total score",
       type = c("g","p"), ylab = "BNT imputation",
       pch = c(1, 19),
       strip = strip.custom(bg = "grey95"),
       scales = list(alternating = 1, tck = c(1, 0)))

#final imputation
imp.qp2 <- mice(SIVT2, pred = pred, m = 10, maxit = 50, seed = 29725)
print(imp.qp2)


#get complete data
comp <- complete(imp.qp2) #imputed data set!

write.csv(comp,"~/Box Sync/science/2020/SIVT_struct/new_dataset/BNT-MMSE_imputed-171.csv", row.names = TRUE)

