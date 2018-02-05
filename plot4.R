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


coalMatch  <- grepl("coal", neiscc$Short.Name, ignore.case=TRUE)
subneiscc <- neiscc[coalMatch, ]

totalByYear <- aggregate(Emissions ~ year, subneiscc, sum)
png("plot4.png", width=640, height=480)

g <- ggplot(totalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") + xlab("year") + ylab("Emission")
  ggtitle('Total Emissions from coal sources-1999 to 2008')

print(g)
dev.off()