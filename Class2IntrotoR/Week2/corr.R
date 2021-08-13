corr <- function(directory, threshold = 0){
  
  library('dplyr')
  all_files <- list.files(dir, pattern = "*.csv", full.name = TRUE)
  df <- lapply(all_files, read.csv)
  
  correlations <- vector()
  
  i <- 1
  
  while (i <= length(df)) {
    
    working_frame <- as.data.frame(df[i])
    complete_frame <- working_frame[complete.cases(working_frame),]
    number_of_rows <- nrow(complete_frame)
    
    if (number_of_rows >= threshold){
      correlations[i] <- cor(complete_frame$sulfate, complete_frame$nitrate)
    }
    
    
    
    
    i <- i + 1
  }
  
  correlations
  
  
}


# dir <- "C:\\Users\\emcollin\\OneDrive - Volusia County Schools\\Desktop\\R projects\\studious-lamp\\specdata\\"
# 
# cr <- corr(dir, 400)
# summary(cr)
# length(cr)
# 
# 
# threshold <- 0
# 
# 
# library('dplyr')
# all_files <- list.files(dir, pattern = "*.csv", full.name = TRUE)
# df <- lapply(all_files, read.csv)
# 
# #corr_df <- data.frame(correlations = NA)
# 
# i <- 1
# 
# while (i <= length(df)) {
#   
#   working_frame <- as.data.frame(df[i])
#   complete_frame <- working_frame[complete.cases(working_frame),]
#   # number_of_rows <- nrow(complete_frame)
#   # 
#   # coor_df[i,1] = number_of_rows
#   #appended_df[i,2] = number_of_rows
#   
#   # if (number_of_rows >= threshold){
#   #   corr_df[i,1] = cor(complete_frame$sulfate, complete_frame$nitrate)
#   #   
#   i <- i + 1 
#   }
#   
#   
#   
# 
# corr_df