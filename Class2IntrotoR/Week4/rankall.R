rankall <- function(outcome, num = "best"){
        
        ##Read in data
        library(readr)
        library(tidyverse)
        
        outcomes <- read.csv("outcome-of-care-measures.csv")
        
        names(outcomes)[11] <- "heart attack"
        names(outcomes)[17] <- "heart failure"
        names(outcomes)[23] <- "pneumonia"
        
        ##Check state and outcome are valid
        inputoutcomes <- c("heart attack", "heart failure", "pneumonia")
        
        if(outcome %in% inputoutcomes){
        }
        else{
                stop("invalid outcome")   
        }
                        
        statedf <- outcomes[order(outcomes[[outcome]], outcomes$State, outcomes$Hospital.Name),]

                
        ##Return the df
        
        statedf <- split(statedf, statedf$State)
        
        append_df <- data.frame("Hosptial.Name" = character(), "State" = character(), outcome = numeric())

        for(state in statedf){
                
                state[[outcome]] <- as.numeric(state[[outcome]])
                working_df <- select(state, c('Hospital.Name','State', all_of(outcome)))
                working_df <- na.omit(working_df)
                
                if(num == "best"){
                        num <- 1
                }
                if(num == "worst"){
                        num <- length(working_df)
                }
                
                working_df <- working_df[num,]
                
                append_df[nrow(append_df) + 1,] = working_df[num,]
                
        }
        
        append_df
        
        
}