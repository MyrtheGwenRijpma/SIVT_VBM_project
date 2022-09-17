setwd("~/Box Sync/science/2020/SIVT_struct/R")

library(tidyverse)
library(tibble)
library(dplyr)
library(stats)

#read in data
scatter1 <- read_csv(file = "adjusted_sivt_r.csv")

#creating a scatterplot of all data, with diagnostic groups color coded
ggplot(scatter1, aes(x = Left_Accumbens_Area, y = SIVT_res)) +
  geom_point(aes(color = DxPrim), size = 3) +
  geom_smooth(method = 'glm', se = FALSE) +
  theme_minimal() +
  labs(x = "left accumbens area", y = "SIVT total score controlled for sex age TIV") +
  theme(text = element_text(size = 20),
        panel.background = element_rect(color = NA), 
        panel.grid.minor = element_blank())

#creating a scatterplot of all data, with diagnostic groups color coded
ggplot(scatter1, aes(x = Right_Accumbens_Area, y = SIVT_res)) +
  geom_point(aes(color = DxPrim), size = 3) +
  geom_smooth(method = 'glm', se = FALSE) +
  theme_minimal() +
  labs(x = "right accumbens area", y = "SIVT total score controlled for sex age TIV") +
  theme(text = element_text(size = 20),
        panel.background = element_rect(color = NA), 
        panel.grid.minor = element_blank())
