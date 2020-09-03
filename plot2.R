## Read data
nei = readRDS("summarySCC_PM25.rds")
scc = readRDS("Source_Classification_Code.rds")

## Tidy useful data
nei = nei[nei$fips == "24510",]
nei_sum = tapply(nei$Emissions, nei$year, sum)

## Make and save plot
library(base)
png("plot2.png", width = 480, height = 480)
plot(dimnames(nei_sum)[[1]], nei_sum,
     type = "b",
     xlab = "Year", 
     ylab = "PM2.5 emissions (tons)",
     main = "Total PM2.5 emissions/year in Baltimore",
     xaxt = "n")
axis(1, at=seq(1999, 2008, by = 3), las=1)
dev.off()
