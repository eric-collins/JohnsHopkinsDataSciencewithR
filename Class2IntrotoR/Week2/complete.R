complete <- function(directory, id = 1:332){
  
  library('dplyr')
  all_files <- list.files(dir, pattern = "*.csv", full.name = TRUE)
  needed_files <- all_files[id]
  df <- lapply(needed_files, read.csv)
  
  appended_df <-  data.frame(ID = id, nobs = NA)
  
  i <- 1
  
  while (i <= length(df)) {
    
    working_frame <- as.data.frame(df[i])
    complete_frame <- na.omit(working_frame)
    number_of_rows <- nrow(complete_frame)
    
    appended_df[i,2] <- number_of_rows
    
    i <- i + 1
  }
    appended_df
}
# 
#  dir <-"C:\\Users\\emcollin\\OneDrive - Volusia County Schools\\Desktop\\R projects\\studious-lamp\\specdata\\"
# # 
# output <- complete(dir, 3)
# output
# 
# id <- 1:10
# library('dplyr')
# all_files <- list.files(dir, pattern = "*.csv", full.name = TRUE)
# needed_files <- all_files[id]
# df <- lapply(needed_files, read.csv)
# 
# appended_df <- data.frame(ID = id)
# 
# i <- 1
# 
# while (i < length(df)) {
#   
#   working_frame <- as.data.frame(df[i])
#   complete_frame <- na.omit(working_frame)
#   number_of_rows <- nrow(complete_frame)
#   
#   appended_df[i,] = number_of_rows
#   
#   
#   i <- i + 1
# }

