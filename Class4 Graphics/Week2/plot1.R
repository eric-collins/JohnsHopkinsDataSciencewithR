#Read in the data, make Date a date object, make everything else a number
df <- read.delim("household_power_consumption.txt", sep = ";")
num_df <- df
num_df$DateTime <- with(num_df, dmy(Date) + hms(Time))
num_df[,3:9] <- lapply(num_df[,3:9], as.numeric)

output_df <- subset(num_df, num_df$DateTime > "2007-02-08 18:00:00")
output_df <- subset(output_df, output_df$DateTime < "2007-02-11")

#Global Active Power Hist
#open the png file
png("plot1.png", width = 480, height = 480)

#generate the graph
hist(output_df$Global_active_power, breaks = 20, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
     
#close the png
dev.off()
