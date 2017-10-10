hw04-Tang-Jiahui
================
Jiahui Tang
2017/10/5

``` r
library(tidyverse)
```

    ## Loading tidyverse: ggplot2
    ## Loading tidyverse: tibble
    ## Loading tidyverse: tidyr
    ## Loading tidyverse: readr
    ## Loading tidyverse: purrr
    ## Loading tidyverse: dplyr

    ## Conflicts with tidy packages ----------------------------------------------

    ## filter(): dplyr, stats
    ## lag():    dplyr, stats

``` r
library(tidyr)
library(gapminder)
library(knitr)
library(countrycode) # To get the countrycode
library(easyGgplot2) # To put multiple graphs on the same page using ggplot2
#library(geonames)
library(dplyr)
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(gapminder))
knitr::opts_chunk$set(fig.width=13, fig.height=10)
```

General data reshaping and relationship to aggregation
------------------------------------------------------

***Activity \#1***

-   Make you own [cheatsheet for tidyr](https://github.com/Tangjiahui26/STAT545-hw-Tang-Jiahui/blob/master/hw04/Cheatsheet-tidyr.md).
    -   I gave demos for 4 main tidyr functions on the cheatsheet, and used `mtcars` dataset that is a typical wide format data\_frame.

***Activity \#2***

-   Make a tibble with one row per year and columns for life expectancy for two or more countries.
    -   Use knitr::kable() to make this table look pretty in your rendered homework.
    -   Take advantage of this new data shape to scatterplot life expectancy for one country against that of another.

*I am here to select five Asian countries: China, Japan, India, Thailand, Singapore.*

``` r
A1 <- gapminder %>% 
  filter(country %in% c("China", "Japan", "India", "Thailand", "Singapore")) %>% 
  select(country, year, lifeExp) %>% 
  spread(key = country, value = lifeExp)

knitr::kable(A1, caption = "Life Expectancy by Countries")
```

|  year|     China|   India|   Japan|  Singapore|  Thailand|
|-----:|---------:|-------:|-------:|----------:|---------:|
|  1952|  44.00000|  37.373|  63.030|     60.396|    50.848|
|  1957|  50.54896|  40.249|  65.500|     63.179|    53.630|
|  1962|  44.50136|  43.605|  68.730|     65.798|    56.061|
|  1967|  58.38112|  47.193|  71.430|     67.946|    58.285|
|  1972|  63.11888|  50.651|  73.420|     69.521|    60.405|
|  1977|  63.96736|  54.208|  75.380|     70.795|    62.494|
|  1982|  65.52500|  56.596|  77.110|     71.760|    64.597|
|  1987|  67.27400|  58.553|  78.670|     73.560|    66.084|
|  1992|  68.69000|  60.223|  79.360|     75.788|    67.298|
|  1997|  70.42600|  61.765|  80.690|     77.158|    67.521|
|  2002|  72.02800|  62.879|  82.000|     78.770|    68.564|
|  2007|  72.96100|  64.698|  82.603|     79.972|    70.616|

*I used `ggplot2` to make plots for one country(China) against that of another. And use ggplot2.multiplot to put the four graphs on the same page.*

``` r
Plot1 <- A1 %>% 
  ggplot(aes(x = China, y = Japan)) +
  geom_point(size = 4, alpha = 0.8, aes(color = factor(year))) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  theme_bw() +
  theme(axis.title.x = element_text(size=15),
        axis.title.y = element_text(size=15),
        plot.title = element_text(hjust = 0.5))+
  labs(title="Life Expectancy of China vs Japan")+
  scale_colour_discrete("year") +
  scale_x_continuous(breaks = c(40, 50, 60, 70, 80)) +
  scale_y_continuous(breaks = c(40, 50, 60, 70, 80))

Plot2 <- A1 %>% 
  ggplot(aes(x = China, y = India)) +
  geom_point(size = 4, alpha = 0.8, aes(color = factor(year))) +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  theme_bw() +
  theme(axis.title.x = element_text(size=15),
        axis.title.y = element_text(size=15),
        plot.title = element_text(hjust = 0.5))+
  labs(title="Life Expectancy of China vs Inida")+
  scale_colour_discrete("year") +
  scale_x_continuous(breaks = c(40, 50, 60, 70, 80)) +
  scale_y_continuous(breaks = c(40, 50, 60, 70, 80))

Plot3 <- A1 %>% 
  ggplot(aes(x = China, y = Thailand)) +
  geom_point(size = 4, alpha = 0.8, aes(color = factor(year))) +
  geom_smooth(method = "lm", se = FALSE, color = "yellow") +
  theme_bw() +
  theme(axis.title.x = element_text(size=15),
        axis.title.y = element_text(size=15),
        plot.title = element_text(hjust = 0.5))+
  labs(title="Life Expectancy of China vs Thailand")+
  scale_colour_discrete("year") +
  scale_x_continuous(breaks = c(40, 50, 60, 70, 80)) +
  scale_y_continuous(breaks = c(40, 50, 60, 70, 80))

Plot4 <- A1 %>% 
  ggplot(aes(x = China, y = Singapore)) +
  geom_point(size = 4, alpha = 0.8, aes(color = factor(year))) +
  geom_smooth(method = "lm", se = FALSE, color = "green") +
  theme_bw() +
  theme(axis.title.x = element_text(size=15),
        axis.title.y = element_text(size=15),
        plot.title = element_text(hjust = 0.5))+
  labs(title="Life Expectancy of China vs Singapore")+
  scale_colour_discrete("year") +
  scale_x_continuous(breaks = c(40, 50, 60, 70, 80)) +
  scale_y_continuous(breaks = c(40, 50, 60, 70, 80))

# Multiple graphs on the same page
ggplot2.multiplot(Plot1,Plot2,Plot3,Plot4, cols=2)
```

![](hw04-Tang-Jiahui_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-1.png)

*We can easily compare the life expectancy of China against that of another from the plots above.*

Join, merge, look up
--------------------

***Activity \#1***

-   Create a second data frame, complementary to Gapminder. Join this with (part of) Gapminder using a dplyr join function and make some observations about the process and result. Explore the different types of joins.

-   *I used countrycode() to get the countrycode of Asian countries, selected some variables for a new data\_frame called `first_gapminder`. Obviously, the new data\_frame has 5 columns represent continent, country, lifeExp, year and countryCode respectively.*

``` r
gapminder_code <- gapminder %>%
  mutate(countryCode = countrycode(country, "country.name", "iso2c"))
  knitr::kable(head(gapminder_code))
```

| country     | continent |  year|  lifeExp|       pop|  gdpPercap| countryCode |
|:------------|:----------|-----:|--------:|---------:|----------:|:------------|
| Afghanistan | Asia      |  1952|   28.801|   8425333|   779.4453| AF          |
| Afghanistan | Asia      |  1957|   30.332|   9240934|   820.8530| AF          |
| Afghanistan | Asia      |  1962|   31.997|  10267083|   853.1007| AF          |
| Afghanistan | Asia      |  1967|   34.020|  11537966|   836.1971| AF          |
| Afghanistan | Asia      |  1972|   36.088|  13079460|   739.9811| AF          |
| Afghanistan | Asia      |  1977|   38.438|  14880372|   786.1134| AF          |

``` r
first_gapminder <- gapminder_code %>% 
  select(continent, country, lifeExp, year, countryCode) %>% 
  filter(continent == "Asia" & year == 2007)

knitr::kable(first_gapminder)
```

| continent | country            |  lifeExp|  year| countryCode |
|:----------|:-------------------|--------:|-----:|:------------|
| Asia      | Afghanistan        |   43.828|  2007| AF          |
| Asia      | Bahrain            |   75.635|  2007| BH          |
| Asia      | Bangladesh         |   64.062|  2007| BD          |
| Asia      | Cambodia           |   59.723|  2007| KH          |
| Asia      | China              |   72.961|  2007| CN          |
| Asia      | Hong Kong, China   |   82.208|  2007| HK          |
| Asia      | India              |   64.698|  2007| IN          |
| Asia      | Indonesia          |   70.650|  2007| ID          |
| Asia      | Iran               |   70.964|  2007| IR          |
| Asia      | Iraq               |   59.545|  2007| IQ          |
| Asia      | Israel             |   80.745|  2007| IL          |
| Asia      | Japan              |   82.603|  2007| JP          |
| Asia      | Jordan             |   72.535|  2007| JO          |
| Asia      | Korea, Dem. Rep.   |   67.297|  2007| KR          |
| Asia      | Korea, Rep.        |   78.623|  2007| KR          |
| Asia      | Kuwait             |   77.588|  2007| KW          |
| Asia      | Lebanon            |   71.993|  2007| LB          |
| Asia      | Malaysia           |   74.241|  2007| MY          |
| Asia      | Mongolia           |   66.803|  2007| MN          |
| Asia      | Myanmar            |   62.069|  2007| MM          |
| Asia      | Nepal              |   63.785|  2007| NP          |
| Asia      | Oman               |   75.640|  2007| OM          |
| Asia      | Pakistan           |   65.483|  2007| PK          |
| Asia      | Philippines        |   71.688|  2007| PH          |
| Asia      | Saudi Arabia       |   72.777|  2007| SA          |
| Asia      | Singapore          |   79.972|  2007| SG          |
| Asia      | Sri Lanka          |   72.396|  2007| LK          |
| Asia      | Syria              |   74.143|  2007| SY          |
| Asia      | Taiwan             |   78.400|  2007| TW          |
| Asia      | Thailand           |   70.616|  2007| TH          |
| Asia      | Vietnam            |   74.249|  2007| VN          |
| Asia      | West Bank and Gaza |   73.422|  2007| PS          |
| Asia      | Yemen, Rep.        |   62.698|  2007| YE          |

-   *We should create a second\_gapminder data\_frame to realize join functions, so I picked 8 countries with their continent, language and national flower, etc.*

``` r
country <- c("China", "Japan", "India", "Thailand", "Singapore", "Canada", "Germany", "Netherlands")
continent <- c("Asia","Asia","Asia","Asia","Asia","Americas", "Europe","Europe")
Languages <- c("Mandarin","Japanese","Hindi/English","Dai","English", "English", "German", "Dutch")
NATO <- c(0, 0, 0, 0, 0, 1, 1, 1)
National_flower <- c("Peony", "Cherry Blossom", "Nelumbo nucifera", "Cassia fistula", "Vanda 'Miss Joaquim'", "Sugar Maple", "Blue Bottle", "Tulipa")

second_gapminder <- data.frame(country, continent, Languages, NATO, National_flower)
knitr::kable(second_gapminder)
```

| country     | continent | Languages     |  NATO| National\_flower     |
|:------------|:----------|:--------------|-----:|:---------------------|
| China       | Asia      | Mandarin      |     0| Peony                |
| Japan       | Asia      | Japanese      |     0| Cherry Blossom       |
| India       | Asia      | Hindi/English |     0| Nelumbo nucifera     |
| Thailand    | Asia      | Dai           |     0| Cassia fistula       |
| Singapore   | Asia      | English       |     0| Vanda 'Miss Joaquim' |
| Canada      | Americas  | English       |     1| Sugar Maple          |
| Germany     | Europe    | German        |     1| Blue Bottle          |
| Netherlands | Europe    | Dutch         |     1| Tulipa               |

### *left\_join*

-   *We can find that left\_join1 will return all rows from second\_gapminder and all rowa from second\_gapminder and first\_gapminder. Left\_join2 is the opposite of left\_join1.*

``` r
left_join1 <- left_join(second_gapminder, first_gapminder, by=c("country", "continent"))
```

    ## Warning: Column `country` joining factors with different levels, coercing
    ## to character vector

    ## Warning: Column `continent` joining factors with different levels, coercing
    ## to character vector

``` r
knitr::kable(left_join1)
```

| country     | continent | Languages     |  NATO| National\_flower     |  lifeExp|  year| countryCode |
|:------------|:----------|:--------------|-----:|:---------------------|--------:|-----:|:------------|
| China       | Asia      | Mandarin      |     0| Peony                |   72.961|  2007| CN          |
| Japan       | Asia      | Japanese      |     0| Cherry Blossom       |   82.603|  2007| JP          |
| India       | Asia      | Hindi/English |     0| Nelumbo nucifera     |   64.698|  2007| IN          |
| Thailand    | Asia      | Dai           |     0| Cassia fistula       |   70.616|  2007| TH          |
| Singapore   | Asia      | English       |     0| Vanda 'Miss Joaquim' |   79.972|  2007| SG          |
| Canada      | Americas  | English       |     1| Sugar Maple          |       NA|    NA| NA          |
| Germany     | Europe    | German        |     1| Blue Bottle          |       NA|    NA| NA          |
| Netherlands | Europe    | Dutch         |     1| Tulipa               |       NA|    NA| NA          |

``` r
left_join2 <- left_join(first_gapminder, second_gapminder)
```

    ## Joining, by = c("continent", "country")

    ## Warning: Column `continent` joining factors with different levels, coercing
    ## to character vector

    ## Warning: Column `country` joining factors with different levels, coercing
    ## to character vector

``` r
knitr::kable(left_join2)
```

| continent | country            |  lifeExp|  year| countryCode | Languages     |  NATO| National\_flower     |
|:----------|:-------------------|--------:|-----:|:------------|:--------------|-----:|:---------------------|
| Asia      | Afghanistan        |   43.828|  2007| AF          | NA            |    NA| NA                   |
| Asia      | Bahrain            |   75.635|  2007| BH          | NA            |    NA| NA                   |
| Asia      | Bangladesh         |   64.062|  2007| BD          | NA            |    NA| NA                   |
| Asia      | Cambodia           |   59.723|  2007| KH          | NA            |    NA| NA                   |
| Asia      | China              |   72.961|  2007| CN          | Mandarin      |     0| Peony                |
| Asia      | Hong Kong, China   |   82.208|  2007| HK          | NA            |    NA| NA                   |
| Asia      | India              |   64.698|  2007| IN          | Hindi/English |     0| Nelumbo nucifera     |
| Asia      | Indonesia          |   70.650|  2007| ID          | NA            |    NA| NA                   |
| Asia      | Iran               |   70.964|  2007| IR          | NA            |    NA| NA                   |
| Asia      | Iraq               |   59.545|  2007| IQ          | NA            |    NA| NA                   |
| Asia      | Israel             |   80.745|  2007| IL          | NA            |    NA| NA                   |
| Asia      | Japan              |   82.603|  2007| JP          | Japanese      |     0| Cherry Blossom       |
| Asia      | Jordan             |   72.535|  2007| JO          | NA            |    NA| NA                   |
| Asia      | Korea, Dem. Rep.   |   67.297|  2007| KR          | NA            |    NA| NA                   |
| Asia      | Korea, Rep.        |   78.623|  2007| KR          | NA            |    NA| NA                   |
| Asia      | Kuwait             |   77.588|  2007| KW          | NA            |    NA| NA                   |
| Asia      | Lebanon            |   71.993|  2007| LB          | NA            |    NA| NA                   |
| Asia      | Malaysia           |   74.241|  2007| MY          | NA            |    NA| NA                   |
| Asia      | Mongolia           |   66.803|  2007| MN          | NA            |    NA| NA                   |
| Asia      | Myanmar            |   62.069|  2007| MM          | NA            |    NA| NA                   |
| Asia      | Nepal              |   63.785|  2007| NP          | NA            |    NA| NA                   |
| Asia      | Oman               |   75.640|  2007| OM          | NA            |    NA| NA                   |
| Asia      | Pakistan           |   65.483|  2007| PK          | NA            |    NA| NA                   |
| Asia      | Philippines        |   71.688|  2007| PH          | NA            |    NA| NA                   |
| Asia      | Saudi Arabia       |   72.777|  2007| SA          | NA            |    NA| NA                   |
| Asia      | Singapore          |   79.972|  2007| SG          | English       |     0| Vanda 'Miss Joaquim' |
| Asia      | Sri Lanka          |   72.396|  2007| LK          | NA            |    NA| NA                   |
| Asia      | Syria              |   74.143|  2007| SY          | NA            |    NA| NA                   |
| Asia      | Taiwan             |   78.400|  2007| TW          | NA            |    NA| NA                   |
| Asia      | Thailand           |   70.616|  2007| TH          | Dai           |     0| Cassia fistula       |
| Asia      | Vietnam            |   74.249|  2007| VN          | NA            |    NA| NA                   |
| Asia      | West Bank and Gaza |   73.422|  2007| PS          | NA            |    NA| NA                   |
| Asia      | Yemen, Rep.        |   62.698|  2007| YE          | NA            |    NA| NA                   |

### *inner\_join*

-   *We can find that inner\_join returns all rows from second\_gapminder where there are matching values in first\_gapminder, and all columns from both.*

``` r
inner_join1 <- inner_join(second_gapminder, first_gapminder)
```

    ## Joining, by = c("country", "continent")

    ## Warning: Column `country` joining factors with different levels, coercing
    ## to character vector

    ## Warning: Column `continent` joining factors with different levels, coercing
    ## to character vector

``` r
knitr::kable(inner_join1)
```

| country   | continent | Languages     |  NATO| National\_flower     |  lifeExp|  year| countryCode |
|:----------|:----------|:--------------|-----:|:---------------------|--------:|-----:|:------------|
| China     | Asia      | Mandarin      |     0| Peony                |   72.961|  2007| CN          |
| Japan     | Asia      | Japanese      |     0| Cherry Blossom       |   82.603|  2007| JP          |
| India     | Asia      | Hindi/English |     0| Nelumbo nucifera     |   64.698|  2007| IN          |
| Thailand  | Asia      | Dai           |     0| Cassia fistula       |   70.616|  2007| TH          |
| Singapore | Asia      | English       |     0| Vanda 'Miss Joaquim' |   79.972|  2007| SG          |

### *semi\_join*

-   *We can find that it will return all rows from second\_gapminder where there are matching values in first\_gapminder, keeping just columns from second\_gapminder. Semi\_join2 is the opposite of semi\_join1.*

``` r
semi_join1 <- semi_join(second_gapminder, first_gapminder)
```

    ## Joining, by = c("country", "continent")

    ## Warning: Column `country` joining factors with different levels, coercing
    ## to character vector

    ## Warning: Column `continent` joining factors with different levels, coercing
    ## to character vector

``` r
knitr::kable(semi_join1)
```

| country   | continent | Languages     |  NATO| National\_flower     |
|:----------|:----------|:--------------|-----:|:---------------------|
| China     | Asia      | Mandarin      |     0| Peony                |
| Japan     | Asia      | Japanese      |     0| Cherry Blossom       |
| India     | Asia      | Hindi/English |     0| Nelumbo nucifera     |
| Thailand  | Asia      | Dai           |     0| Cassia fistula       |
| Singapore | Asia      | English       |     0| Vanda 'Miss Joaquim' |

``` r
semi_join2 <- semi_join(first_gapminder, second_gapminder)
```

    ## Joining, by = c("continent", "country")

    ## Warning: Column `continent` joining factors with different levels, coercing
    ## to character vector

    ## Warning: Column `country` joining factors with different levels, coercing
    ## to character vector

``` r
knitr::kable(semi_join2)
```

| continent | country   |  lifeExp|  year| countryCode |
|:----------|:----------|--------:|-----:|:------------|
| Asia      | China     |   72.961|  2007| CN          |
| Asia      | India     |   64.698|  2007| IN          |
| Asia      | Japan     |   82.603|  2007| JP          |
| Asia      | Singapore |   79.972|  2007| SG          |
| Asia      | Thailand  |   70.616|  2007| TH          |

### *anti\_join*

-   *Return all rows from second\_gapminder where there are not matching values in first\_gapminder, keeping just columns from second\_gapminder.*

``` r
anti_join1 <- anti_join(second_gapminder, first_gapminder)
```

    ## Joining, by = c("country", "continent")

    ## Warning: Column `country` joining factors with different levels, coercing
    ## to character vector

    ## Warning: Column `continent` joining factors with different levels, coercing
    ## to character vector

``` r
knitr::kable(anti_join1)
```

| country     | continent | Languages |  NATO| National\_flower |
|:------------|:----------|:----------|-----:|:-----------------|
| Canada      | Americas  | English   |     1| Sugar Maple      |
| Germany     | Europe    | German    |     1| Blue Bottle      |
| Netherlands | Europe    | Dutch     |     1| Tulipa           |

-   *Return all rows from first\_gapminder where there are not matching values in second\_gapminder, keeping just columns from first\_gapminder.*

``` r
anti_join2 <- anti_join(first_gapminder, second_gapminder)
```

    ## Joining, by = c("continent", "country")

    ## Warning: Column `continent` joining factors with different levels, coercing
    ## to character vector

    ## Warning: Column `country` joining factors with different levels, coercing
    ## to character vector

``` r
knitr::kable(anti_join2)
```

| continent | country            |  lifeExp|  year| countryCode |
|:----------|:-------------------|--------:|-----:|:------------|
| Asia      | Afghanistan        |   43.828|  2007| AF          |
| Asia      | Bahrain            |   75.635|  2007| BH          |
| Asia      | Bangladesh         |   64.062|  2007| BD          |
| Asia      | Cambodia           |   59.723|  2007| KH          |
| Asia      | Hong Kong, China   |   82.208|  2007| HK          |
| Asia      | Indonesia          |   70.650|  2007| ID          |
| Asia      | Iran               |   70.964|  2007| IR          |
| Asia      | Iraq               |   59.545|  2007| IQ          |
| Asia      | Israel             |   80.745|  2007| IL          |
| Asia      | Jordan             |   72.535|  2007| JO          |
| Asia      | Korea, Dem. Rep.   |   67.297|  2007| KR          |
| Asia      | Korea, Rep.        |   78.623|  2007| KR          |
| Asia      | Kuwait             |   77.588|  2007| KW          |
| Asia      | Lebanon            |   71.993|  2007| LB          |
| Asia      | Malaysia           |   74.241|  2007| MY          |
| Asia      | Mongolia           |   66.803|  2007| MN          |
| Asia      | Myanmar            |   62.069|  2007| MM          |
| Asia      | Nepal              |   63.785|  2007| NP          |
| Asia      | Oman               |   75.640|  2007| OM          |
| Asia      | Pakistan           |   65.483|  2007| PK          |
| Asia      | Philippines        |   71.688|  2007| PH          |
| Asia      | Saudi Arabia       |   72.777|  2007| SA          |
| Asia      | Sri Lanka          |   72.396|  2007| LK          |
| Asia      | Syria              |   74.143|  2007| SY          |
| Asia      | Taiwan             |   78.400|  2007| TW          |
| Asia      | Vietnam            |   74.249|  2007| VN          |
| Asia      | West Bank and Gaza |   73.422|  2007| PS          |
| Asia      | Yemen, Rep.        |   62.698|  2007| YE          |

### *full\_join*

-   *Return all rows and all columns from both second\_gapminder and first\_gapminder.*

``` r
full_join1 <- full_join(second_gapminder, first_gapminder)
```

    ## Joining, by = c("country", "continent")

    ## Warning: Column `country` joining factors with different levels, coercing
    ## to character vector

    ## Warning: Column `continent` joining factors with different levels, coercing
    ## to character vector

``` r
knitr::kable(full_join1)
```

| country            | continent | Languages     |  NATO| National\_flower     |  lifeExp|  year| countryCode |
|:-------------------|:----------|:--------------|-----:|:---------------------|--------:|-----:|:------------|
| China              | Asia      | Mandarin      |     0| Peony                |   72.961|  2007| CN          |
| Japan              | Asia      | Japanese      |     0| Cherry Blossom       |   82.603|  2007| JP          |
| India              | Asia      | Hindi/English |     0| Nelumbo nucifera     |   64.698|  2007| IN          |
| Thailand           | Asia      | Dai           |     0| Cassia fistula       |   70.616|  2007| TH          |
| Singapore          | Asia      | English       |     0| Vanda 'Miss Joaquim' |   79.972|  2007| SG          |
| Canada             | Americas  | English       |     1| Sugar Maple          |       NA|    NA| NA          |
| Germany            | Europe    | German        |     1| Blue Bottle          |       NA|    NA| NA          |
| Netherlands        | Europe    | Dutch         |     1| Tulipa               |       NA|    NA| NA          |
| Afghanistan        | Asia      | NA            |    NA| NA                   |   43.828|  2007| AF          |
| Bahrain            | Asia      | NA            |    NA| NA                   |   75.635|  2007| BH          |
| Bangladesh         | Asia      | NA            |    NA| NA                   |   64.062|  2007| BD          |
| Cambodia           | Asia      | NA            |    NA| NA                   |   59.723|  2007| KH          |
| Hong Kong, China   | Asia      | NA            |    NA| NA                   |   82.208|  2007| HK          |
| Indonesia          | Asia      | NA            |    NA| NA                   |   70.650|  2007| ID          |
| Iran               | Asia      | NA            |    NA| NA                   |   70.964|  2007| IR          |
| Iraq               | Asia      | NA            |    NA| NA                   |   59.545|  2007| IQ          |
| Israel             | Asia      | NA            |    NA| NA                   |   80.745|  2007| IL          |
| Jordan             | Asia      | NA            |    NA| NA                   |   72.535|  2007| JO          |
| Korea, Dem. Rep.   | Asia      | NA            |    NA| NA                   |   67.297|  2007| KR          |
| Korea, Rep.        | Asia      | NA            |    NA| NA                   |   78.623|  2007| KR          |
| Kuwait             | Asia      | NA            |    NA| NA                   |   77.588|  2007| KW          |
| Lebanon            | Asia      | NA            |    NA| NA                   |   71.993|  2007| LB          |
| Malaysia           | Asia      | NA            |    NA| NA                   |   74.241|  2007| MY          |
| Mongolia           | Asia      | NA            |    NA| NA                   |   66.803|  2007| MN          |
| Myanmar            | Asia      | NA            |    NA| NA                   |   62.069|  2007| MM          |
| Nepal              | Asia      | NA            |    NA| NA                   |   63.785|  2007| NP          |
| Oman               | Asia      | NA            |    NA| NA                   |   75.640|  2007| OM          |
| Pakistan           | Asia      | NA            |    NA| NA                   |   65.483|  2007| PK          |
| Philippines        | Asia      | NA            |    NA| NA                   |   71.688|  2007| PH          |
| Saudi Arabia       | Asia      | NA            |    NA| NA                   |   72.777|  2007| SA          |
| Sri Lanka          | Asia      | NA            |    NA| NA                   |   72.396|  2007| LK          |
| Syria              | Asia      | NA            |    NA| NA                   |   74.143|  2007| SY          |
| Taiwan             | Asia      | NA            |    NA| NA                   |   78.400|  2007| TW          |
| Vietnam            | Asia      | NA            |    NA| NA                   |   74.249|  2007| VN          |
| West Bank and Gaza | Asia      | NA            |    NA| NA                   |   73.422|  2007| PS          |
| Yemen, Rep.        | Asia      | NA            |    NA| NA                   |   62.698|  2007| YE          |
