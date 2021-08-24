#Input the state and the desired outcome, and return the state the hospital in that state with the lowest number of that outcome. 
#Does not take into account hospitals who have NA's for that outcome. 
best <- function(state, outcome) {
        
        library(readr)
        library(tidyverse)
        
        outcomes <- read.csv("outcome-of-care-measures.csv")
        
        names(outcomes)[11] <- "heart attack"
        names(outcomes)[17] <- "heart failure"
        names(outcomes)[23] <- "pneumonia"
        
        
        bystate <- split(outcomes, outcomes$State)
        
        inputoutcomes <- c("heart attack", "heart failure", "pneumonia")
        ## Check that state and outcome are valid
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
        
        
        ## Return hospital name in that state with lowest 30-day death
        ## rate
        statedf <- bystate[[state]]
        
        statedf <- select(statedf, c("Hospital.Name", all_of(outcome)))
        
        statedf[[outcome]] <- as.numeric(statedf[[outcome]])
        
        statedf <- na.omit(statedf)
        
        statedf <- statedf[order(statedf[[outcome]], statedf["Hospital.Name"]),]
        
        head(statedf$Hospital.Name, n=1)
}



