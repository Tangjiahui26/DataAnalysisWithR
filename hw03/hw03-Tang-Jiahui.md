hw03-Tang-Jiahui
================
Jiahui Tang
2017/9/30

``` r
suppressPackageStartupMessages(library(tidyverse))  # The tidyverse contains ggplot2!
suppressPackageStartupMessages(library(gapminder))
knitr::opts_chunk$set(fig.width=15, fig.height=10)
```

Task1: Get the maximum and minimum of GDP per capita for all continents.
------------------------------------------------------------------------

*To get the maximum and minimum of GdpPercap for continents, I firstly used summarise() to obtain max and min values for each continent, then filter() and mutate() to print the detailed information of the countries which have the max or min GDP per capita, finally created a new data.frame to show all the values above.*

``` r
T1 <- gapminder %>% 
  group_by(continent) %>% 
  summarise(Max_GdpPercap = max(gdpPercap), Min_GdpPercap = min(gdpPercap))
Max_country <- gapminder %>% 
  filter(gdpPercap %in% T1$Max_GdpPercap) %>% 
  arrange(continent) %>% 
  mutate(Max_country_info = paste(country, year))
Min_country <- gapminder %>% 
  filter(gdpPercap %in% T1$Min_GdpPercap) %>% 
  arrange(continent) %>% 
  mutate(Min_country_info = paste(country, year))
Task1 <- data.frame(T1, Max_country$Max_country_info, Min_country$Min_country_info)

knitr::kable(Task1)
```

| continent |  Max\_GdpPercap|  Min\_GdpPercap| Max\_country.Max\_country\_info | Min\_country.Min\_country\_info |
|:----------|---------------:|---------------:|:--------------------------------|:--------------------------------|
| Africa    |        21951.21|        241.1659| Libya 1977                      | Congo, Dem. Rep. 2002           |
| Americas  |        42951.65|       1201.6372| United States 2007              | Haiti 2007                      |
| Asia      |       113523.13|        331.0000| Kuwait 1957                     | Myanmar 1952                    |
| Europe    |        49357.19|        973.5332| Norway 2007                     | Bosnia and Herzegovina 1952     |
| Oceania   |        34435.37|      10039.5956| Australia 2007                  | Australia 1952                  |

*I used `ggplot2` and `facetting` to make figures and distinguished the max/min GdpPercap and others in differnet colors.*

``` r
P1 <- gapminder %>% 
  ggplot(aes(x = year, y = gdpPercap))
P2 <- P1 + facet_wrap(~ continent, scales = "free_y") +
  geom_point(aes(color = (gdpPercap %in% c(T1$Max_GdpPercap, T1$Min_GdpPercap))), size = 5) +
  theme_bw() +
  theme(strip.background = element_rect(fill="orange"),
        axis.title.x = element_text(size=15),
        axis.title.y = element_text(size=15),
        strip.text = element_text(size=18, face="bold"))+
  labs(title="GdpPercap for all continents")+
  scale_colour_discrete("Max_GdpPercap/Min_GdpPercap")
P2
```

![](hw03-Tang-Jiahui_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-1.png)

Task2: Look at the spread of GDP per capita within the continents.
------------------------------------------------------------------

*We can directly use summarise() to get mean, sd and max/min values of GDP per capita for each continent.From the table shown below, we can find that the sd value of Asia is the largest, while Africa has the smallest sd value. In addition, Europe has the largest mean value of GdpPercap.*

``` r
T2 <-gapminder %>% 
  group_by(continent) %>% 
  summarise(min_gdpPercap = min(gdpPercap), max_gdpPercap = max(gdpPercap),
            mean_gdpPercap = mean(gdpPercap), sd_gdpPercap = sd(gdpPercap))

knitr::kable(T2)
```

| continent |  min\_gdpPercap|  max\_gdpPercap|  mean\_gdpPercap|  sd\_gdpPercap|
|:----------|---------------:|---------------:|----------------:|--------------:|
| Africa    |        241.1659|        21951.21|         2193.755|       2827.930|
| Americas  |       1201.6372|        42951.65|         7136.110|       6396.764|
| Asia      |        331.0000|       113523.13|         7902.150|      14045.373|
| Europe    |        973.5332|        49357.19|        14469.476|       9355.213|
| Oceania   |      10039.5956|        34435.37|        18621.609|       6358.983|

*We can use geom\_histogram() to make histograms of different continents. The results are similar to the table above.*

``` r
P3 <- gapminder %>%
  select(gdpPercap, continent) %>% 
  ggplot(aes(x = gdpPercap, color = continent))
P4 <- P3 + geom_histogram() +
  facet_wrap(~ continent, scales = "free_y") +
  theme_bw() +
  theme(strip.background = element_rect(fill="orange"),
        axis.title.x = element_text(size=15),
        axis.title.y = element_text(size=15),
        strip.text = element_text(size=18, face="bold"))+
  labs(title="GdpPercap histogram for each continent")
  
P4
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](hw03-Tang-Jiahui_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-5-1.png)
