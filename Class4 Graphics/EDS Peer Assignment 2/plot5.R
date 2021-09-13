library(ggplot2)

#Read in the data
class_codes <- readRDS("Source_Classification_Code.rds")
master <- readRDS("summarySCC_PM25.rds")

#Subset the class codes to just the columns I need. 
sub_class_codes <- subset(class_codes, select = c("SCC", "EI.Sector"))
working_df <- merge(master, sub_class_codes, "SCC")

#Subset the dataframe
working_df2 <- subset(working_df, grepl("On-Road", working_df$EI.Sector))
baltimore <- subset(working_df2, working_df2$fips == "24510")

#Open a png
png("plot5.png", width = 480, height = 480)

#Generate the plot
ggplot(data = baltimore, 
       mapping = aes(y = Emissions, x = year, color = EI.Sector, group = EI.Sector)) + 
        stat_summary(fun = "sum", geom = "line")

#Close the PNG
dev.off()