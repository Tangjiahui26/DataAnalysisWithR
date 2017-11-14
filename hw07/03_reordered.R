library(purrr)
library(tidyverse)
library(forcats)

country_codes = readRDS("02_figures.rds")

#Reorder the continents based on life expectancy.
#Use the forcats package to change the order

reordered_data <- country_codes %>% 
    mutate(continent = fct_reorder(continent, lifeExp, max))

#Reorder the continents based on life expectancy 
#Plot the two different figures

P5 <- reordered_data %>% 
    group_by(continent) %>% 
    summarise(max_lifeExp = max(lifeExp)) %>% 
    ggplot(aes(x = continent, y = max_lifeExp, color = max_lifeExp))+ 
    geom_point() + 
    theme_bw() +
    theme(axis.title.x = element_text(size=15),
          axis.title.y = element_text(size=15),
          plot.title=element_text(hjust=0.5)) +
    labs(title="LifeExp for each continent reordered")

ggsave("./figures/MaxLifeExp for each continent reordered.png",P5,device = "png", width = 10, 
       height = 7,dpi = 500)

P6 <- country_codes %>% 
    group_by(continent) %>% 
    summarise(max_lifeExp = max(lifeExp)) %>% 
    ggplot(aes(x = continent, y = max_lifeExp, color = max_lifeExp))+ 
    geom_point() + 
    theme_bw() +
    theme(axis.title.x = element_text(size=15),
          axis.title.y = element_text(size=15),
          plot.title=element_text(hjust=0.5)) +
    labs(title="LifeExp for each continent without reordered") +
    scale_y_continuous("MaxLifeExp")   

ggsave("./figures/MaxLifeExp for each continent unreordered.png",P6,device = "png", width = 10, 
       height = 7,dpi = 500)

reordered_data %>% 
    saveRDS("03_reordered.rds")
