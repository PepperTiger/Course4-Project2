## Read data
nei = readRDS("summarySCC_PM25.rds")
scc = readRDS("Source_Classification_Code.rds")

## Install necessary packages
if(!require("ggplot2")) install.packages("ggplot2")
if(!require("reshape2")) install.packages("reshape2")

## Tidy useful data
library(reshape2)
nei_cid = nei[nei$type == "ON-ROAD" & (nei$fips == "06037" | nei$fips == "24510"),]
nei_sum = tapply(nei_cid$Emissions, list(nei_cid$year, nei_cid$fips), sum)
nei_sum = melt(nei_sum, variable.name = 'fips')
nei_sum[,2] = as.character(nei_sum[,2])
colnames(nei_sum) = c("year", "fips", "value")

## Make and save plot
library(ggplot2)
ggplot(nei_sum, aes(year, value)) +
  geom_line(aes(colour = fips)) +
  geom_point() +
  labs(x = "Year") +
  scale_x_continuous(breaks = seq(1999, 2008, 3)) +
  labs(y = "PM2.5 Emissions (tons)") +
  labs(colour = "County") +
  scale_color_manual(
    labels = c("Baltimore", "Los Angeles"), 
    values = c("blue", "red")) +
  ggtitle("Total PM2.5 emissions/year in Baltimore and Los Angeles")
ggsave("plot6.png", width = 6, height = 6)