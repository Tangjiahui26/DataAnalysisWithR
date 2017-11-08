
# STAT545-hw06-Jiahui-Tang

Hi, Everyone! Welcome to this repo for Homework06.:smirk:

## Homework06 Materials

### [Homework 06: Data wrangling wrap up](http://stat545.com/hw06_data-wrangling-conclusion.html)

***Character data:white_check_mark:***

***!!!Please download and check .html file if you want to review this part.!!!***

Read and work the exercises in the [Strings chapter](http://r4ds.had.co.nz/strings.html) or R for Data Science.

***Work with the`singer`data:white_check_mark:***

The singer_location dataframe in the singer package contains geographical information stored in two different formats: 1. as a (dirty!) variable named city; 2. as a latitude / longitude pair (stored in latitude, longitude respectively). The function revgeocode from the ggmap library allows you to retrieve some information for a pair (vector) of longitude, latitude (warning: notice the order in which you need to pass lat and long). 

## Report My Process

1. For the "Character data" part, I spent some time to finish it. And I encountered problems when I try to knit my .Rmd document like below. Then I find some disscusion about this on [github](https://github.com/tidyverse/reprex/issues/78). I also asked about this on Slack and finally decided to use`output:  pdf_document: latex_engine: xelatex` as I learned from @mylinhthibodeau.
```R
Error: Functions that produce HTML output found in document targeting markdown_github-ascii_identifiers output.
Please change the output type of this document to HTML. Alternatively, you can allow
HTML output in non-HTML formats by adding this option to the YAML front-matter of
your rmarkdown file:

  always_allow_html: yes

Note however that the HTML output will not be visible in non-HTML formats.
```
2. As for the second part, I did not find a better way to verify these information, but the results are kind of acceptable. Actually it has some true nagetives like `Stump Springs Rd, Lakeshore, CA 93634 USA	and "California"`,`"An der Evangelischen Kirche 6", 53113 Bonn, Germany" and "Bonn"`. Besides, it also has some false postives like`"320-398 Van Ness Ave, San Francisco, CA 94102, USA" and "New York, NY"`.

## Links

[difference-between-paste-and-paste0](https://stackoverflow.com/questions/36279800/difference-between-paste-and-paste0)

[rendering to md_document results in error if code generates HTML](https://github.com/rstudio/rmarkdown/issues/516)

[reprex cannot render str_view](https://github.com/tidyverse/reprex/issues/78)

[revgeocode](https://www.rdocumentation.org/packages/ggmap/versions/2.6.1/topics/revgeocode)

[possibly](https://www.rdocumentation.org/packages/purrr/versions/0.2.4/topics/safely)

[map_widget](https://rstudio.github.io/leaflet/map_widget.html)