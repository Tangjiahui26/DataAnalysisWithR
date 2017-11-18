library(shiny)
library(tidyverse)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
    bcl_data <- read_csv("Data/bcl-data.csv")
    
    #using uiOutput() to create UI elements dynamically
    output$countryOutput <- renderUI({
        selectInput("countryInput","country",
                    sort(unique(bcl_data$Country)),
                    selected = "CANADA")
    })
    
    output$typeInput <- renderUI({
        radioButtons("typeInput", "Product type",
                     choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                     selected = "BEER")
    })
    
    Filtered_bcl <- reactive({
        #solve the problem that errors showing up and quickly disappering
        if(is.null(input$countryInput)){
            return(NULL)
        }
        
        bcl_data %>% 
            filter(Price >= input$priceInput[1],
                   Price <= input$priceInput[2],
                   Type == input$typeInput,
                   Country == input$countryInput) 
    })
    
    output$Mist_AlcCont <- renderPlot({
        if(is.null(Filtered_bcl())){
            return()
        }
        Filtered_bcl() %>% 
            ggplot()+
            aes(x = Alcohol_Content)+
            geom_histogram()
    })
    
    output$table_head <- renderTable({
        Filtered_bcl() %>% 
            head()
    })

}
