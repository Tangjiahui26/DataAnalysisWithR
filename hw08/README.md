
# STAT547M-hw08-Jiahui-Tang

Hi, Everyone! Welcome to this repo for Homework08.:smirk:

## Homework08 Materials

### [Homework 08: Building Shiny apps](http://stat545.com/hw08_shiny.html)

***Build a new Shiny app***

The app we developed is functional, but there are plenty of improvements that can be made. You can compare the app we developed to Dean’s version of this app to get an idea of what a more functional app could include. For the homework, you need to either develop a new Shiny app, using your preferred dataset (or one you want to know more about). If you are short on ideas, you can instead add 3 or more features to the BC Liquor Store app we developed together.

## Report My Process

*In this part, I decided to improve the BC Liquor websit that we have developed in class.*

*The final Shiny app is deployed online on`Shinyapps.io`, and the link is [here: My Liquor Store Webpage](https://tangjiahui26.shinyapps.io/hw08/)*

### Features I Added to My App

+ Add an option to sort the results by`country` using`checkboxInput()` to get TRUE/FALSE values from use. :white_check_mark:

+ Add an image of the Liquor Store to the UI.:white_check_mark:
    
    - I embeded the picture into the sidebarPanel
    - The picture was downloaded from Internet and stored at`./WWW` document

+ Use the`DT` package to return the current results table into an interactive table. :white_check_mark:

+ Solve the warning message when the user selects filters that return 0 results. :white_check_mark:

    - Inside the filtered reactive function, we should check if the input exists, and if not then just return NULL.  
    - *I have finished this part in advance, but actually I changed the`if else` statement with new logic to get multiple results later*.
    
+ Place the plot and the table in separate tabs. :white_check_mark:

+ Add a CSS file under WWW and make your app look nicer. :white_check_mark:

    - `shinyjs` was used to help load CSS and JaveScript. I wrote a simple CSS include adding background, setting the font-size and characters' color. An Alterbox will appear to introduce the main function of the website by using JS.
    
+ Experiment with packages that add extra features to Shiny, such as`shinyjs, leaflet, shinydashboard, shinythemes, ggvis`. :white_check_mark:

    - As I mentioned above, I used`shinyjs` to make my website more beautiful. In addition, I also applied`ggvis` to get more suitable plots for HTML instead of `ggplot`.
    
+ Show the number of results found whenever the filters change. :white_check_mark:

+ Allow the user to download the results. :white_check_mark:

    - In this part, plots actually can be download by the default functions of`ggvis`, so I just set one downloadbox to store the table results.
    
+ Allow the usr to search for multiple alcohol types and countries simultaneously. :white_check_mark:

    - I set a`checkbox` for user if they want to filter the results by countries. I also made the filter part multi-selection by adding some`if else` codes.
    
### Problems

*I encountered with some problems when buliding my app, most of them were solved by myself or searching online:*

1. I tried to add a checkbox to filter the results by countries. At first I was using conditinalPanel() as follows, but it did not work. Finally I just added a logical judgement statement:`if(input$checkInput)` to deal with it.

```R
 checkboxInput("checkInput","Filter by country",value = FALSE),
               #  conditionalPanel(
               #      condition = "input.checkInput == 'TRUE'",
                     uiOutput("countryOutput"))
                 )),
```

2. When using`ggvis` to make plots, I met with error with codes below. 

```R
    output$Mist_AlcCont <- renderPlot({
        if(is.null(Filtered_bcl())){
            return()
        }
        Filtered_bcl() %>% 
            ggvis(~Alcohol_Content, fill := "#fff8dc") %>% 
            layer_histograms(width = 2, center = 0)
    })
```

I found some questions similar on stackoverflow, and changed my codes as follow. `plotOutput()` also changed into `ggvisOutput`

```R
reactive({
        Filtered_bcl() %>% 
            ggvis(~Alcohol_Content, fill := "#f5edc9") %>% 
            layer_histograms(width = 1, center = 0)
   }) %>% bind_shiny("Mist_AlcCont")
```
[how-is-data-passed-from-reactive-shiny-expression-to-ggvis-plot?](https://stackoverflow.com/questions/25011544/how-is-data-passed-from-reactive-shiny-expression-to-ggvis-plot?rq=1)
[reactivity-renderplot-not-working-in-ggvis-shiny](https://stackoverflow.com/questions/30566073/reactivity-renderplot-not-working-in-ggvis-shiny)
[shiny-discuss](https://groups.google.com/forum/#!topic/shiny-discuss/-hJSr9NiYck)
    
3. I met with a silly error which took me a long time to solve. When choosing multiple countries or types, the number of results decreased instead of being larger. Then I found that I should change`==` into `%in%`, I think I still not so familiar with ShinyApp, especially the functions and its parameters and outputs.

```R    
    Type %in% input$typeInput
```

4. I found a problem with DT table: I cannot shrink the dtdatatable by changing value of `width`, and the table won't be shrinked when resizing the browser window. I added CSS script to change the font size later to make it looks better, but the problem still exists.
```R
    #before
    DT::dataTableOutput("table",width = "100%", height = "auto"))
    #later
    div(DT::dataTableOutput("table"), style = "font-size: 75%; width: 75%")
```
[shrink-dtdatatableoutput-size](https://stackoverflow.com/questions/31921238/shrink-dtdatatableoutput-size)
    
[adjusting-the-width-of-the-datatable-using-dt-in-r](https://stackoverflow.com/questions/46709404/adjusting-the-width-of-the-datatable-using-dt-in-r?noredirect=1&lq=1)

## Links

[shiny-app-checkboxinput-and-conditionalpanel](https://stackoverflow.com/questions/34115076/shiny-app-checkboxinput-and-conditionalpanel)

[shinyjs](https://github.com/daattali/shinyjs)

[DT](https://rstudio.github.io/DT/)

[ggvis-basics](http://ggvis.rstudio.com/ggvis-basics.html)