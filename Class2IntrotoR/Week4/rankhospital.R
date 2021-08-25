rankhospital <- function(state, outcome, num = "best") {
        ##Reading in data
        library(readr)
        library(tidyverse)
        
        outcomes <- read.csv("outcome-of-care-measures.csv")
        
        names(outcomes)[11] <- "heart attack"
        names(outcomes)[17] <- "heart failure"
        names(outcomes)[23] <- "pneumonia"
        
        ##Check state and outcome are valid
        inputoutcomes <- c("heart attack", "heart failure", "pneumonia")

        if(state %in% outcomes$State){
        }
        else{
                stop("invalid state")
        }
        if(outcome %in% inputoutcomes){
        }
        else{
                stop("invalid outcome")
        }
        
        ## Return hospital in that state with the given rank
        
        bystate <- split(outcomes, outcomes$State)
        
        statedf <- bystate[[state]]
        
        statedf <- select(statedf, c("Hospital.Name", all_of(outcome)))
        
        statedf[[outcome]] <- as.numeric(statedf[[outcome]])
        
        statedf <- na.omit(statedf)
        
        if(num == "best"){
                num <- 1
        }
        if(num == "worst"){
                num <- nrow(statedf)
        }
        
        statedf <- statedf[order(statedf[[outcome]], statedf$Hospital.Name),]
        
        
        statedf[num,]
        
}