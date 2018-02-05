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

subnei <-  nei[(nei$fips=="24510"|nei$fips=="06037") & nei$type=="ON-ROAD",  ]

totalByYearAndFips <- aggregate(Emissions ~ year + fips, subnei, sum)
totalByYearAndFips$fips[totalByYearAndFips$fips=="24510"] <- "Baltimore, MD"
totalByYearAndFips$fips[totalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width=1040, height=480)
g <- ggplot(totalByYearAndFips, aes(factor(year), Emissions)) + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  + xlab("year") + ylab("Emissions") + 
  ggtitle('Total Emissions from On-Road motor vehicle in Baltimore City vs Los Angeles -  1999-2008')
print(g)
dev.off()