
# STAT547M-hw10-Jiahui-Tang

Hi, Everyone! Welcome to this repo for Homework10.:smirk:

## Homework10 Materials

### [Homework 10: Data from the Web](http://stat545.com/hw10_data-from-web.html)

***Make API queries “by hand” using`httr`*** :white_check_mark:

Create a dataset with multiple records by requesting data from an API using the httr package.

GET() data from the API and convert it into a clean and tidy data frame. Store that as a file ready for (hypothetical!) downstream analysis. Do just enough basic exploration of the resulting data, possibly including some plots, that you and a reader are convinced you’ve successfully downloaded and cleaned it.

*In this part, I created a project called [BestPlaceCA](https://github.com/Tangjiahui26/BestPlaceCA). I used`make`to break my work into separate scripts.*

***Scrape data*** :white_check_mark:

Work through the final set of slides from the rOpenSci UseR! 2016 workshop. This will give you basic orientation, skills, and pointers on the rvest package.

Scrape a multi-record dataset off the web! Convert it into a clean and tidy data frame. Store that as a file ready for (hypothetical!) downstream analysis. Do just enough basic exploration of the resulting data, possibly including some plots, that you and a reader are convinced you’ve successfully downloaded and cleaned it.

*In this part, I created a project called [OMDbAPI](https://github.com/Tangjiahui26/BestPlaceCA). I used`make`to break my work into separate scripts, though I personally think that it will be better to build a R package for this part because I created some uesful functions.*

## Report My Process

### BestPlaceCA

I followed the tutorial of @ropensci and scraped some data about the Cost-of-Living and Job of Counties in California. I used some functions like`read_html()`,`html_nodes()`and`html_attr()`to get useful data without using API. The website that I used is [bestplaces](https://www.bestplaces.net).

***Problems:***

1. 


### OMDbAPI

I used [OMDb API](http://www.omdbapi.com) to get some simple information about movies. Three functions were created to simplify the process:

`Search_by_name()`: Search movie by name and page. We can only request for one page results every time and the`page`paramter was set as 1 by default.

`Get_Ratings()`: Get the ratings of movie when giving IMDb ID as the input. The ratings include: `IMDb`,`RottenTomatoes`and`Metacritic`.

`Get_Ratings_By_name()`: Combine the functions above to get the ratings by giving search name and page number.

***Problems:***

## Links

