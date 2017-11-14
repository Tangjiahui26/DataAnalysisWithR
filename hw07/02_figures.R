library(purrr)
library(tidyverse)
library(forcats)
knitr::opts_chunk$set(fig.width=13, fig.height=10)

country_codes = readRDS("01_dataframe.rds")
gapminder <- read.delim("gap-every-five-years.tsv")
ios_codes <- read.delim("iso-codes.tsv")
#Save a couple descriptive plots to file with highly informative names
#Get the maximum and minimum of GDP per capita for all continents.
#make figures and distinguished the max/min GdpPercap and others in differnet colors.

T1 <- country_codes %>% 
    group_by(continent) %>% 
    summarise(Max_GdpPercap = max(gdpPercap), Min_GdpPercap = min(gdpPercap))
              
P1 <- country_codes %>% 
    ggplot(aes(x = year, y = gdpPercap))+
    facet_wrap(~ continent, scales = "free_y") +
    geom_point(aes(color = (gdpPercap %in% c(T1$Max_GdpPercap, T1$Min_GdpPercap))), size = 5, alpha = 0.5) +
    theme_bw() +
    theme(strip.background = element_rect(fill="orange"),
          axis.title.x = element_text(size=15),
          axis.title.y = element_text(size=15),
          strip.text = element_text(size=18, face="bold",hjust=0.5))+
    labs(title="GdpPercap for all continents")+
    scale_colour_discrete("Max_GdpPercap/Min_GdpPercap")
print(P1)   
ggsave("GdpPercap for all continents.png",P1)

P1 %>% 
    saveRDS("02_figures.rds")
