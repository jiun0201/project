# Data description
# A complete ranking of all countries over the last 48 hours 
# compared with the preceding 48 hours. 
# The "Change" column reports the increase or decrease in 
# the total raw number of articles mentioning Material Conflict events in that country
# The "Coverage Volume" column displays the actual raw counts 
# (Last 48 Hours / Previous 48 Hours)
# Finally, the "Coverage Rank" column ranks each country based on 
# the total raw volume of articles, with 1 being the country with 
# the most articles, and displays its rank (Last 48 Hours / Previous 48 Hours) 
# and change between the last and previous 48 hours.

#Data cleaning
rank <- read.csv("countryranking.csv", header=TRUE, sep=",")
sapply(rank, class)
rank <- data.frame(lapply(rank, as.character), stringsAsFactors=FALSE)

library(stringr) 
# str_split_fixed (input character vector, a single pattern, number of pieces)
cvg <- data.frame(str_split_fixed(rank$Coverage.Volume, "/",2))
names(cvg) <- c("cv1", "cv2")
newrank <- cbind(rank, cvg)
newrank$Coverage.Volume <- NULL


cvgRank <- data.frame(str_split_fixed(rank$Coverage.Rank, "/", 2))
names(cvgRank) <- c("cr1", "cr2")
cr2 <- data.frame(str_extract(cvgRank$cr2, "\\d{1,9}"))
newrank <- cbind(newrank, cvgRank[,1], cr2)
newrank <- newrank[-3]
rm(cvg, cr2, cvgRank)

sapply(newrank, class)

newrank[,2] <- as.numeric(newrank[,2])
newrank[,3] <- as.numeric(as.character(newrank[,3]))
newrank[,4] <- as.numeric(as.character(newrank[,4]))
newrank[,5] <- as.numeric(as.character(newrank[,5]))
newrank[,6] <- as.numeric(as.character(newrank[,6]))

names(newrank) <- c("Country","VolChange","VolMar23.24", 
                 "VolMar21.22", "RankMar23.24", "RankMar21.22")

# EDA
require(ggplot2)
library(gridExtra)

newrank2 <- newrank1 <- data.frame(Country=rownames(newrank), newrank, row.names=NULL)
#mtcars3$cyl  <- mtcars2$cyl <- as.factor(mtcars2$cyl)
#head(mtcars2)

## An Example of Unordered Bars/Points

library(ggplot2)
library(gridExtra)
x <- ggplot(newrank2, aes(y=Country, x=RankMar23.24)) + 
  geom_point(stat="identity")

y <- ggplot(newrank2, aes(x=Country, y=RankMar23.24)) + 
  geom_bar(stat="identity") + 
  coord_flip()

grid.arrange(x, y, ncol=2)


## An Example of Ordered Bars/Points
## Re-level the cars by mpg
newrank2$Country <- factor(newrank1$Country, 
                           levels=newrank1[order(newrank2$RankMar23.24), "Country"])

x <- ggplot(newrank2, aes(y=Country, x=RankMar23.24)) + 
  geom_point(stat="identity")

y <- ggplot(newrank2, aes(x=Country, y=RankMar23.24)) + 
  geom_bar(stat="identity") + 
  coord_flip()

grid.arrange(x, y, ncol=2)

# Too many countries  
# IDEA1 draw top 10 countries in Rank23.24 and Rank21.22

# order data by Vol23.24 (to see Last 48 hours top 10 coveraged countries)
VolL <- newrank[order(-newrank[,3]),]
# subset top 30
VolL30 <- VolL[1:30,]

VolL30$Country <- factor(VolL30$Country, 
                           levels=VolL30[order(VolL30$VolMar23.24), "Country"])

x <- ggplot(VolL30, aes(x=Country, y=VolMar23.24)) + 
geom_bar(stat="identity", position=position_dodge()) + 
  xlab("Country") + 
  ylab("Total number of articles of Material Conflict Events") + 
  labs(title = "Top 30 countries Coverage Volume from 23 to 24 March") +
  coord_flip()

# order data by Vol21.22 (to see previous 48 hours top 10 coveraged countries)
VolP <- newrank[order(-newrank[,4]),]
VolP30 <- VolP[1:30,]
VolP30$Country <- factor(VolP30$Country, 
                         levels=VolP30[order(VolP30$VolMar21.22), "Country"])

y <- ggplot(VolP30, aes(x=Country, y=VolMar21.22)) + 
  geom_bar(stat="identity", position=position_dodge()) + 
  xlab("Country") + 
  ylab("Total number of articles of Material Conflict Events") + 
  labs(title = "Top 30 countries Coverage Volume from 21 to 22 March") +
  coord_flip()

grid.arrange(x, y, ncol=2)

# order data by Volchange (to see top 10 emerging coveraged countries)
VolC<- newrank[order(-abs(newrank[,2])),]
VolC30 <- VolC[1:30,]
VolC30$Country <- factor(VolC30$Country, 
                         levels=VolC30[order(VolC30$VolChange), "Country"])

ggplot(VolC30, aes(x=Country, y=VolChange)) + 
  geom_bar(stat="identity") + 
  xlab("Country") + 
  ylab("Volume Change of Material Conflict Events") + 
  labs(title = "Top 30 countries Coverage Volume Change") +
  coord_flip()

#order data by 
RankL <- newrank[order(-newran)]

# two World map with volumn c
#install.packages("joinCountryData2Map")
#install.packages("rworldmap")
library(rworldmap)
map <- joinCountryData2Map(newrank,  joinCode="NAME", nameJoinColumn = "Country", verbose=TRUE)

temp = getMap(resolution='coarse')
countrylist <- list(temp@data[,9])

newrank[91,1] <- "Gaza"
newrank[102,1] <- "Vietnam"
#identifyCountries(getMap(), nameColumnToPlot="Country")
par(mfrow=c(1,1))
mapCountryData(map,nameColumnToPlot='VolMar23.24')
mapCountryData(map,nameColumnToPlot='VolMar21.22')
mapCountryData(map,nameColumnToPlot='VolChange')

country2Region(newrank
               ,nameDataColumn="VolChange"
               ,joinCode="NAME"
               ,nameJoinColumn="Country"
               ,regionType="Stern"
               ,FUN="mean")

mapBubbles(newrank=getMap()
           ,nameZSize="VolChange"
           ,nameZColour="Volchange"
           ,colourPalette="rainbow"
           ,oceanCol="lightblue"
           ,landCol="wheat")









library(maps)
world <- map("world", plot=F)
map.world <- map("world", plot=F, fill=T)
list.names.world <- strsplit(map.world$names,":")
tail(list.names.world)
map.IDs <- sapply(list.names.world, function(x) x[1])
tail(map.IDs)
world <- map2SpatialPolygons(map.world, IDs=map.IDs, proj4string = CRS("+proj=longlat"))
library(maptools)
summary(world)
plot(world)

library(rgdal)
world.laea <- spTransform(world, CRS("+proj=laea +lat_0=0 +lon_0=0"))
plot(world.laea)

sp.IDs <- sapply(slot(world.laea, "polygons"), function(x) slot(x, "ID"))
tail(sp.IDs)


world.newrank <- SpatialPolygonsDataFrame(world,newrank)
summary(states.sat)

