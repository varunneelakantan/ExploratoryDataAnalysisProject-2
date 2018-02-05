library('ggplot2')

if(!exists("nei")){
  nei <- readRDS("summarySCC_PM25.rds")
}
if(!exists("scc")){
  scc <- readRDS("Source_Classification_Code.rds")
}
if(!exists("neiscc")){
  neiscc <- merge(nei, scc, by="SCC")
}

subnei <- nei[nei$fips=="24510" & nei$type=="ON-ROAD",  ]
totalByYear <- aggregate(Emissions ~ year, subnei, sum)
png("plot5.png", width=840, height=480)
g <- ggplot(totalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") + xlab("YEar") + ylab("Emission") +
  ggtitle('Emissions from On-Road motor vehicle in Baltimore City from 1999 to 2008')
print(g)
dev.off()