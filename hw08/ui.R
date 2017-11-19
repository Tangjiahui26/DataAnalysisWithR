library(shiny)
library(DT)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
    
    # App title ----
    titlePanel("My Liquor Store Webpage"),
    sidebarLayout(
    sidebarPanel("This is my sidebar",
                 img(src = "Liquors.png", width = "100%"),
                 br(),br(),
                 sliderInput("priceInput", "Price", min = 0, max = 100,
                             value = c(25, 40), pre = "$"),
                 wellPanel(
                 uiOutput("typeInput"),
                 checkboxInput("checkInput","Filter by country",value = FALSE),
                 uiOutput("countryOutput"))
                 ),
    
    mainPanel(
        tabsetPanel(
        tabPanel("Plot", "plotTab",
                 downloadButton("downloadPlot","Download plot"),
                 plotOutput("Mist_AlcCont")),
        tabPanel("Table","tableTab", 
                 downloadButton("downloadTable","Download table"),
                 DT::dataTableOutput("table_head"))
        )
    )
  )
)