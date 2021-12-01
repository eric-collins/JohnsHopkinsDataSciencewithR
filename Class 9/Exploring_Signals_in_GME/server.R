#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$GME_Plot <- renderPlotly({
        
        library(plotly)
        library(quantmod)
        library(TTR)
        library(tidyverse)
        library(owmr)
        
        data <- getSymbols(input$ticker, source = 'yahoo', auto.assign = FALSE)
        
        df <- data.frame(Date = index(data), coredata(data))
        
        colnames(df) <- remove_prefix(df, c(input$ticker)) %>% names()
        
        df <- df %>%
            mutate(movement = if_else(Close >= Open, "Increasing", "Decreasing")) %>%
            mutate(avg_30 = SMA(Close, n = input$Short_Term_Moving),
                   avg_90 = SMA(Close, n = input$Long_Term_Moving)) %>%
            mutate(good_signal = if_else(avg_30 >= avg_90, 1, 0)) %>%
            mutate(buy = if_else(good_signal - lag(good_signal) == 1, 1, 0),
                   sell = if_else(good_signal - lag(good_signal) == -1, 1, 0)) %>%
            filter(Date >= "2020/06/01")
        
        buys <- df %>%
            filter(buy == 1)
        
        sell <- df %>%
            filter(sell == 1)
        
        i <- list(line = list(color = 'black'))
        d <- list(line = list(color = 'red'))
        
        df %>%
            plot_ly(x = ~Date, type = "candlestick",
                    open = ~Open, close = ~Close,
                    high = ~High, low = ~Low, name = input$ticker,
                    increasing = i, decreasing = d, width = 1000, height = 600) %>%
            add_lines(y = ~avg_30, name = "Closing Short Term MvgAvg",
                      line = list(color = 'cadetblue')) %>%
            add_lines(y = ~avg_90, name = "Closing Long Term MvgAvg",
                      line = list(color = 'blue')) %>%
            add_segments(x = buys$Date, xend = buys$Date, y = 0, yend = 500, line = list(color = "green"), name = "Buy Signal") %>%
            add_segments(x = sell$Date, xend = sell$Date, y = 0, yend = 500, line = list(color = "orange"), name = "Sell Signal") %>%
            layout(yaxis = list(title = "Price"))
        
        

        

    })

})
