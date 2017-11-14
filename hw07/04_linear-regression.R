library(purrr)
library(tidyverse)
library(forcats)
library(broom)
library(ggmap)

reordered_data = readRDS("03_reordered.rds")
country_codes = readRDS("02_figures.rds")

#Fit a linear regression of life expectancy on year within each country. 
#Write the estimated intercepts, slopes, and residual error variance (or sd) to file. 
#The R package broom may be useful here.

