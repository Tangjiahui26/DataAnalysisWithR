library(shiny)
library(tidyverse)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
    bcl_data <- read_csv("Data/bcl-data.csv")
    
    Filtered_bcl <- reactive({
        bcl_data %>% 
            filter(Price >= input$priceInput[1],
                   Price <= input$priceInput[2],
                   Type == input$typeInput) 
    })
    
    output$Mist_AlcCont <- renderPlot({
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
