
# STAT545-hw03-Jiahui-Tang

Hi, Everyone! Welcome to this repo for Homework03.:smirk:

## Homework03 Materials

### [Homework 03: Use dplyr to manipulate and explore data (also use ggplot2)](https://stat545.com/hw03_dplyr-and-more-ggplot2.html)

***Task menu*** 
Pick at least three of the tasks below and attack each with a table and figure.

1. Get the maximum and minimum of GDP per capita for all continents.:white_check_mark:

2. Look at the spread of GDP per capita within the continents.:white_check_mark:

3. Compute a trimmed mean of life expectancy for different years. Or a weighted mean, weighting by population. Just try something other than the plain vanilla mean.:white_check_mark:

4. How is life expectancy changing over time on different continents?:white_check_mark:

5. Report the absolute and/or relative abundance of countries with low life expectancy over time by continent: Compute some measure of worldwide life expectancy – you decide – a mean or median or some other quantile or perhaps your current age. Then determine how many countries on each continent have a life expectancy less than this benchmark, for each year.

6. Find countries with interesting stories. Open-ended and, therefore, hard. Promising but unsuccessful attempts are encouraged. This will generate interesting questions to follow up on in class.:white_check_mark:

Make up your own! Between the dplyr coverage in class and the list above, I think you get the idea.

***But I want to do more!***

1. Layout stretch goal: get table and figure side-by-side. [This gist](https://gist.github.com/jennybc/e9e9aba6ba18c72cec26) might get you started.

2. Table stretch goal: there are some really nice fancy table helper packages. [This tweet from @polesasunder](https://twitter.com/polesasunder/status/464132152347475968) will point you toward some R packages you may want to check out (pander, xtable, stargazer).

## Report My Process

1. Homework03 gave us opportunity to manipulate and explore data in different way, and we can also find our own data and analyze using figures and tables. The whole process was very interesting and I learned a lot.

2. For task1, I am kind of confused if I should print the detailed information of the countries which have the max or min GDP per capita. Besides, I also do not know whether we should use `ggplot2` to find the the maximum and minimum of GDP per capita for all continents, or say, we can just make figures for the results gained from using `dplyr`. Anyway, I did both and I think it was a little tough since I spent a lot of time on this task.

3. As for how to plot two variables as lines on the same graph, I found a question on [stackoverflow](https://stackoverflow.com/questions/3777174/plotting-two-variables-as-lines-using-ggplot2-on-the-same-graph), and I learned from this website and finally succeeded.

4. From Task2 and task4, we can easily find that sometimes figures are more intuitive than tables and allow us to find some subtle changes.

5. For task6, I found it was hard to add labels for density figures, maybe I should adjust the position, but I do not know how to do this, So I just print some countries on the figures.  

## Links
[Highlight minimum and maximum points in faceted ggplot2 graph in R](https://stackoverflow.com/questions/29375169/highlight-minimum-and-maximum-points-in-faceted-ggplot2-graph-in-r)

[Plotting two variables as lines using ggplot2 on the same graph](https://stackoverflow.com/questions/3777174/plotting-two-variables-as-lines-using-ggplot2-on-the-same-graph)

[Window functions/lead() and lag()](https://cran.r-project.org/web/packages/dplyr/vignettes/window-functions.html)

[geom_density](http://ggplot.yhathq.com/docs/geom_density.html)

[geom_text](http://ggplot.yhathq.com/docs/geom_text.html)