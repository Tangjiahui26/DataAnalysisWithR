library(shiny)
library(tidyverse)
library(DT)

# Define server logic required to draw a histogram ----
server <- function(input, output, session) {
    bcl_data <- read_csv("Data/bcl-data.csv")
    
    #using uiOutput() to create UI elements dynamically
    output$countryOutput <- renderUI({
        if(input$checkInput)
            selectizeInput("countryInput","Country",
                        sort(unique(bcl_data$Country)),
                        selected = "CANADA",
                        multiple = TRUE)
    })
    
    output$typeInput <- renderUI({
        selectizeInput("typeInput", "Product type",
                      sort(unique(bcl_data$Type)),
                     selected = unique(bcl_data$Type),
                     multiple = TRUE)
    })
    
    Filtered_bcl <- reactive({
    #Show the results according to users' choices
        if(input$checkInput){
            if(is.null(input$countryInput)){
                if(is.null(input$typeInput)){
                    bcl_data %>% 
                        filter(Price >= input$priceInput[1],
                               Price <= input$priceInput[2]) 
                }else{
                    bcl_data %>% 
                        filter(Price >= input$priceInput[1],
                               Price <= input$priceInput[2],
                               Type == input$typeInput)
                }
            } else {
                if(is.null(input$typeInput)){
                    bcl_data %>% 
                        filter(Price >= input$priceInput[1],
                               Price <= input$priceInput[2],
                               Country == input$countryInput)
                }else{
                    bcl_data %>% 
                        filter(Price >= input$priceInput[1],
                               Price <= input$priceInput[2],
                               Country == input$countryInput,
                               Type == input$typeInput)
                }
            }
        } else{
            if(is.null(input$typeInput)){
                bcl_data %>% 
                    filter(Price >= input$priceInput[1],
                           Price <= input$priceInput[2])
            }else{
                bcl_data %>% 
                    filter(Price >= input$priceInput[1],
                           Price <= input$priceInput[2],
                           Type == input$typeInput)
            }
        }
    
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
    
       output$table_head <- DT::renderDataTable({
        Filtered_bcl()
    })
    
}
