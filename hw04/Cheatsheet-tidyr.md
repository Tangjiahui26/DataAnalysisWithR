Cheatsheet-tidyr
================
Jiahui Tang
2017/10/7

CheatSheet-`tidyr`
==================

*This is a cheatsheet to remind me of some tidyr functions, and it will help me with the later homeworks in STAT545 class.*

4 Main Functions
----------------

| tidyr Function | Special Powers                             |
|----------------|--------------------------------------------|
| `gather`       | long format\*                              |
| `spread`       | wide format\*                              |
| `unite`        | Unite multiple columns into one.           |
| `separate`     | Separate one column into multiple columns. |

``` r
#use mtcars in datasets to show deoms
library(tidyr)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
mtcars$car <- rownames(mtcars)
mtcars <- mtcars[, c(12, 1:11)]
head(mtcars)
```

    ##                                 car  mpg cyl disp  hp drat    wt  qsec vs
    ## Mazda RX4                 Mazda RX4 21.0   6  160 110 3.90 2.620 16.46  0
    ## Mazda RX4 Wag         Mazda RX4 Wag 21.0   6  160 110 3.90 2.875 17.02  0
    ## Datsun 710               Datsun 710 22.8   4  108  93 3.85 2.320 18.61  1
    ## Hornet 4 Drive       Hornet 4 Drive 21.4   6  258 110 3.08 3.215 19.44  1
    ## Hornet Sportabout Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0
    ## Valiant                     Valiant 18.1   6  225 105 2.76 3.460 20.22  1
    ##                   am gear carb
    ## Mazda RX4          1    4    4
    ## Mazda RX4 Wag      1    4    4
    ## Datsun 710         1    4    1
    ## Hornet 4 Drive     0    3    1
    ## Hornet Sportabout  0    3    2
    ## Valiant            0    3    1

Demos
-----

``` r
gather(data, key, value, …, na.rm = FALSE, convert = FALSE)
spread(data, key, value, fill = NA, convert = FALSE, drop = TRUE)
unite(data, col, …, sep = “_”, remove = TRUE
separate(data, col, into, sep = “[^[:alnum:]]+”, remove = TRUE, 
convert = FALSE, extra = “warn”, fill = “warn”, …)
```

### ***gather()***

``` r
#the columns except car are gathered into two columns, named attribute and value respectively
mtcarsNew <- mtcars %>% gather(attribute, value, -car)
head(mtcarsNew)
```

    ##                 car attribute value
    ## 1         Mazda RX4       mpg  21.0
    ## 2     Mazda RX4 Wag       mpg  21.0
    ## 3        Datsun 710       mpg  22.8
    ## 4    Hornet 4 Drive       mpg  21.4
    ## 5 Hornet Sportabout       mpg  18.7
    ## 6           Valiant       mpg  18.1

``` r
tail(mtcarsNew)
```

    ##                car attribute value
    ## 347  Porsche 914-2      carb     2
    ## 348   Lotus Europa      carb     2
    ## 349 Ford Pantera L      carb     4
    ## 350   Ferrari Dino      carb     6
    ## 351  Maserati Bora      carb     8
    ## 352     Volvo 142E      carb     2

``` r
#Gather all columns between map and gear, while keeping the carb and car columns unchanged
mtcarsNew <- mtcars %>% gather(attribute, value, mpg:gear)
head(mtcarsNew)
```

    ##                 car carb attribute value
    ## 1         Mazda RX4    4       mpg  21.0
    ## 2     Mazda RX4 Wag    4       mpg  21.0
    ## 3        Datsun 710    1       mpg  22.8
    ## 4    Hornet 4 Drive    1       mpg  21.4
    ## 5 Hornet Sportabout    2       mpg  18.7
    ## 6           Valiant    1       mpg  18.1

``` r
#Continuous
mtcarsNew <- mtcars %>% gather(mpg:drat, key = "attribute", value ="value", -car)
unique(mtcarsNew$attribute)
```

    ## [1] "mpg"  "cyl"  "disp" "hp"   "drat"

``` r
head(mtcarsNew)
```

    ##                 car    wt  qsec vs am gear carb attribute value
    ## 1         Mazda RX4 2.620 16.46  0  1    4    4       mpg  21.0
    ## 2     Mazda RX4 Wag 2.875 17.02  0  1    4    4       mpg  21.0
    ## 3        Datsun 710 2.320 18.61  1  1    4    1       mpg  22.8
    ## 4    Hornet 4 Drive 3.215 19.44  1  0    3    1       mpg  21.4
    ## 5 Hornet Sportabout 3.440 17.02  0  0    3    2       mpg  18.7
    ## 6           Valiant 3.460 20.22  1  0    3    1       mpg  18.1

``` r
#Discontinuous
mtcarsNew <- mtcars %>% gather(`gear`,`carb`,key = "attribute", value = "value", -car)
head(mtcarsNew)
```

    ##                 car  mpg cyl disp  hp drat    wt  qsec vs am attribute
    ## 1         Mazda RX4 21.0   6  160 110 3.90 2.620 16.46  0  1      gear
    ## 2     Mazda RX4 Wag 21.0   6  160 110 3.90 2.875 17.02  0  1      gear
    ## 3        Datsun 710 22.8   4  108  93 3.85 2.320 18.61  1  1      gear
    ## 4    Hornet 4 Drive 21.4   6  258 110 3.08 3.215 19.44  1  0      gear
    ## 5 Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0      gear
    ## 6           Valiant 18.1   6  225 105 2.76 3.460 20.22  1  0      gear
    ##   value
    ## 1     4
    ## 2     4
    ## 3     4
    ## 4     3
    ## 5     3
    ## 6     3

``` r
unique(mtcarsNew$attribute)
```

    ## [1] "gear" "carb"

### ***spread()***

``` r
#Separate one column into multiple columns.
mtcarsSpread <- mtcarsNew %>% spread(attribute, value)
head(mtcarsSpread)
```

    ##                 car  mpg cyl disp  hp drat    wt  qsec vs am carb gear
    ## 1         Mazda RX4 21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
    ## 2     Mazda RX4 Wag 21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
    ## 3        Datsun 710 22.8   4  108  93 3.85 2.320 18.61  1  1    1    4
    ## 4    Hornet 4 Drive 21.4   6  258 110 3.08 3.215 19.44  1  0    1    3
    ## 5 Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    2    3
    ## 6           Valiant 18.1   6  225 105 2.76 3.460 20.22  1  0    1    3

### ***unite()***

``` r
#First make a data frame
set.seed(1)
date <- as.Date('2017-10-07') + 0:14
hour <- sample(1:24, 15)
min <- sample(1:60, 15)
second <- sample(1:60, 15)
event <- sample(letters, 15)
data <- data.frame(date, hour, min, second, event)
data
```

    ##          date hour min second event
    ## 1  2017-10-07    7  30     29     u
    ## 2  2017-10-08    9  43     36     a
    ## 3  2017-10-09   13  58     60     l
    ## 4  2017-10-10   20  22     11     q
    ## 5  2017-10-11    5  44     47     p
    ## 6  2017-10-12   18  52     37     k
    ## 7  2017-10-13   19  12     43     r
    ## 8  2017-10-14   12  35      6     i
    ## 9  2017-10-15   11   7     38     e
    ## 10 2017-10-16    1  14     21     b
    ## 11 2017-10-17    3  20     42     w
    ## 12 2017-10-18   14   1     32     t
    ## 13 2017-10-19   23  19     52     h
    ## 14 2017-10-20   21  41     26     s
    ## 15 2017-10-21    8  16     25     o

``` r
dataNew <- data %>%unite(datehour, date, hour, sep = ' ') %>%unite(datetime, datehour, min, second, sep = ':')
dataNew
```

    ##               datetime event
    ## 1   2017-10-07 7:30:29     u
    ## 2   2017-10-08 9:43:36     a
    ## 3  2017-10-09 13:58:60     l
    ## 4  2017-10-10 20:22:11     q
    ## 5   2017-10-11 5:44:47     p
    ## 6  2017-10-12 18:52:37     k
    ## 7  2017-10-13 19:12:43     r
    ## 8   2017-10-14 12:35:6     i
    ## 9   2017-10-15 11:7:38     e
    ## 10  2017-10-16 1:14:21     b
    ## 11  2017-10-17 3:20:42     w
    ## 12  2017-10-18 14:1:32     t
    ## 13 2017-10-19 23:19:52     h
    ## 14 2017-10-20 21:41:26     s
    ## 15  2017-10-21 8:16:25     o

### ***separate()***

``` r
data1 <- dataNew %>%separate(datetime, c('date', 'time'), sep = ' ') %>%separate(time, c('hour', 'min', 'second'), sep = ':')
data1
```

    ##          date hour min second event
    ## 1  2017-10-07    7  30     29     u
    ## 2  2017-10-08    9  43     36     a
    ## 3  2017-10-09   13  58     60     l
    ## 4  2017-10-10   20  22     11     q
    ## 5  2017-10-11    5  44     47     p
    ## 6  2017-10-12   18  52     37     k
    ## 7  2017-10-13   19  12     43     r
    ## 8  2017-10-14   12  35      6     i
    ## 9  2017-10-15   11   7     38     e
    ## 10 2017-10-16    1  14     21     b
    ## 11 2017-10-17    3  20     42     w
    ## 12 2017-10-18   14   1     32     t
    ## 13 2017-10-19   23  19     52     h
    ## 14 2017-10-20   21  41     26     s
    ## 15 2017-10-21    8  16     25     o

Links
-----

[gather From tidyr v0.7.1 by Hadley Wickham](https://www.rdocumentation.org/packages/tidyr/versions/0.7.1/topics/gather)

[spread From tidyr v0.7.1 by Hadley Wickham](https://www.rdocumentation.org/packages/tidyr/versions/0.7.1/topics/spread)

[unite From tidyr v0.7.1 by Hadley Wickham](https://www.rdocumentation.org/packages/tidyr/versions/0.7.1/topics/unite)

[separate From tidyr v0.7.1 by Hadley Wickham](https://www.rdocumentation.org/packages/tidyr/versions/0.7.1/topics/separate)

[R-tidyr](http://www.cnblogs.com/nxld/p/6060533.html)
