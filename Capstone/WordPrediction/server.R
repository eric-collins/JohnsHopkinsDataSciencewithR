library(shiny)
source("helpers.R")


models <- readRDS("./data/models.RDS")



shinyServer(function(input, output) {
    
    
    output$prediction <- renderText({
        prediction <- make_prediction(tolower(input$user_input))
        prediction
    })

    })