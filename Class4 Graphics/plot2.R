#Library Imports
library(lubridate)

#Read in data and create a datetime object
df <- read.delim("household_power_consumption.txt", sep = ";")
num_df <- df
num_df$DateTime <- with(num_df, dmy(Date) + hms(Time))
num_df[,3:9] <- lapply(num_df[,3:9], as.numeric)

#Subset the data
output_df <- subset(num_df, num_df$DateTime > "2007-02-08 18:00:00")
output_df <- subset(output_df, output_df$DateTime < "2007-02-11")

#Open a pgn file
png("plot2.png", width = 480, height = 480)

#Plot plot2
plot(output_df$DateTime, output_df$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")

#close the png file
dev.off()