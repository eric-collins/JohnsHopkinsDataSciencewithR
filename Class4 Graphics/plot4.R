#Read in and subset the data
df <- read.delim("household_power_consumption.txt", sep = ";")
num_df <- df
num_df$DateTime <- with(num_df, dmy(Date) + hms(Time))
num_df[,3:9] <- lapply(num_df[,3:9], as.numeric)

output_df <- subset(num_df, num_df$DateTime > "2007-02-08 18:00:00")
output_df <- subset(output_df, output_df$DateTime < "2007-02-11")

#Open the PNG
png("plot4.png", width = 480, height = 480)

#Generate the grid
par(mfrow = c(2,2))

#Plot our current plots
plot(output_df$DateTime, output_df$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")

plot(output_df$DateTime, output_df$Voltage, type = "l", xlab = "", ylab = "Voltage")


plot(output_df$DateTime, output_df$Sub_metering_1, type = "s",
     xlab = "", ylab = "Energy Submetering", ylim = c(0,50))

lines(output_df$DateTime, output_df$Sub_metering_2, type = "s", col = "red")
lines(output_df$DateTime, output_df$Sub_metering_3, type = "s", col = "blue")

legend(x = "topright", legend = c("Submetering 1", "Submetering 2", "Submetering 3"),
       lty = 1, 
       col = c("black", "red", "blue"), 
       xjust = 1, yjust = 1)


plot(output_df$DateTime, output_df$Global_reactive_power, ylab = "Global Reactive Power", type = "l", xlab = "")

#Close the png
dev.off()
