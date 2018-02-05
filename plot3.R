
library('ggplot2')

if(!exists("nei")){
  nei <- readRDS("summarySCC_PM25.rds")
}
if(!exists("scc")){
  scc <- readRDS("Source_Classification_Code.rds")
}

Baltimore <- nei[nei$fips=="24510", ]

totalByYearAndType <- aggregate(Emissions ~ year + type, Baltimore, sum)
png("plot3.png", width=640, height=480)

g <- ggplot(totalByYearAndType, aes(year, Emissions, color = type))
g <- g + geom_line() + xlab("Year") + ylab('Emission') +
  ggtitle('Emissions in Baltimore 1999 to 2008')
print(g)
dev.off()
