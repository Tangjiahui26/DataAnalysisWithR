library(purrr)
library(tidyverse)
library(forcats)

gapminder <- read.delim("gap-every-five-years.tsv")
ios_codes <- read.delim("iso-codes.tsv")

#Use left_join to create a new data_frame called country_codes which contains
#gapminder and ios_codes of each countries
country_codes <- left_join(gapminder, ios_codes)
country_codes %>% 
    saveRDS("01_dataframe.rds")