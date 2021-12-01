#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Exploring Signals in The Stock Market"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h1("Inputs"),
            p("Type in a stock ticker and adjust your moving averages!"),
            textInput("ticker", "Ticker for Display", value = "GME"),
            sliderInput("Short_Term_Moving",
                        "Short Term Number of Days:",
                        min = 1,
                        max = 100,
                        value = 30),
            
            sliderInput("Long_Term_Moving",
                        "Long Term Number of Days:",
                        min = 90,
                        max = 150,
                        value = 90)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotlyOutput("GME_Plot")
        )
    )
))
