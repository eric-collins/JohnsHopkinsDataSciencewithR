library(ggplot2)

#Read in the data
class_codes <- readRDS("Source_Classification_Code.rds")
master <- readRDS("summarySCC_PM25.rds")

#Subset the class codes to just the columns I need. 
sub_class_codes <- subset(class_codes, select = c("SCC", "EI.Sector"))
working_df <- merge(master, sub_class_codes, "SCC")

#Subset the dataframe
working_df2 <- subset(working_df, grepl("On-Road", working_df$EI.Sector))
baltimore_la <- subset(working_df2, working_df2$fips %in% c("24510", "06037"))

#Open a png
png("plot6.png", width = 480, height = 480)

#Generate the plot
ggplot(data = baltimore_la, 
       mapping = aes(y = Emissions, x = year, color = EI.Sector, group = EI.Sector)) + 
        stat_summary(fun = "sum", geom = "line") + facet_grid(cols = vars(baltimore_la$fips))

#Close the PNG
dev.off()