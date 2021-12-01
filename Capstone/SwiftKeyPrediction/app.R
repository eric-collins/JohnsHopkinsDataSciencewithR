library(shiny)


source("helpers.R", local = TRUE)
models <- readRDS("data/models.RDS")

ui <- fluidPage(
    
    includeCSS("./custom_style.css"),
    
    theme = bslib::bs_theme(bootswatch = "darkly"),
    
    
    titlePanel("Word Prediction Using Markov Chains"),
    
    sidebarLayout(
        mainPanel(h4(textInput("user_input", label = "Enter Text for Prediction", placeholder = "Type Text Here"))),
        sidebarPanel(h4("Predicted Word"),
                     h5(textOutput("prediction")))

    
))



server <- function(input, output) {
    

    
    output$prediction <- renderText({
        prediction <- make_prediction(tolower(input$user_input))
        prediction
    })
    
}

shinyApp(ui = ui, server = server)
