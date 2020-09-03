## Read data
nei = readRDS("summarySCC_PM25.rds")
scc = readRDS("Source_Classification_Code.rds")

## Install necessary packages
if(!require("ggplot2")) install.packages("ggplot2")
if(!require("reshape2")) install.packages("reshape2")

## Tidy useful data
library(reshape2)
nei = nei[nei$fips == "24510",]
nei_sum = data.frame(tapply(nei$Emissions, list(nei$year, nei$type), sum))
nei_sum = cbind(rownames(nei_sum), nei_sum)
colnames(nei_sum)[1] = "year"
nei_sum <- melt(nei_sum, variable.name = 'type')
nei_sum[,1] = as.integer(as.character(nei_sum[,1]))

## Make and save plot
library(ggplot2)
ggplot(nei_sum, aes(year, value)) +
  geom_line(aes(colour = type)) + 
  geom_point() +
  labs(x = "Year") +
  scale_x_continuous(breaks = seq(1999, 2008, 3)) +
  labs(y = "PM2.5 Emissions (tons)") +
  labs(colour = "Type") +
  scale_color_manual(
    labels = c("Non road", "Non point", "On road", "Point"), 
    values = c("blue", "red", "black", "green")) +
  ggtitle("Total PM2.5 emissions/year in Baltimore, according to source type")
ggsave("plot3.png", width = 6, height = 6)