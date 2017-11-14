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

country_nested <- country_codes %>% 
    group_by(continent, country) %>% 
    nest()

life_vs_year <- function(df) {
    lm(lifeExp ~ I(year - 1950), data = df)
}

country_nested <- country_nested %>% 
    mutate(fit = map(data, life_vs_year),
           tidy = map(fit, tidy)) %>% 
    select(continent, country, tidy) %>% 
    unnest(tidy)

intercepts_and_slope <- country_nested %>%
        mutate(term = recode(term,
                             `(Intercept)` = "intercept",
                             `I(year - 1950)` = "slope"))
intercepts_and_slope %>% 
    saveRDS("intercepts_and_slope.rds")

#Create a figure for each continent, and write one file per continent, with an informative name. 

Asia <- country_codes %>% 
    filter(continent == "Asia") %>% 
    ggplot(aes(x=year,y=lifeExp)) +
    facet_wrap(~country) + 
    geom_point(aes(color = country)) + 
    geom_smooth(method="lm",se=FALSE) +
    theme_bw() +
    theme(strip.background = element_rect(fill="grey"),
          axis.title.x = element_text(size=15),
          axis.title.y = element_text(size=15),
          strip.text = element_text(size=10, face="bold",hjust=0.5))+
    labs(title="Asia-scatterplots of life expectancy_vs_year")

ggsave("Asia-scatterplots of life expectancy_vs_year.png",Asia,device = "png", width = 10, 
       height = 7,dpi = 500)

Americas <- country_codes %>% 
    filter(continent == "Americas") %>% 
    ggplot(aes(x=year,y=lifeExp)) +
    facet_wrap(~country) + 
    geom_point(aes(color = country)) + 
    geom_smooth(method="lm",se=FALSE) +
    theme_bw() +
    theme(strip.background = element_rect(fill="grey"),
          axis.title.x = element_text(size=15),
          axis.title.y = element_text(size=15),
          strip.text = element_text(size=10, face="bold",hjust=0.5))+
    labs(title="Americas-scatterplots of life expectancy_vs_year")

ggsave("Americas-scatterplots of life expectancy_vs_year.png",Americas,device = "png", width = 10, 
       height = 7,dpi = 500)

Africa <- country_codes %>% 
    filter(continent == "Africa") %>% 
    ggplot(aes(x=year,y=lifeExp)) +
    facet_wrap(~country) + 
    geom_point(aes(color = country)) + 
    geom_smooth(method="lm",se=FALSE) +
    theme_bw() +
    theme(strip.background = element_rect(fill="grey"),
          axis.title.x = element_text(size=15),
          axis.title.y = element_text(size=15),
          strip.text = element_text(size=10, face="bold",hjust=0.5))+
    labs(title="Africa-scatterplots of life expectancy_vs_year")

ggsave("Africa-scatterplots of life expectancy_vs_year.png",Africa,device = "png", width = 10, 
       height = 7,dpi = 500)

Europe <- country_codes %>% 
    filter(continent == "Europe") %>% 
    ggplot(aes(x=year,y=lifeExp)) +
    facet_wrap(~country) + 
    geom_point(aes(color = country)) + 
    geom_smooth(method="lm",se=FALSE) +
    theme_bw() +
    theme(strip.background = element_rect(fill="grey"),
          axis.title.x = element_text(size=15),
          axis.title.y = element_text(size=15),
          strip.text = element_text(size=10, face="bold",hjust=0.5))+
    labs(title="Europe-scatterplots of life expectancy_vs_year")

ggsave("Europe-scatterplots of life expectancy_vs_year.png",Europe,device = "png", width = 10, 
       height = 7,dpi = 500)

Oceania <- country_codes %>% 
    filter(continent == "Oceania") %>% 
    ggplot(aes(x=year,y=lifeExp)) +
    facet_wrap(~country) + 
    geom_point(aes(color = country)) + 
    geom_smooth(method="lm",se=FALSE) +
    theme_bw() +
    theme(strip.background = element_rect(fill="grey"),
          axis.title.x = element_text(size=15),
          axis.title.y = element_text(size=15),
          strip.text = element_text(size=10, face="bold",hjust=0.5))+
    labs(title="Oceania-scatterplots of life expectancy_vs_year")

ggsave("Oceania-scatterplots of life expectancy_vs_year.png",Oceania,device = "png", width = 10, 
       height = 7,dpi = 500)

#find the best and worst 4 countries in Asia
#best countires may have a smallest std.error
#worst countires may have a highest std.error
#then save the countries into files

Asia_best4 <- country_nested %>% 
    filter(continent == "Asia") %>% 
    arrange(std.error) %>% 
    head(4L)
#knitr::kable(Asia_best4)

Asia_worst4 <- country_nested %>% 
    filter(continent == "Asia") %>% 
    arrange(desc(std.error)) %>% 
    head(4L)
#knitr::kable(Asia_worst4)

Asia_best4 %>% 
    saveRDS("Asia_best4.rds")
Asia_worst4 %>% 
    saveRDS("Asia_worst4.rds")
