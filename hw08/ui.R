library(shiny)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
    
    # App title ----
    titlePanel("My Liquor Store Webpage"),
    sidebarLayout(
    sidebarPanel("This is my sidebar",
                 img(src = "Liquors.png", width = "100%"),
                 br(),br(),
                 wellPanel(
                 uiOutput("typeInput"),
                 sliderInput("priceInput", "Price", min = 0, max = 100,
                             value = c(25, 40), pre = "$"),
                 checkboxInput("checkInput","Filter by country",value = FALSE),
                 conditionalPanel(
                     condition = "input.checkInput == 'TRUE'",
                     uiOutput("countryOutput"))
                 )),
    
    mainPanel(
        tabsetPanel(
        tabPanel("Plot", plotOutput("Mist_AlcCont")),
        tabPanel("Table", tableOutput("table_head"))
        )
    )
  )
)