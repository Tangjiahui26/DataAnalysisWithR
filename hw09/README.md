
# STAT547M-hw09-Jiahui-Tang

Hi, Everyone! Welcome to this repo for Homework09.:smirk:

## Homework09 Materials

### [Homework 09: Building your own R package](http://stat545.com/hw09_package.html)

My`foofactors`package is [here](https://github.com/Tangjiahui26/foofactors), [README.md](https://github.com/Tangjiahui26/foofactors/blob/master/README.md),[vignettes](https://github.com/Tangjiahui26/foofactors/blob/master/vignettes/hello-foofactors.md)

All Rscript files in the package are [here](https://github.com/Tangjiahui26/foofactors/tree/master/R)

All test files are [here](https://github.com/Tangjiahui26/foofactors/tree/master/tests/testthat)

***Please click the links above if you want to review my homework09***

***And put your peer review in the [issue](https://github.com/Tangjiahui26/STAT545-hw-Tang-Jiahui/issues/11) of this repo, thanks~***

### Building your own R package

In this homework you will either continue developing the powers package developed in class or Jenny’s [`foofactors`](https://github.com/jennybc/foofactors)package; or create your own package. If you do the latter, you must hit all the same points but you’ll be starting from scratch.

## Report My Process

I created five additional functions based on Jenny's package:

[`detect_factors()`](https://github.com/Tangjiahui26/foofactors/blob/master/R/detect_factors.R) - detect factors that should be character because number of unique values equal to the length

[`check_factors()`](https://github.com/Tangjiahui26/foofactors/blob/master/R/check_factors.R) - check if your dataframe contains any factors you don't want to use.

[`new_reorder()`](https://github.com/Tangjiahui26/foofactors/blob/master/R/new_reorder.R) - a new version of reorder() that uses`desc()`and dplyr

[`new_factor()`](https://github.com/Tangjiahui26/foofactors/blob/master/R/new_factors.R) - a new version of factor() that sets levels to the order in which they appear in the data

[`new_factor_rev()`](https://github.com/Tangjiahui26/foofactors/blob/master/R/new_factors.R) - a new version of factor() that sets levels to the reverse order in which they appear in the data

### Problems

*I encountered with some problems when my package:*

1. When I tried to check my package, I received a note shown below. I just change`reorder()` into`stats::reorder`, although I think it is not a big deal.

```R
checking R code for possible problems ... NOTE
new_reorder: no visible global function definition for ‘reorder’
Undefined global functions or variables:
  reorder
Consider adding
  importFrom("stats", "reorder")
to your NAMESPACE file.
```

2. I don't know how to convert my vignettes Rmd file into md or HTML file even through I followed Jenny's note to change the YAML as follows:

```R
output:
  rmarkdown::html_vignette:
    toc: true
    keep_md: true
```
Finally, I tried option 1 of Jenny's notes, and it worked:

```R
build_vignettes()
## Build and reload !!!
```

## Links

[How to order the levels of factors according to the ordering of a data.frame (and not alphabetically)](https://stackoverflow.com/questions/25098107/how-to-order-the-levels-of-factors-according-to-the-ordering-of-a-data-frame-an)

[Reorder levels of a factor without changing order of values](https://stackoverflow.com/questions/2375587/reorder-levels-of-a-factor-without-changing-order-of-values)

