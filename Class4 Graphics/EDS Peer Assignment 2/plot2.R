#Read in the data
class_codes <- readRDS("Source_Classification_Code.rds")
master <- readRDS("summarySCC_PM25.rds")

#Subset the data and calculate the sums across the years again. 
baltimore <- subset(master, master$fips == "24510")
summed_emission <- tapply(baltimore$Emissions, baltimore$year, sum)
years <- unique(baltimore$year)
#Open a png
png("plot2.png", width = 480, height = 480)
#Develop the plot
par(mar = c(2.5,4,1,.5))
plot(summed_emission~years, type = "l")

#Close the png
dev.off()