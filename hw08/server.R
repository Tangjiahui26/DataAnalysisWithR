library(shiny)
library(tidyverse)
library(DT)
library(shinyjs)
library(ggvis)

# Define server logic required to draw a histogram ----
server <- function(input, output, session) {
    bcl_data <- read_csv("Data/bcl-data.csv")
    
    #using uiOutput() to create UI elements dynamically
    output$countryOutput <- renderUI({
        if(input$checkInput)
            selectInput("countryInput","Country",
                        sort(unique(bcl_data$Country)),
                        selected = "CANADA",
                        multiple = TRUE)
    })
    
    output$typeInput <- renderUI({
        selectInput("typeInput", "Product type",
                      sort(unique(bcl_data$Type)),
                     selected = "WINE",
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
                               Type %in% input$typeInput)
                }
            } else {
                if(is.null(input$typeInput)){
                    bcl_data %>% 
                        filter(Price >= input$priceInput[1],
                               Price <= input$priceInput[2],
                               Country %in% input$countryInput)
                }else{
                    bcl_data %>% 
                        filter(Price >= input$priceInput[1],
                               Price <= input$priceInput[2],
                               Country %in% input$countryInput,
                               Type %in% input$typeInput)
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
                           Type %in% input$typeInput)
            }
        }
    
    })
    #Use ggvis to make plots
    reactive({
        Filtered_bcl() %>% 
            ggvis(~Alcohol_Content, fill := "#f5edc9") %>% 
            layer_histograms(width = 1, center = 0)
   }) %>% bind_shiny("Mist_AlcCont")
    #Table
    output$table <- DT::renderDataTable({
        Filtered_bcl()
    })
    #Show the rows of the result
    output$number <- renderText({
        c("We found ",nrow(Filtered_bcl()),"results for you")
    })
    #Download files
    output$downloadTable <- downloadHandler(
        filename = function(){
            "Table.csv"
        },
        content = function(file){
            write.table(x = Filtered_bcl(),
                        file = file,
                        quote = FALSE,
                        sep = ",",
                        row.names = FALSE)
        }
    )
    
}
