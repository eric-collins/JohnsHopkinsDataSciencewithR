library(ggplot2)

#Read in the data
class_codes <- readRDS("Source_Classification_Code.rds")
master <- readRDS("summarySCC_PM25.rds")

#Subset the class codes to just the columns I need. 
sub_class_codes <- subset(class_codes, select = c("SCC", "EI.Sector"))

#Merge and subset the dataframes to get what we need
working_df <- merge(master, sub_class_codes, "SCC")
working_df2 <- subset(working_df, grepl("Coal", working_df$EI.Sector))

#Open a png
png("plot4.png", width = 480, height = 480)

#Generate the plot
ggplot(data = working_df2, 
       mapping = aes(y = Emissions, x = year, color = EI.Sector, group = EI.Sector)) + 
        stat_summary(fun = "sum", geom = "line")

#Close the PNG
dev.off()