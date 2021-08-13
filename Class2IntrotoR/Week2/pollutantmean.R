#Write a function named 'pollutantmean' that calculates the mean of a pollutant 
#(sulfate or nitrate) across a specified list of monitors. The function 'pollutantmean' 
#takes three arguments: 'directory', 'pollutant', and 'id'. 
#Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' 
#particulate matter data from the directory specified in the 'directory' 
#argument and returns the mean of the pollutant across all of the monitors, 
#ignoring any missing values coded as NA. A prototype of the function is as follows

pollutantmean <- function(dir, pollutant = "sulfate", id = 1:332){
  
  library('dplyr')
  all_files <- list.files(dir, pattern = "*.csv", full.name = TRUE)
  needed_files <- all_files[id]
  df <- lapply(needed_files, read.csv)
  df <- bind_rows(df, .id = "column_label")
  df <- na.omit(df)
  
  if(pollutant == "sulfate"){
    column_id <- 3
  }
  else{
    column_id <- 4
  }
  
  final_column <- df[,column_id]
  mean_poll <- mean(final_column)
  
  
}
# 
# 
# dir <-"C:\\Users\\emcollin\\OneDrive - Volusia County Schools\\Desktop\\R projects\\studious-lamp\\specdata\\"
# 
# df1 <- pollutantmean(dir, "sulfate",  id = 1:10)
# 
# df1





