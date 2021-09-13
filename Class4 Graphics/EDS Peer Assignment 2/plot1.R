
#Read in the data
class_codes <- readRDS("Source_Classification_Code.rds")
master <- readRDS("summarySCC_PM25.rds")

#Generating the sum of emissions across the years
summed_emission <- tapply(master$Emissions, master$year, sum)
years <- unique(master$year)

#Open a png
png("plot1.png", width = 480, height = 480)
#Develop the graph
par(mar = c(2.5,4,1,.5))
plot(summed_emission~years, type = "l")
#Close the png
dev.off()