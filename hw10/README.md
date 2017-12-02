
# STAT547M-hw10-Jiahui-Tang

Hi, Everyone! Welcome to this repo for Homework10.:smirk:

## Homework10 Materials

### [Homework 10: Data from the Web](http://stat545.com/hw10_data-from-web.html)

***Make API queries “by hand” using`httr`*** :white_check_mark:

Create a dataset with multiple records by requesting data from an API using the httr package.

GET() data from the API and convert it into a clean and tidy data frame. Store that as a file ready for (hypothetical!) downstream analysis. Do just enough basic exploration of the resulting data, possibly including some plots, that you and a reader are convinced you’ve successfully downloaded and cleaned it.

+ **In this part, I created a project called [OMDbAPI](https://github.com/Tangjiahui26/OMDbAPI). I used`make`to break my work into separate scripts, though I personally think that it will be better to build a R package for this part because I created some uesful functions.**

***Scrape data*** :white_check_mark:

Work through the final set of slides from the rOpenSci UseR! 2016 workshop. This will give you basic orientation, skills, and pointers on the rvest package.

Scrape a multi-record dataset off the web! Convert it into a clean and tidy data frame. Store that as a file ready for (hypothetical!) downstream analysis. Do just enough basic exploration of the resulting data, possibly including some plots, that you and a reader are convinced you’ve successfully downloaded and cleaned it.

+ **In this part, I created a project called [BestPlaceCA](https://github.com/Tangjiahui26/BestPlaceCA). I used`make`to break my work into separate scripts.**

## Report My Process

### [OMDbAPI](https://github.com/Tangjiahui26/OMDbAPI)

I used [OMDb API](http://www.omdbapi.com) to get some simple information about movies. Three functions were created to simplify the process:

`Search_by_name()`: Search movie by name and page. We can only request for one page results every time and the`page`paramter was set as 1 by default.

`Get_Ratings()`: Get the ratings of movie when giving IMDb ID as the input. The ratings include: `IMDb`,`RottenTomatoes`and`Metacritic`.

`Get_Ratings_By_name()`: Combine the functions above to get the ratings by giving search name and page number.

***Problems:***

1. I don't know how to get all the results using`OMDb API`since we can only get one page every time, so it doesn't work if you enter a large page number.

2. There is an error in My codes that I don't know hwo to fix it. I used`Search_by_name("Resident+Evil",4)` and found that it has only seven movies in page4, but Get_Ratings_By_name() did not work well in this page, it showed a error like`Error: Column index must be at least 0 if negative, not -1`. By the way,`Get_Ratings_By_name("Resident+Evil",1)`, `Get_Ratings_By_name("Resident+Evil",2)` and `Get_Ratings_By_name("Resident+Evil",3)` worked well in my code.

```R
Get_Ratings_By_name <- function(name, page = 1){
    result <- Search_by_name(name, page)
    Output <- lapply(result$imdbID[1:nrow(result)],Get_Ratings)
    Output <- merge_recurse(Output)
    return(Output)
}
```

### [BestPlaceCA](https://github.com/Tangjiahui26/BestPlaceCA)

I followed the tutorial of @ropensci and scraped some data about the Cost-of-Living and Job of Counties in California. I used some functions like`read_html()`,`html_nodes()`and`html_attr()`to get useful data without using API. The website that I used is [bestplaces](https://www.bestplaces.net).

***Problems:***

1. I want to merge several data.frames into one data.frame with a loop. Finally I picked`merge_recurse()` with the`reshape`package from [stackoverflow](https://stackoverflow.com/questions/2209258/merge-several-data-frames-into-one-data-frame-with-a-loop/2209371). The code shows as below:

```R
All_city_job <- lapply(unique(CA_counties$Link), Get_table)
All_city_job <- merge_recurse(All_city_job)
```
But`lapply()`works very slow, so as I mentioned in`README.md`, please wait for a while if you want to bulid it.

2. I tried to use general ways to extract useful data from websites; However, It is hard to find the class of`<a href="../county/california/marin">Marin</a>`, so I just did it manually by using codes shown below:

```R
#Extract some Links 
bestplace_ca_link <- bestplace_ca %>% 
    html_nodes("a") %>% 
    html_attr("href")

#Extract some text(ounties' name) 
bestplace_ca_counties <- bestplace_ca %>% 
    html_nodes("a") %>% 
    html_text()

#Create a new data.frame for CA_counties
CA_counties <- data.frame(
    State = "California",
    Counties = bestplace_ca_counties[55:112],
    Link = bestplace_ca_link[55:112]
)
```

## Links

[merge-several-data-frames-into-one-data-frame-with-a-loop](https://stackoverflow.com/questions/2209258/merge-several-data-frames-into-one-data-frame-with-a-loop/2209371)

[how-do-i-flip-rows-and-columns-in-r](https://stackoverflow.com/questions/33643181/how-do-i-flip-rows-and-columns-in-r)

[how-to-deal-with-ggplot2-and-overlapping-labels-on-a-discrete-axis](https://stackoverflow.com/questions/30598347/how-to-deal-with-ggplot2-and-overlapping-labels-on-a-discrete-axis)

[ggplot2-add-straight-lines-to-a-plot-horizontal-vertical-and-regression-lines](http://www.sthda.com/english/wiki/ggplot2-add-straight-lines-to-a-plot-horizontal-vertical-and-regression-lines)

[add-a-horizontal-line-to-plot-and-legend-in-ggplot2](https://stackoverflow.com/questions/13254441/add-a-horizontal-line-to-plot-and-legend-in-ggplot2)
