hw05-Tang-Jiahui
================
Jiahui Tang
2017/10/12

``` r
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(gapminder))
suppressPackageStartupMessages(library(singer))
suppressPackageStartupMessages(library(forcats))
knitr::opts_chunk$set(fig.width=13, fig.height=10)
```

Factor Management
-----------------

I chosen the `Singer`dataframe to explore in this part.

### Factorise

*Transform some of the variable in the singer\_locations dataframe into factors: pay attention at what levels you introduce and their order. Try and consider the difference between the base R as.factor and the forcats-provided functions.*

-   First let's look at this dataset by using`glimpse()`, and we can find that the type of variables are not`factor`. Then I transform three variables,`artisit_name`,`year`and`city`into factors.

``` r
data("singer_locations")
glimpse(singer_locations)
```

    ## Observations: 10,100
    ## Variables: 14
    ## $ track_id           <chr> "TRWICRA128F42368DB", "TRXJANY128F42246FC",...
    ## $ title              <chr> "The Conversation (Cd)", "Lonely Island", "...
    ## $ song_id            <chr> "SOSURTI12A81C22FB8", "SODESQP12A6D4F98EF",...
    ## $ release            <chr> "Even If It Kills Me", "The Duke Of Earl", ...
    ## $ artist_id          <chr> "ARACDPV1187FB58DF4", "ARYBUAO1187FB3F4EB",...
    ## $ artist_name        <chr> "Motion City Soundtrack", "Gene Chandler", ...
    ## $ year               <int> 2007, 2004, 1998, 1995, 1968, 2006, 2003, 2...
    ## $ duration           <dbl> 170.4485, 106.5530, 527.5947, 695.1179, 237...
    ## $ artist_hotttnesss  <dbl> 0.6410183, 0.3937627, 0.4306226, 0.3622792,...
    ## $ artist_familiarity <dbl> 0.8230522, 0.5700167, 0.5039940, 0.4773099,...
    ## $ latitude           <dbl> NA, 41.88415, 40.71455, NA, 42.33168, 40.99...
    ## $ longitude          <dbl> NA, -87.63241, -74.00712, NA, -83.04792, -7...
    ## $ name               <chr> NA, "Gene Chandler", "Paul Horn", NA, "Doro...
    ## $ city               <chr> NA, "Chicago, IL", "New York, NY", NA, "Det...

-   We can use different ways to transform variables to factors: the base R as.factor and the forcats-provided functions`as_factor`.

-   However, when I tried to transform`year<int>`and`city<chr>`, I came across some ERRORS. Since year is numerical, it did not work if I use`as_factor()`directly, I changed it from integer into character first. As for`city`, which is a character variable with NA, we should add a value for NA.

*the base R as.factor*

``` r
singer_factor_base <- singer_locations %>% 
  mutate(artist_name = as.factor(artist_name),
         year = as.factor(year),
         city = as.factor(city))

str(singer_factor_base$artist_name)
```

    ##  Factor w/ 7498 levels "'t Hof Van Commerce",..: 4458 2487 4943 5439 1897 585 7247 7393 5763 5204 ...

``` r
str(singer_factor_base$year)
```

    ##  Factor w/ 70 levels "0","1922","1926",..: 67 64 58 55 28 66 63 67 26 66 ...

``` r
str(singer_factor_base$city)
```

    ##  Factor w/ 1316 levels "?, Illinois",..: NA 225 804 NA 305 910 NA NA NA NA ...

*the forcats-provided functions`as_factor`*

``` r
singer_factor <- singer_locations %>% 
  mutate(artist_name = as_factor(artist_name),
         city = ifelse(is.na(city), "NA", city),
         city = as_factor(city),
         year = as_factor(as.character(year)))

str(singer_factor$artist_name)
```

    ##  Factor w/ 7498 levels "Motion City Soundtrack",..: 1 2 3 4 5 6 7 8 9 10 ...

``` r
str(singer_factor$year)
```

    ##  Factor w/ 70 levels "2007","2004",..: 1 2 3 4 5 6 7 1 8 6 ...

``` r
str(singer_factor$city)
```

    ##  Factor w/ 1317 levels "NA","Chicago, IL",..: 1 2 3 1 4 5 1 1 1 1 ...

*From the results above, we can find that`as_factor()`would change the order of factor, while`as.factor`does not. Besides, the`levels`are different because we added some vaules into`city`.*

### Drop 0

*Filter the`singer_locations`data to remove observations associated with the uncorrectly inputed`year`0. Additionally, remove unused factor levels. Provide concrete information on the data before and after removing these rows and levels; address the number of rows and the levels of the affected factors.*

-   Filter() was used to remove unexpected observations, and we can find that the number of rows are changed from 10100 to 10000. However, unused levels of artist\_name and city were not removed. droplevels() can be exploited to solve this problem.

``` r
a = dim(singer_factor)[1]
b = nlevels(singer_factor$year)
c = nlevels(singer_factor$artist_name)
d = nlevels(singer_factor$city)

singer_FB_year <- singer_factor %>% 
  filter(year != 0) %>% 
  mutate(year = as_factor(as.character(year)))

singer_year_dropped <- singer_FB_year %>% 
  droplevels()
e = dim(singer_year_dropped)[1]
f = nlevels(singer_year_dropped$year)
g = nlevels(singer_year_dropped$artist_name)
h = nlevels(singer_year_dropped$city)


mytable <- cbind(before_drop = c(a,b,c,d),after_drop = c(e,f,g,h))
rownames(mytable) <- c("Rows", "year_levels","artist_levels", "city_levels")
knitr::kable(mytable)
```

|                |  before\_drop|  after\_drop|
|----------------|-------------:|------------:|
| Rows           |         10100|        10000|
| year\_levels   |            70|           69|
| artist\_levels |          7498|         7408|
| city\_levels   |          1317|         1309|

*The table above shows how the number of rows and levels of factors changed before and after removing. After using`droplevels()`, we now have 7408 and 1309 levels respectively for artist\_name and city, which means there are 90 and 8 levels affected.*

### Reorder the levels of`year`, `artist_name` or `title`.

*Use the forcats package to change the order of the factor levels, based on a principled summary of one of the quantitative variables. Consider experimenting with a summary statistic beyond the most basic choice of the median.*

``` r
fct_reorder(singer_year_dropped$year, singer_year_dropped$artist_familiarity,desc = TRUE) %>% 
  levels() %>%  head()
```

    ## [1] "1945" "1947" "1922" "1940" "1929" "1937"

``` r
fct_reorder(singer_year_dropped$artist_name, singer_year_dropped$artist_familiarity, max) %>% 
  levels() %>%  head()
```

    ## [1] "Captain Capa"                        
    ## [2] "Ella Washington"                     
    ## [3] "Madness"                             
    ## [4] "The (International) Noise Conspiracy"
    ## [5] "Ludovico Einaudi & Ballaké Sissoko" 
    ## [6] "Fight K5"

### Common part

*Characterize the (derived) data before and after your factor re-leveling.*

File I/O
--------

Visualization design
--------------------

Writing figures to file
-----------------------

Clean up your repo!
-------------------

But I want to do more!
----------------------
