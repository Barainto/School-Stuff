setwd("C:/Users/Evan/Desktop/LIS4761")


library(ggplot2)
library(ggmap)

#Step 1: Load and clean the data
crimeDF <- read.csv(file = "Lab 7 - crimeInSYR-1.csv")
str(crimeDF)

#cleaning
names(crimeDF) <- c("type", "address", "city", "date")
crimeDF$date <- as.Date(crimeDF$date, "%m/%d/%y")
crimeDF$type <- as.character(crimeDF$type)
crimeDF$address <- as.character(crimeDF$address)
crimeDF$city <- as.character(crimeDF$city)

crimeDF$address_complete <- paste(crimeDF$address, crimeDF$city)
crimeDF$code <- geocode(crimeDF$address_complete)

#creating the map of syracuse
syr <- geocode("syracuse university, syracuse,ny")
syr

syr.map <- get_map(location = syr, zoom = 11)
syr.map

mapSimple <- ggmap(syr.map)
mapSimple

#plotting points on map
ggplot(crimeDF, aes(map_id = address_complete)) + geom_map(map = mapSimple) + geom_point(aes(x=lon, y= lat, fill = type))
