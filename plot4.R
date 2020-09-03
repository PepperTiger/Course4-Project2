## Read data
nei = readRDS("summarySCC_PM25.rds")
scc = readRDS("Source_Classification_Code.rds")
scc$SCC = as.character(scc$SCC)

## Install necessary packages
if(!require("ggplot2")) install.packages("ggplot2")

## Tidy useful data
scc_cid = scc[grep(pattern = "(C|c)oal", scc$SCC.Level.Three),]
nei_cid = nei[nei$SCC == scc_cid$SCC,]
nei_sum = tapply(nei_cid$Emissions, nei_cid$year, sum)
nei_sum = data.frame(year = dimnames(nei_sum), emissions = nei_sum, stringsAsFactors = FALSE)
colnames(nei_sum)[1] = "year"
nei_sum$year = as.numeric(nei_sum$year)

## Make and save plot
library(ggplot2)
ggplot(nei_sum, aes(year, emissions)) +
  geom_point() +
  geom_line() +
  labs(x = "Year") +
  labs(y = "PM2.5 Emissions (tons)") +
  scale_x_continuous(breaks = seq(1999, 2008, 3)) +
  ggtitle("Total PM2.5 emissions/year from coal combustion-related sources")
ggsave("plot4.png", width = 6, height = 6)