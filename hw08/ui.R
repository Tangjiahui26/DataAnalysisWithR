library(shiny)
library(DT)
library(shinyjs)
library(ggvis)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
    
    useShinyjs(),
    tags$head(includeCSS("WWW/style.css")),
    tags$head(tags$script("alert('Hello! This app will help you find the right drink~');")),
    # App title ---
    
    div(id = "Header",
    titlePanel("My Liquor Store Webpage"),
    em(
        span("Created by Jiahui Tang for "),
        a("STAT547M", href ="http://stat545.com/index.html"), br(),
        span("November 19, 2017")
        
    )
    ),
    
    div( id = "Content",
    sidebarLayout(
    sidebarPanel(img(src = "Liquors.png", width = "100%"),
                 br(),br(),
                 sliderInput("priceInput", "Price", min = 0, max = 100,
                             value = c(25, 40), pre = "$"),
                 wellPanel(
                 uiOutput("typeInput"),
                 checkboxInput("checkInput","Filter by country",value = FALSE),
                 uiOutput("countryOutput")),
                 p(
                     "Data Source: ",
                     a("OpenDataBC",href = "https://www.opendatabc.ca/dataset/bc-liquor-store-product-price-list-current-prices")
                 )
                 ),
    
    mainPanel(
        tabsetPanel(
            id = "resultsTab" , type = "tabs",
        tabPanel("Plot",
                 br(),
                 textOutput("number"),
                 br(),
                 ggvisOutput("Mist_AlcCont")),
        tabPanel("Table",
                 br(),
                 downloadButton("downloadTable","Download table"),
                 br(),br(),
                 div(DT::dataTableOutput("table"), style = "font-size : 75%; width:100%"))
        )
    )
  )
)
)