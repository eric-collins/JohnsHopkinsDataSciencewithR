#library import 
library(ggplot2)

#Read in the data
class_codes <- readRDS("Source_Classification_Code.rds")
master <- readRDS("summarySCC_PM25.rds")

#Subset the data
baltimore <- subset(master, master$fips == "24510")

#Open a PNG
png("plot3.png", width = 480, height = 480)

#Generate the graph
ggplot(data = baltimore, 
       mapping = aes(y = Emissions, x = year, color = type, group = type)) + 
        stat_summary(fun = "sum", geom = "line")

#Close the PNG
dev.off()