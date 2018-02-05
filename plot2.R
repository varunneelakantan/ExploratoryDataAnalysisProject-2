library('data.table')

if(!exists("nei")){
  nei <- readRDS("summarySCC_PM25.rds")
}
if(!exists("scc")){
  scc <- readRDS("Source_Classification_Code.rds")
}

df <- data.table(nei)

baltimore <- subset(df, fips == '24510')

year <- baltimore[, list(emissions=sum(Emissions)), by=year]
year$year = as.numeric(as.character(year$year))
year$emissions = as.numeric(as.character(year$emissions))

plot(year$year, year$emissions, type='l', ylab='Emissions', xlab='Year')

dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()