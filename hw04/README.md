
# STAT545-hw04-Jiahui-Tang

Hi, Everyone! Welcome to this repo for Homework04.:smirk:

## Homework04 Materials

### [Homework 04: Tidy data and joins](http://stat545.com/hw04_tidy-data-joins.html)

***General data reshaping and relationship to aggregation***

- Problem: You have data in one “shape” but you wish it were in another. Usually this is because the alternative shape is superior for presenting a table, making a figure, or doing aggregation and statistical analysis.

- Solution: Reshape your data. For simple reshaping, gather() and spread() from tidyr will suffice. Do the thing that it possible / easier now that your data has a new shape.

- [x] Activity1
- [x] Activity2

***Join, merge, look up***

- Problem: You have two data sources and you need info from both in one new data object.

- Solution: Perform a join, which borrows terminology from the database world, specifically SQL.

- [x] Activity1

## Report My Process

1. I think that homework04 is not so hard, but I still came acorss some problems. Because we have done lots of work about data wrangling and how to use the tidyverse, we can easily finish the assignment by learning from the previous class notes.

2. I found it is easy to put multiple graphs on the same page using [ggplot2.multiplot](http://www.sthda.com/english/wiki/ggplot2-multiplot-put-multiple-graphs-on-the-same-page-using-ggplot2). This function is from `easyGgplot2 package`, and can be used by calling `ggplot2.multiplot(..., plotlist=NULL, cols=2)`.

3. I failed to use GNcountryInfo() to get more countryInfo, so I just added countryCode into gapminder. Besides, I did not konw how to make scale of x axis consisitent with the y axis when I was plotting the lifeExp graph, so I uesd `scale_y_continuous(breaks = c(40, 50, 60, 70, 80))`, but it did not work well.

## Links
[RStudio Data Wrangling cheatsheet, covering dplyr and tidyr.](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)

[ggplot2.multiplot : Put multiple graphs on the same page using ggplot2](http://www.sthda.com/english/wiki/ggplot2-multiplot-put-multiple-graphs-on-the-same-page-using-ggplot2)

[Axes (ggplot2)](http://www.cookbook-r.com/Graphs/Axes_(ggplot2)/)