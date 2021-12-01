library(shiny)

shinyUI(fluidPage(
    
    includeCSS("./custom_style.css"),
    
    theme = bslib::bs_theme(bootswatch = "darkly"),
    
    

    # Application title
    titlePanel("Word Prediction Using Markov Chains"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        mainPanel(textInput("user_input", label = "Enter Text for Prediction", placeholder = "Type Text Here")),
        sidebarPanel(h5("Predicted Word"),
                     textOutput("prediction"))
)))
