library(shiny)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
    
    # App title ----
    titlePanel("My liquor webpage"),
    
    sidebarPanel("This is my sidebar",
                 img(src = "Liquors.png", width = "100%"),
                 radioButtons("typeInput", "Product type",
                              choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                              selected = "WINE"),
                 sliderInput("priceInput", "Price", min = 0, max = 100,
                             value = c(25, 40), pre = "$"),
                 selectInput("countryInput", "Country",
                             choices = c("CANADA", "FRANCE", "ITALY"))),
    
    
    mainPanel(plotOutput("Mist_AlcCont"),
              br(),br(),
              tableOutput("table_head"))
)