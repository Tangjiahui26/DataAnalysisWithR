hw07-Tang-Jiahui
================
Jiahui Tang
2017/11/14

***Make some figures first***

![](./figures/GdpPercap%20for%20all%20continents.png)

The spread of GDP per capita within the continents

![](./figures/GdpPercap%20histogram%20for%20each%20continent.png)

Plot mean of life expectancy for different years

![](./figures/Means%20of%20Life%20Expectancy%20for%20different%20years.png)

Make a plot of GDP for countries' iso\_code between 120 and 170

![](./figures/GDP%20for%20some%20countries%20or%20areas.png)

***Reorder the continents based on life expectancy.*** + Use the forcats package to change the order

``` r
reordered_data <- read.delim("03_reordered.rds")
```

    ## Warning in read.table(file = file, header = header, sep = sep, quote =
    ## quote, : line 2 appears to contain embedded nulls

    ## Warning in read.table(file = file, header = header, sep = sep, quote =
    ## quote, : line 3 appears to contain embedded nulls

    ## Warning in read.table(file = file, header = header, sep = sep, quote =
    ## quote, : line 4 appears to contain embedded nulls

    ## Warning in read.table(file = file, header = header, sep = sep, quote =
    ## quote, : line 5 appears to contain embedded nulls

    ## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
    ## dec, : EOF within quoted string

    ## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
    ## dec, : embedded nul(s) found in input

``` r
head(reordered_data)
```

    ##            X
    ## 1 Bangladesh
    ## 2 Bangladesh
    ## 3 Bangladesh
    ## 4 Bangladesh
    ## 5 Bangladesh
    ## 6 Bangladesh

Reorder the continents based on life expectancy Plot the two different figures ![](./figures/MaxLifeExp%20for%20each%20continent%20reordered.png)

![](./figures/MaxLifeExp%20for%20each%20continent%20unreordered.png)

Create a figure for each continent, and write one file per continent, with an informative name.

![](./figures/Asia-scatterplots%20of%20life%20expectancy_vs_year.png)

![](./figures/Americas-scatterplots%20of%20life%20expectancy_vs_year.png)

![](./figures/Africa-scatterplots%20of%20life%20expectancy_vs_year.png)

![](./figures/Europe-scatterplots%20of%20life%20expectancy_vs_year.png)

![](./figures/Oceania-scatterplots%20of%20life%20expectancy_vs_year.png)
